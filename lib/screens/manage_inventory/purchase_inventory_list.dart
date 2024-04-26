import 'package:d_manager/api/inventory_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/inventory_models/purchase_inventory_list_model.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/loader.dart';
import 'package:d_manager/screens/widgets/no_record_found.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchaseInventoryList extends StatefulWidget {
  const PurchaseInventoryList({Key? key}) : super(key: key);

  @override
  _PurchaseInventoryListState createState() => _PurchaseInventoryListState();
}

class _PurchaseInventoryListState extends State<PurchaseInventoryList> {
  List<PurchaseInventoryDetail> inventories = [];
  int currentPage = 1;
  var selectedStartDate;
  var selectedEndDate;
  DateTime firstDate = DateTime(2000);
  DateTime lastDate = DateTime(2050);
  DateTime? firstDateForPurchase = DateTime.now();
  DateTime? lastDateForPurchase = DateTime.now().add(const Duration(days: 7));
  final searchController = TextEditingController();
  final _controller = ScrollController();
  int totalItems = 0;
  bool isLoadingMore = false;
  bool isLoading = false;
  bool isNetworkAvailable = true;
  bool isFilterApplied = false;
  ManageInventoryServices inventoryServices = ManageInventoryServices();
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = !isLoading;
    });
    _loadData(currentPage, searchController.text.trim());
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (totalItems > inventories.length && !isLoadingMore) {
          currentPage++;
          isLoadingMore = true;
          _loadData(currentPage, searchController.text.trim());
        }
      }
    });
  }
  @override
  void dispose() {
    searchController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.height15),
      child: isLoading == true ? const CustomLoader() : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                    isFilled: false,
                    controller: searchController,
                    hintText: S.of(context).searchHere,
                    prefixIcon: Icons.search,
                    suffixIcon: Icons.close,
                    borderRadius: Dimensions.radius10,
                    borderColor: AppTheme.primary,
                    onSuffixTap: () {
                      setState(() {
                        searchController.clear();
                        inventories.clear();
                        currentPage = 1;
                        _loadData(currentPage, searchController.text.trim());
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        inventories.clear();
                        currentPage = 1;
                        _loadData(currentPage, value);
                      });
                    }
                ),
              ),
              SizedBox(width: Dimensions.width20),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  CustomIconButton(
                      radius: Dimensions.radius10,
                      backgroundColor: AppTheme.primary,
                      iconColor: AppTheme.white,
                      iconData: Icons.date_range,
                      onPressed: () async {
                        DateTimeRange? pickedDateRange = await showDateRangePicker(
                          initialEntryMode: DatePickerEntryMode.input,
                          helpText: S.of(context).selectDate,
                          context: context,
                          initialDateRange: DateTimeRange(
                            start: DateTime.now(),
                            end: DateTime.now().add(const Duration(days: 7)),
                          ),
                          firstDate: firstDate,
                          lastDate: lastDate,
                        );

                        if (pickedDateRange != null) {
                          DateTime startDateForPurchaseHistory = pickedDateRange.start;
                          DateTime endDateForPurchaseHistory = pickedDateRange.end;
                          String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDateForPurchaseHistory);
                          String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDateForPurchaseHistory);
                          setState(() {
                            firstDateForPurchase = startDateForPurchaseHistory;
                            lastDateForPurchase = endDateForPurchaseHistory;
                            selectedStartDate = formattedStartDate;
                            selectedEndDate = formattedEndDate;
                            isFilterApplied = true;
                          });
                          inventories.clear();
                          currentPage = 1;
                          _loadData(currentPage, searchController.text.trim());
                        }
                      }
                  ),
                  isFilterApplied == false ? Container() : GestureDetector(
                    onTap: () {
                      setState(() {
                        isFilterApplied = false;
                        selectedStartDate = null;
                        selectedEndDate = null;
                      });
                      inventories.clear();
                      currentPage = 1;
                      _loadData(currentPage, searchController.text.trim());
                    },
                    child: Container(
                      width: Dimensions.height20,
                      height: Dimensions.height20,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.clear, color: AppTheme.primary, size: 12),
                    ),
                  ),
                ],
              ),
            ]
          ),
          SizedBox(height: Dimensions.height10),
          Expanded(
            child: (inventories.isEmpty && isLoading == false) ? const NoRecordFound() : ListView.builder(
              controller: _controller,
              itemCount: inventories.length + 1,
              itemBuilder: (context, index) {
                if (index < inventories.length) {
                  var inventory = inventories[index];
                  return CustomAccordionWithoutExpanded(
                    titleChild: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                SizedBox(width: Dimensions.width10),
                                CircleAvatar(
                                  backgroundColor: AppTheme.secondary,
                                  radius: Dimensions.height20,
                                  child: BigText(text: inventory.yarnName![0], color: AppTheme.primary, size: Dimensions.font18),
                                ),
                                SizedBox(width: Dimensions.height10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: Dimensions.screenWidth * 0.5,
                                        child: BigText(text: inventory.yarnName!, color: AppTheme.primary, size: Dimensions.font16)
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppTheme.black,
                                          radius: Dimensions.height10,
                                          child: BigText(text: inventory.typeName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        SizedBox(
                                            width: Dimensions.screenWidth * 0.5,
                                            child: SmallText(text: inventory.typeName!, color: AppTheme.black, size: Dimensions.font12)
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        AppTheme.divider,
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Delivery Date', inventory.deliveryDate!.toString() ?? 'N/A'),
                            _buildInfoColumn('Net Weight', '${inventory.netWeight} kg' ?? 'N/A'),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.deliveryDetailView, arguments: {'deliveryID': inventory.purchaseDeliveryId.toString(), 'purchaseID' : inventory.purchaseId.toString()});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(Dimensions.width10/1.5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppTheme.primary, width: 1),
                                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                                  ),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BigText(text: 'View', color: AppTheme.primary, size: Dimensions.font12),
                                        BigText(text: 'Details', color: AppTheme.primary, size: Dimensions.font14),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    contentChild: Container(),
                  );
                } else {
                  return const SizedBox(height: 0);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    String formattedValue = value;
    if (title.contains('Date') && value != 'N/A' && value != '' && value != null) {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd MMM yy').format(date);
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.grey, size: Dimensions.font12),
          BigText(text: formattedValue, color: AppTheme.primary, size: Dimensions.font14),
        ],
      ),
    );
  }

  Future<void> _loadData(int pageNo, String search) async {
    try {
      setState(() {
        isLoading = true;
      });
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        PurchaseInventoryListModel? inventoryListModel = await inventoryServices.purchaseInventoryList(
            pageNo, search,
          selectedStartDate,
          selectedEndDate,);
        if (inventoryListModel != null) {
          if (inventoryListModel.success == true) {
            if (inventoryListModel.data!.isNotEmpty) {
              if (pageNo == 1) {
                inventories.clear();
              }

              setState(() {
                totalItems = inventoryListModel.total ?? 0;
                inventories.addAll(inventoryListModel.data!);
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              inventoryListModel.message.toString(),
              mode: SnackbarMode.error,
            );
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            'Something went wrong, please try again later.',
            mode: SnackbarMode.error,
          );
        }
      } else {
        setState(() {
          isNetworkAvailable = false;
        });
      }
    } finally {
      setState(() {
        isLoading = false;
        isLoadingMore = false;
      });
    }
  }
}

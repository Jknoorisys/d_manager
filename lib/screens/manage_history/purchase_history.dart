import 'package:d_manager/api/manage_invoice_services.dart';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/models/dropdown_models/drop_down_party_list_model.dart';
import 'package:d_manager/models/dropdown_models/dropdown_film_list_model.dart';
import 'package:d_manager/models/history_models/export_history_model.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/no_record_found.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/manage_history_services.dart';
import '../../helpers/helper_functions.dart';
import '../../models/dropdown_models/dropdown_yarn_list_model.dart';
import '../../models/history_models/purchase_history_model.dart';
import '../manage_yarn_purchase/yarn_purchase_view.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/snackbar.dart';
import '../../api/dropdown_services.dart';
import '../../api/manage_firm_services.dart';
import '../../api/manage_party_services.dart';
class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({super.key});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  final searchController = TextEditingController();
  List<PurchaseHistoryList> purchaseHistoryList = [];

  ManageHistoryServices manageHistoryServices = ManageHistoryServices();
  bool isLoading = false;
  int currentPage = 1;
  final _controller = ScrollController();
  int totalItems = 0;
  bool isLoadingMore = false;

  ManageFirmServices firmServices = ManageFirmServices();

  ManagePartyServices partyServices = ManagePartyServices();

  DropdownServices dropdownServices = DropdownServices();

  var selectedFirm;
  var selectedParty;
  var selectedYarn;
  DateTime firstDate = DateTime(2000);
  DateTime lastDate = DateTime(2050);
  var selectedStartDate;
  var selectedEndDate;
  DateTime? firstDateForPurchase = DateTime.now();
  DateTime? lastDateForPurchase = DateTime.now().add(const Duration(days: 7));
  List<Firm> firms = [];
  List<Party> parties = [];
  List<Yarn> yarns = [];
  bool isFilterApplied = false;
  bool isNetworkAvailable = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = !isLoading;
    });
    getPurchaseHistory(currentPage, searchController.text.trim());
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (totalItems > purchaseHistoryList.length && !isLoadingMore) {
          currentPage++;
          isLoadingMore = true;
          getPurchaseHistory(currentPage, searchController.text.trim());
        }
      }
    });
    _getFirms();
    _getParties();
    _getYarns();
  }

  @override
  void dispose() {
    searchController.dispose();
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          isLoading: isLoading,
          internetNotAvailable: isNetworkAvailable,
          title: S.of(context).purchaseHistory,
          filterButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Map<String, dynamic> body = {
                    'user_id': HelperFunctions.getUserID(),
                    // 'page_no': currentPage.toString(),
                    'search' : searchController.text.trim() == '' ? '' : searchController.text.trim(),
                    "firm_id" : selectedFirm != null ? selectedFirm.toString() : "",
                    'party_id' : selectedParty != null ? selectedParty.toString() : "",
                    'yarn_type_id' : selectedYarn != null ? selectedYarn.toString() : "",
                    'start_date' : selectedStartDate != null ? selectedStartDate.toString() : "",
                    'end_date' : selectedEndDate != null ? selectedEndDate.toString() : "",
                  };
                  _exportPurchaseHistory(body);
                },
                  child: const Icon(Icons.print, color: AppTheme.black)
              ),
              SizedBox(width: Dimensions.width20),
              GestureDetector(
                onTap: () {
                  _showBottomSheet(context);
                },
                child: const FaIcon(FontAwesomeIcons.sliders, color: AppTheme.black),
              ),
            ],
          ),
          content: Padding(
            padding: EdgeInsets.all(Dimensions.height15),
            child:
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextField(
                          isFilled: false,
                          controller: searchController,
                          hintText: 'Search here...',
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.close,
                          borderRadius: Dimensions.radius10,
                          borderColor: AppTheme.primary,
                          onSuffixTap: () {
                            setState(() {
                              searchController.clear();
                              purchaseHistoryList.clear();
                              currentPage = 1;
                              getPurchaseHistory(currentPage, searchController.text.trim());
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              purchaseHistoryList.clear();
                              currentPage = 1;
                              getPurchaseHistory(currentPage, value);
                            });
                          }
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                AppTheme.divider,
                Expanded(
                  child: (purchaseHistoryList.isEmpty && isLoading == false) ? const NoRecordFound() : ListView.builder(
                    itemCount: purchaseHistoryList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < purchaseHistoryList.length) {
                        return CustomAccordion(
                          titleChild: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    SizedBox(height: Dimensions.height10),
                                    Flexible(
                                      child: Row(
                                        children: [
                                          SizedBox(width: Dimensions.width10),
                                          CircleAvatar(
                                            backgroundColor: AppTheme.secondary,
                                            radius: Dimensions.height20,
                                            child: BigText(text: purchaseHistoryList[index].partyName![0], color: AppTheme.primary, size: Dimensions.font18),
                                          ),
                                          SizedBox(width: Dimensions.height10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  width : Dimensions.screenWidth * 0.5,
                                                  child: BigText(text: purchaseHistoryList[index].partyName!, color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,)),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: AppTheme.black,
                                                    radius: Dimensions.height10,
                                                    child: BigText(text: purchaseHistoryList[index].firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                                  ),
                                                  SizedBox(width: Dimensions.width10),
                                                  SizedBox(
                                                      width : Dimensions.screenWidth * 0.5,
                                                      child: SmallText(text: purchaseHistoryList[index].firmName!, color: AppTheme.black, size: Dimensions.font12)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height10),
                                  ],
                                ),
                              ),
                              SizedBox(height: Dimensions.height10),
                              AppTheme.divider,
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  Expanded(flex:1,child: _buildInfoColumn('Deal Date', purchaseHistoryList[index].deliveryDate ?? 'N/A')),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Yarn Name', purchaseHistoryList[index].yarnName!)),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Net Weight', purchaseHistoryList[index].netWeight != null ? '${purchaseHistoryList[index].netWeight} Kg' : 'N/A')),
                                ],
                              ),
                            ],
                          ),
                          contentChild: Column(
                            children: [
                              SizedBox(height: Dimensions.height10),
                              // Row(
                              //   children: [
                              //     Expanded(flex:1,child: _buildInfoColumn('Lot Number', purchaseHistoryList[index].lotNumber ?? 'N/A')),
                              //     SizedBox(width: Dimensions.width20),
                              //     Expanded(flex:1,child: _buildInfoColumn('Total Box', purchaseHistoryList[index].orderedBoxCount ?? 'N/A')),
                              //     SizedBox(width: Dimensions.width20),
                              //     Expanded(flex:1,child: _buildInfoColumn('Box Received', purchaseHistoryList[index].deliveredBoxCount ?? 'N/A')),
                              //   ],
                              // ),
                              // SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  Expanded(flex:1,child: _buildInfoColumn('Rate', '₹${HelperFunctions.formatPrice(purchaseHistoryList[index].rate.toString())}')),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Payment Due Date', purchaseHistoryList[index].paymentDueDate!.toString())),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('', '')),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              // Row(
                              //   children: [
                              //     Expanded(flex:1,child: _buildInfoColumn('Bill Amount', purchaseHistoryList[index].totalBillAmount != null ? purchaseHistoryList[index].totalBillAmount.toString() : 'N/A')),
                              //     SizedBox(width: Dimensions.width20),
                              //     Expanded(flex:1,child: _buildInfoColumn('Amount Paid', purchaseHistoryList[index].totalPaidAmount != null ? purchaseHistoryList[index].totalPaidAmount.toString() : 'N/A')),
                              //     SizedBox(width: Dimensions.width20),
                              //     Expanded(flex:1,child: _buildInfoColumn('Deal Status', purchaseHistoryList[index].dealStatus!.toString() == 'completed' ? 'Completed' : 'On Going')),
                              //   ],
                              // ),
                              // SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width/2.65,
                                      height: Dimensions.height40*2,
                                      padding: EdgeInsets.all(Dimensions.height10),
                                      decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                        border: Border.all(color: AppTheme.primary),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          BigText(text: 'Total Gross Weight', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: AppTheme.primary,
                                                fontSize: Dimensions.font18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(text: purchaseHistoryList[index].grossWeight!,),
                                                TextSpan(
                                                  text: ' ton',
                                                  style: TextStyle(
                                                    fontSize: Dimensions.font12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                  SizedBox(width: Dimensions.width20),
                                  Container(
                                      width: MediaQuery.of(context).size.width/2.65,
                                      height: Dimensions.height40*2,
                                      padding: EdgeInsets.all(Dimensions.height10),
                                      decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                        border: Border.all(color: AppTheme.primary),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          BigText(text: 'Total Weight Received', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: AppTheme.primary,
                                                fontSize: Dimensions.font18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(text: purchaseHistoryList[index].grossWeight,),
                                                TextSpan(
                                                  text: ' ton',
                                                  style: TextStyle(
                                                    fontSize: Dimensions.font12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.height15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomElevatedButton(
                                    onPressed: (){
                                      // Navigator.pushNamed(context, AppRoutes.yarnPurchaseView, arguments: {'yarnPurchaseData': filteredPurchaseHistoryList[index]});
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => YarnPurchaseView(purchaseId:purchaseHistoryList[index].purchaseDeliveryId!.toString())));
                                    },
                                    buttonText: 'View Details',
                                    isBackgroundGradient: false,
                                    backgroundColor: AppTheme.primary,
                                    textSize: Dimensions.font14,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        )
    );
  }
  Widget _buildInfoColumn(String title, String value) {
    String formattedValue = value;
    if (title.contains('Date') && value != 'N/A' && value != '' && value != null) {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd MMM yy').format(date);
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.nearlyBlack, size: Dimensions.font12),
          BigText(text: formattedValue, color: AppTheme.primary, size: Dimensions.font14),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppTheme.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius20),
          topRight: Radius.circular(Dimensions.radius20),
        ),
      ),
      elevation: 10,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.all(Dimensions.height20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        tooltip: 'Apply Filters',
                        onPressed: () {
                          isLoading = true;
                          setState(() {
                            searchController.clear();
                            purchaseHistoryList.clear();
                            currentPage = 1;
                            isFilterApplied = true;
                            getPurchaseHistory(currentPage, '');
                          });
                          Navigator.of(context).pop();
                        },
                        icon: const FaIcon(FontAwesomeIcons.filter, color: AppTheme.black),
                      ),
                      BigText(text: 'Apply Filters', size: Dimensions.font20, color: AppTheme.black),
                      IconButton(
                        tooltip: 'Clear Filters',
                        onPressed: () {
                          setState(() {
                            selectedFirm = null;
                            selectedParty = null;
                            selectedYarn = null;
                            selectedStartDate = null;
                            selectedEndDate = null;
                            isFilterApplied = false;
                            purchaseHistoryList.clear();
                            currentPage = 1;
                            getPurchaseHistory(currentPage, '');
                          });
                          Navigator.of(context).pop();
                        },
                        icon: const FaIcon(FontAwesomeIcons.filterCircleXmark, color: AppTheme.black),
                      ),
                    ],
                  ),
                  Gap(Dimensions.height20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: 'Select My Firm', size: Dimensions.font12,),
                          Gap(Dimensions.height10/2),
                          CustomApiDropdown(
                              hintText: 'Select Firm',
                              dropdownItems: firms.map((e) => DropdownMenuItem<dynamic>(value: e.firmId!, child: BigText(text: e.firmName!, size: Dimensions.font14,))).toList(),
                              selectedValue: firms.any((firm) => firm.firmId == selectedFirm) ? selectedFirm : null,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedFirm = newValue!;
                                });
                              }
                          )
                        ],
                      ),
                      Gap(Dimensions.height10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: 'Select Party Name', size: Dimensions.font12,),
                          Gap(Dimensions.height10/2),
                          CustomApiDropdown(
                              hintText: 'Select Party',
                              dropdownItems: parties.map((e) => DropdownMenuItem<dynamic>(value: e.partyId!, child: BigText(text: e.partyName!, size: Dimensions.font14,))).toList(),
                              selectedValue: parties.any((party) => party.partyId == selectedParty) ? selectedParty : null,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedParty = newValue!;
                                });
                              }
                          )
                        ],
                      ),
                    ],
                  ),
                  Gap(Dimensions.height20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: 'Select Yarn Name', size: Dimensions.font12,),
                          Gap(Dimensions.height10/2),
                          CustomApiDropdown(
                              hintText: 'Select Yarn',
                              dropdownItems: yarns.map((e) => DropdownMenuItem<dynamic>(value: e.yarnTypeId!, child: BigText(text: e.yarnName!, size: Dimensions.font14,))).toList(),
                              selectedValue: yarns.any((yarn) => yarn.yarnTypeId == selectedYarn) ? selectedYarn : null,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedYarn = newValue!;
                                });
                              }
                          )
                        ],
                      ),
                      Gap(Dimensions.height10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: 'Filter by Date', size: Dimensions.font12,),
                          Gap(Dimensions.height10/2),
                          GestureDetector(
                            onTap: () async {
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
                                });
                              }
                            },
                            child: Container(
                              height: Dimensions.height50,
                              width: MediaQuery.of(context).size.width/2.65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius10),
                                color: Colors.white,
                                border: Border.all(color: AppTheme.black, width: 0.5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.height10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: BigText(text: '${DateFormat('dd/MM/yyyy').format(firstDateForPurchase!)} to ${DateFormat('dd/MM/yyyy').format(lastDateForPurchase!)}', size: Dimensions.font12,)),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Icon(
                                        Icons.calendar_month,
                                        color: Colors.black,
                                        size: Dimensions.iconSize20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _getFirms() async {
    DropdownFirmListModel? response = await dropdownServices.firmList();
    if (response != null) {
      setState(() {
        firms.addAll(response.data!);
      });
    }
  }

  Future<void> _getParties() async {
    DropdownPartyListModel? response = await dropdownServices.partyList();
    if (response != null) {
      setState(() {
        parties.addAll(response.data!);
      });
    }
  }

  Future<void> _getYarns() async {
    DropdownYarnListModel? response = await dropdownServices.yarnList();
    if (response != null) {
      setState(() {
        yarns.addAll(response.data!);
      });
    }
  }
  Future<void> getPurchaseHistory(int pageNo, String search) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        PurchaseHistoryModel? model = await manageHistoryServices.showPurchaseHistory(
          pageNo.toString(),
          search,
          selectedFirm,
          selectedParty,
          selectedYarn,
          selectedStartDate,
          selectedEndDate,
        );

        if (model != null) {
          if (model.success == true) {
            if (model.data != null) {
              if (model.data!.isNotEmpty) {
                if (pageNo == 1) {
                  purchaseHistoryList.clear();
                }
                setState(() {
                  purchaseHistoryList.addAll(model.data!);
                  totalItems = model.total ?? 0;
                });
              } else {
                setState(() {
                  isLoading = false;
                });
              }
            } else {
              setState(() {
                isLoading = false;
              });
            }
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              model.message.toString(),
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

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _exportPurchaseHistory(Map<String, dynamic> body) async {
    try {
      setState(() {
        isLoading = true;
      });

      ExportHistoryModel? historyModel = await ManageInvoiceServices().exportPurchaseHistory(body);
      print(historyModel);
      if (historyModel?.message != null) {
        if (historyModel?.success == true) {
          if (historyModel?.filePath != null) {
            _launchUrl(Uri.parse('$baseUrl/${historyModel?.filePath!}'));
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              'Unable to download invoice, please try again...',
              mode: SnackbarMode.error,
            );
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            historyModel!.message.toString(),
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again',
          mode: SnackbarMode.error,
        );
      }
    } catch (error) {
      CustomApiSnackbar.show(
        context,
        'Error',
        'An error occurred: $error',
        mode: SnackbarMode.error,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

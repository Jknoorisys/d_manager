import 'package:d_manager/api/unpaid_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/unpaid_models/unpaid_sell_model.dart';
import 'package:d_manager/screens/manage_history/unpaid_history/unpaid_provider.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/loader.dart';
import 'package:d_manager/screens/widgets/no_record_found.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnpaidSells extends StatefulWidget {
  const UnpaidSells({Key? key}) : super(key: key);

  @override
  _UnpaidSellsState createState() => _UnpaidSellsState();
}

class _UnpaidSellsState extends State<UnpaidSells> {
  List<UnpaidSellDetail> sells = [];
  int currentPage = 1;
  final searchController = TextEditingController();
  final _controller = ScrollController();
  int totalItems = 0;
  bool isLoadingMore = false;
  bool isLoading = false;
  bool isNetworkAvailable = true;
  ManageUnpaidServices unpaidServices = ManageUnpaidServices();
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = !isLoading;
    });
    _loadData(currentPage, searchController.text.trim());
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (totalItems > sells.length && !isLoadingMore) {
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
      child: isLoading == true ? const CustomLoader() :Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
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
                  sells.clear();
                  currentPage = 1;
                  _loadData(currentPage, searchController.text.trim());
                });
              },
              onChanged: (value) {
                setState(() {
                  sells.clear();
                  currentPage = 1;
                  _loadData(currentPage, value);
                });
              }
          ),
          SizedBox(height: Dimensions.height10),
          Expanded(
            child: (sells.isEmpty && isLoading == false) ? const NoRecordFound() : ListView.builder(
              controller: _controller,
              itemCount: sells.length + 1,
              itemBuilder: (context, index) {
                if (index < sells.length) {
                  var sell = sells[index];
                  return CustomAccordionWithoutExpanded(
                    titleChild: Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
                      child: Row(
                        children: [
                          SizedBox(width: Dimensions.width10),
                          Row(
                            children: [
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  SizedBox(width: Dimensions.width10),
                                  CircleAvatar(
                                    backgroundColor: AppTheme.secondary,
                                    radius: Dimensions.height20,
                                    child: BigText(text: '₹', color: AppTheme.primary, size: Dimensions.font18),
                                  ),
                                  SizedBox(width: Dimensions.height10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: Dimensions.screenWidth * 0.5,
                                          child: BigText(text: HelperFunctions.formatPrice(sell.differenceAmount.toString()), color: AppTheme.primary, size: Dimensions.font16)
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: AppTheme.black,
                                            radius: Dimensions.height10,
                                            child: BigText(text: sell.partyName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                          ),
                                          SizedBox(width: Dimensions.width10),
                                          SizedBox(
                                              width: Dimensions.screenWidth * 0.5,
                                              child: SmallText(text: sell.partyName!, color: AppTheme.black, size: Dimensions.font12)
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
                        ],
                      ),
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
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.grey, size: Dimensions.font12),
          BigText(text: value, color: AppTheme.primary, size: Dimensions.font14),
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
        UnpaidSellModel? unpaidListModel = await unpaidServices.unpaidSellList(pageNo, search);
        if (unpaidListModel != null) {
          if (unpaidListModel.success == true) {
            if (unpaidListModel.data!.isNotEmpty) {
              if (pageNo == 1) {
                sells.clear();
              }

              setState(() {
                totalItems = unpaidListModel.total ?? 0;
                Provider.of<UnpaidProvider>(context, listen: false).setTotalUnpaidAmount(unpaidListModel.totalUnpaid.toString());
                sells.addAll(unpaidListModel.data!);
              });
            } else {
              setState(() {
                isLoading = false;
                Provider.of<UnpaidProvider>(context, listen: false).setTotalUnpaidAmount("0.00");
              });
            }
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              unpaidListModel.message.toString(),
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

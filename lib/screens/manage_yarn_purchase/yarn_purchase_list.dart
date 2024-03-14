import 'package:d_manager/api/dropdown_services.dart';
import 'package:d_manager/api/manage_purchase_services.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/dropdown_models/drop_down_party_list_model.dart';
import 'package:d_manager/models/dropdown_models/dropdown_film_list_model.dart';
import 'package:d_manager/models/dropdown_models/dropdown_yarn_list_model.dart';
import 'package:d_manager/models/yarn_purchase_models/update_yarn_purchase_status_model.dart';
import 'package:d_manager/models/yarn_purchase_models/yarn_purchase_list_model.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/no_record_found.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class YarnPurchaseList extends StatefulWidget {
  const YarnPurchaseList({Key? key}) : super(key: key);

  @override
  _YarnPurchaseListState createState() => _YarnPurchaseListState();
}

class _YarnPurchaseListState extends State<YarnPurchaseList> {
  final searchController = TextEditingController();
  final RefreshController _refreshController = RefreshController();
  List<PurchaseDetail> purchases = [];
  int currentPage = 1;
  bool isLoading = false;
  bool noRecordFound = false;
  bool isNetworkAvailable = true;
  bool isFilterApplied = false;
  ManagePurchaseServices purchaseServices = ManagePurchaseServices();
  var selectedFirm;
  var selectedParty;
  var selectedYarn;
  var selectedStatus;
  List<Firm> firms = [];
  List<Party> parties = [];
  List<Yarn> yarns = [];

  DropdownServices dropdownServices = DropdownServices();
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
      _getFirms();
      _getParties();
      _getYarns();
    });
    _loadData(currentPage, searchController.text.trim());
  }
  @override
  void dispose() {
    searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          title: S.of(context).yarnPurchasesList,
          isLoading: isLoading,
          noRecordFound: noRecordFound,
          internetNotAvailable: isNetworkAvailable,
          filterButton: GestureDetector(
            onTap: () {
              _showBottomSheet(context);
            },
            child: const FaIcon(FontAwesomeIcons.sliders, color: AppTheme.black),
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
                              purchases.clear();
                              currentPage = 1;
                              _loadData(currentPage, searchController.text.trim());
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              purchases.clear();
                              currentPage = 1;
                              _loadData(currentPage, value);
                            });
                          }
                      ),
                    ),
                    SizedBox(width: Dimensions.width20),
                    CustomIconButton(
                        radius: Dimensions.radius10,
                        backgroundColor: AppTheme.primary,
                        iconColor: AppTheme.white,
                        iconData: Icons.add,
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.yarnPurchaseAdd);
                        }
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                AppTheme.divider,
                SizedBox(height: Dimensions.height10),
                Expanded(
                  child: SmartRefresher(
                    controller: _refreshController,
                    enablePullUp: true,
                    onRefresh: () async {
                      setState(() {
                        purchases.clear();
                        currentPage = 1;
                      });
                      await _loadData(currentPage, searchController.text.trim());
                      _refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await _loadData(currentPage, searchController.text.trim());
                      _refreshController.loadComplete();
                    },
                    child: ListView.builder(
                      itemCount: purchases.length,
                      itemBuilder: (context, index) {
                        var purchase = purchases[index];
                        return CustomAccordion(
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
                                        child: BigText(text: purchase.partyName![0], color: AppTheme.primary, size: Dimensions.font18),
                                      ),
                                      SizedBox(width: Dimensions.height10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: Dimensions.screenWidth * 0.5,
                                              child: BigText(text: purchase.partyName!, color: AppTheme.primary, size: Dimensions.font16)),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: AppTheme.black,
                                                radius: Dimensions.height10,
                                                child: BigText(text: purchase.firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                              ),
                                              SizedBox(width: Dimensions.width10),
                                              SizedBox(
                                                  width: Dimensions.screenWidth * 0.3,
                                                  child: SmallText(text: purchase.firmName!, color: AppTheme.black, size: Dimensions.font12)),
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
                                  _buildInfoColumn('Deal Date', purchase.purchaseDate!.toString().split(' ')[0]),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Yarn Name', purchase.yarnName!),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Yarn Type', purchase.typeName!),
                                ],
                              ),
                            ],
                          ),
                          contentChild: Column(
                            children: [
                              Row(
                                children: [
                                  _buildInfoColumn('Payment Type', purchase.paymentType! == 'current' ? 'Current' : 'Dhara'),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Lot Number', purchase.lotNumber!),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Box Ordered', purchase.orderedBoxCount!),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Gross Received', purchase.grossReceivedWeight!),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Gross Remaining', (double.parse(purchase.grossWeight!) - double.parse(purchase.grossReceivedWeight!)).toString()),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Cops', purchase.cops!),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Deiner', purchase.denier!),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Status', purchase.dealStatus! == 'ongoing' ? 'On Going' : 'Completed'),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('', ''),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width/2.65,
                                      height: Dimensions.height40*2.5,
                                      padding: EdgeInsets.all(Dimensions.height10),
                                      decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                        border: Border.all(color: AppTheme.primary),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          BigText(text: 'Total Net Weight', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: AppTheme.primary,
                                                fontSize: Dimensions.font18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: purchase.netWeight!,
                                                ),
                                                TextSpan(
                                                  text: ' ton',
                                                  style: TextStyle(
                                                    fontSize: Dimensions.font12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          BigText(text: 'Gross Weight\n ${purchase.grossWeight} ton', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                        ],
                                      )
                                  ),
                                  SizedBox(width: Dimensions.width20),
                                  Container(
                                      width: MediaQuery.of(context).size.width/2.65,
                                      height: Dimensions.height40*2.5,
                                      padding: EdgeInsets.all(Dimensions.height10),
                                      decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                        border: Border.all(color: AppTheme.primary),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          BigText(text: 'Rate', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                          BigText(text: '₹ ${purchase.rate}',color: AppTheme.primary, size: Dimensions.font18)
                                        ],
                                      )
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(AppRoutes.yarnPurchaseView, arguments: {'purchaseId': purchase.purchaseId.toString()});
                                      },
                                      icon: const Icon(Icons.visibility_outlined, color: AppTheme.primary)
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(AppRoutes.yarnPurchaseAdd, arguments: {'purchaseId': purchase.purchaseId});
                                      },
                                      icon: const Icon(Icons.edit_outlined, color: AppTheme.primary)
                                  ),
                                  GFCheckbox(
                                    size: Dimensions.height20,
                                    type: GFCheckboxType.custom,
                                    inactiveBgColor: AppTheme.nearlyWhite,
                                    inactiveBorderColor: AppTheme.primary,
                                    customBgColor: AppTheme.primary,
                                    activeBorderColor: AppTheme.primary,
                                    onChanged: (value) {
                                      if (purchase.dealStatus == 'ongoing') {
                                        _updateStatus(purchase.purchaseId!, 'completed');
                                      } else {
                                        CustomApiSnackbar.show(
                                          context,
                                          'Warning',
                                          'Deal is already completed',
                                          mode: SnackbarMode.warning,
                                        );
                                      }
                                    },
                                    value: purchase.dealStatus == 'completed' ? true : false,
                                    inactiveIcon: null,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
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
                            purchases.clear();
                            currentPage = 1;
                            isFilterApplied = true;
                            _loadData(currentPage, '');
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
                            selectedStatus = null;
                            isFilterApplied = false;
                            purchases.clear();
                            currentPage = 1;
                            _loadData(currentPage, '');
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
                          BigText(text: 'Status', size: Dimensions.font12,),
                          Gap(Dimensions.height10/2),
                          CustomApiDropdown(
                              hintText: 'Select Status',
                              dropdownItems: [
                                DropdownMenuItem<dynamic>(value: 'ongoing', child: BigText(text: 'On Going', size: Dimensions.font14,)),
                                DropdownMenuItem<dynamic>(value: 'completed', child: BigText(text: 'Completed', size: Dimensions.font14,)),
                              ],
                              selectedValue: selectedStatus,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedStatus = newValue!;
                                });
                              }
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
        isLoading = false;
      });
    }
  }

  Future<void> _getParties() async {
    DropdownPartyListModel? response = await dropdownServices.partyList();
    if (response != null) {
      setState(() {
        parties.addAll(response.data!);
        isLoading = false;
      });
    }
  }

  Future<void> _getYarns() async {
    DropdownYarnListModel? response = await dropdownServices.yarnList();
    if (response != null) {
      setState(() {
        yarns.addAll(response.data!);
        isLoading = false;
      });
    }
  }

  Future<void> _loadData(int pageNo, String search) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        YarnPurchaseListModel? purchaseListModel = await purchaseServices.purchaseList(
            pageNo, search, selectedFirm, selectedParty, selectedYarn, selectedStatus
        );
        if (purchaseListModel != null) {
          if (purchaseListModel.success == true) {
            if (purchaseListModel.data != null) {
              if (purchaseListModel.data!.isNotEmpty) {
                if (pageNo == 1) {
                  purchases.clear();
                }

                setState(() {
                  purchases.addAll(purchaseListModel.data!);
                  isLoading = false;
                  noRecordFound = false;
                  currentPage++;
                });
              } else {
                _refreshController.loadNoData();
              }
            } else {
              setState(() {
                noRecordFound = true;
              });
            }
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              purchaseListModel.message.toString(),
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
      });
    }
  }

  Future<void> _updateStatus(int purchaseId, String status) async {
    setState(() {
      isLoading = true;
    });

    try {
      UpdateYarnPurchaseStatusModel? updatePurchaseStatusModel = await purchaseServices.updatePurchaseStatus(purchaseId, status);
      if (updatePurchaseStatusModel != null) {
        if (updatePurchaseStatusModel.success == true) {
          setState(() {
            purchases.clear();
            currentPage = 1;
          });
          await _loadData(currentPage, '');
          CustomApiSnackbar.show(
            context,
            'Success',
            updatePurchaseStatusModel.message.toString(),
            mode: SnackbarMode.success,
          );
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            updatePurchaseStatusModel.message.toString(),
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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

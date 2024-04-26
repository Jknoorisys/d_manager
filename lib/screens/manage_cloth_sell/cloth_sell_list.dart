import 'package:d_manager/api/manage_sell_deals.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/dropdown_models/drop_down_party_list_model.dart';
import 'package:d_manager/models/dropdown_models/dropdown_film_list_model.dart';
import 'package:d_manager/screens/manage_cloth_sell/update_sell_deal.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/no_record_found.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:intl/intl.dart';
import '../../models/sell_models/active_parties_model.dart';
import '../../models/sell_models/sell_deal_list_model.dart';
import '../../models/sell_models/status_sell_deal_model.dart';
import '../widgets/snackbar.dart';
import '../../api/dropdown_services.dart';
import '../../api/manage_firm_services.dart';
import '../../api/manage_party_services.dart';
import '../../models/dropdown_models/dropdown_cloth_quality_list_model.dart';
import '../../models/sell_models/active_firms_model.dart';

class ClothSellList extends StatefulWidget {
  const ClothSellList({Key? key}) : super(key: key);

  @override
  _ClothSellListState createState() => _ClothSellListState();
}

class _ClothSellListState extends State<ClothSellList> {
  SellDealDetails sellDealDetails = SellDealDetails();
  final searchController = TextEditingController();
  final _controller = ScrollController();
  int totalItems = 0;
  bool isLoadingMore = false;
  SellDealListModel? sellDealListModel;
  List<SellDeal> clothSellList = [];
  var selectedFirm;
  var selectedParty;
  var selectedClothQuality;
  var selectedStatus;
  List<Firm> firms = [];
  List<Party> parties = [];
  List<ClothQuality> cloths = [];

  String status = 'On Going';
  int currentPage = 1;

  ManageFirmServices firmServices = ManageFirmServices();
  ManagePartyServices partyServices = ManagePartyServices();
  DropdownServices dropdownServices = DropdownServices();
  String? firmID;
  String? partyID;
  String? clothID;
  bool isLoading = false;
  bool isNetworkAvailable = true;
  bool isFilterApplied = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = !isLoading;
    });
    getSellDealList(currentPage, searchController.text.trim());
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (totalItems > clothSellList.length && !isLoadingMore) {
          currentPage++;
          isLoadingMore = true;
          getSellDealList(currentPage, searchController.text.trim());
        }
      }
    });
    _getFirms();
    _getParties();
    _getClothTypes();
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
          title: S.of(context).clothSellList,
          filterButton: GestureDetector(
            onTap: () {
              _showBottomSheet(context);
            },
            child: const FaIcon(FontAwesomeIcons.sliders, color: AppTheme.black),
          ),
          content: Padding(
            padding: EdgeInsets.all(Dimensions.height15),
            child: Column(
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
                              clothSellList.clear();
                              currentPage = 1;
                              getSellDealList(currentPage, searchController.text.trim());
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              clothSellList.clear();
                              currentPage = 1;
                              getSellDealList(currentPage, value);
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
                          Navigator.of(context).pushNamed(AppRoutes.clothSellAdd);
                        }
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                AppTheme.divider,
                SizedBox(height: Dimensions.height10),
                Expanded(
                  child: (clothSellList.isEmpty && isLoading == false) ? const NoRecordFound() : ListView.builder(
                    controller: _controller,
                    itemCount: clothSellList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < clothSellList.length) {
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
                                        child: BigText(text: clothSellList[index].partyFirm![0], color: AppTheme.primary, size: Dimensions.font18),
                                      ),
                                      SizedBox(width: Dimensions.height10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: Dimensions.screenWidth * 0.5,
                                              child: BigText(text: clothSellList[index].partyName!, color: AppTheme.primary, size: Dimensions.font16)
                                          ),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: AppTheme.black,
                                                radius: Dimensions.height10,
                                                child: BigText(text: clothSellList[index].firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                              ),
                                              SizedBox(width: Dimensions.width10),
                                              SizedBox(
                                                  width: Dimensions.screenWidth * 0.5,
                                                  child: SmallText(text: clothSellList[index].firmName!, color: AppTheme.black, size: Dimensions.font12)
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
                                  Expanded(flex:1,child: _buildInfoColumn('Deal Date', clothSellList[index].sellDate!.toString())),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Cloth Quality', clothSellList[index].qualityName!)),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Total Than', clothSellList[index].totalThan!)),
                                ],
                              ),
                            ],
                          ),
                          contentChild: Column(
                            children:[
                              Row(
                                children: [
                                  Expanded(flex:1,child: _buildInfoColumn('Than Delivered', clothSellList[index].thanDelivered ?? 'N/A')),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Than Remaining', clothSellList[index].thanRemaining ?? 'N/A')),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Rate', '₹${HelperFunctions.formatPrice(clothSellList[index].rate.toString())}')),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  Expanded(flex:1,child: _buildInfoColumn('Status', clothSellList[index].dealStatus! == 'ongoing' ? 'On Going' : 'Completed')),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Due Date', clothSellList[index].sellDueDate!.toString())),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('', '')),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(AppRoutes.clothSellView, arguments: {'sellID': clothSellList[index].sellId});
                                      },
                                      icon: const Icon(Icons.visibility_outlined, color: AppTheme.primary)
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        selectedFirm = ActiveFirmsList(firmName: clothSellList[index].firmName,firmId:int.tryParse(clothSellList[index]!.firmId!));
                                        selectedParty = ActivePartiesList(partyName: clothSellList[index].partyFirm,partyId:int.tryParse(clothSellList[index]!.partyId!));
                                        selectedClothQuality = ClothQuality(qualityName: clothSellList[index].qualityName,qualityId:int.tryParse(clothSellList[index]!.qualityId!));
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            UpdateSellDeal(
                                              sellID: clothSellList[index].sellId!,
                                              sellListData:clothSellList[index],
                                              selectedFirm: selectedFirm, // Pass the selected firm
                                              selectedParty: selectedParty, // Pass the selected party
                                              selectedClothQuality: selectedClothQuality,
                                            )));

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
                                      if (clothSellList[index].dealStatus == 'ongoing') {
                                        updateStatusOfSellDeal(
                                            clothSellList[index].sellId.toString(), 'completed', index);
                                      } else {
                                        CustomApiSnackbar.show(
                                          context,
                                          'Warning',
                                          'Deal is already completed',
                                          mode: SnackbarMode.warning,
                                        );
                                      }
                                    },
                                    value: clothSellList[index].dealStatus == 'completed' ? true : false,
                                    inactiveIcon: null,
                                  ),
                                ],
                              ),
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
          ),
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
                            clothSellList.clear();
                            currentPage = 1;
                            isFilterApplied = true;
                            getSellDealList(currentPage, '');
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
                            selectedClothQuality = null;
                            selectedStatus = null;
                            isFilterApplied = false;
                            clothSellList.clear();
                            currentPage = 1;
                            getSellDealList(currentPage, '');
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
                          BigText(text: 'Select Cloth Quality', size: Dimensions.font12,),
                          Gap(Dimensions.height10/2),
                          CustomApiDropdown(
                              hintText: 'Select Cloth Quality',
                              dropdownItems: cloths.map((e) => DropdownMenuItem<dynamic>(value: e.qualityId!, child: BigText(text: e.qualityName!, size: Dimensions.font14,))).toList(),
                              selectedValue: cloths.any((cloth) => cloth.qualityId == selectedClothQuality) ? selectedClothQuality : null,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedClothQuality = newValue!;
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
  Future<void> getSellDealList(int pageNo, String search,) async {
      setState(() {
        isLoading = true;
      });
      try {
        if (await HelperFunctions.isPossiblyNetworkAvailable()) {
          SellDealListModel? model = await sellDealDetails.sellDealListApi(
            pageNo.toString(),
            search,
              selectedFirm, selectedParty, selectedClothQuality, selectedStatus
          );
          if (model != null) {
            if (model.success == true) {
              if (model.data != null) {
                if (model.data!.isNotEmpty) {
                  if (pageNo == 1) {
                    clothSellList.clear();
                  }

                  setState(() {
                    totalItems = model.total ?? 0;
                    clothSellList.addAll(model.data!);
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }
              } else{
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
  Future<void> updateStatusOfSellDeal(String sellID, String dealStatus, int index) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        UpdateSellDealStatusModel? model = await sellDealDetails.updateSellDealStatus(
          sellID,
          dealStatus,
        );
        if (model != null) {
          if (model.success == true) {
            clothSellList[index].dealStatus = 'completed';
            CustomApiSnackbar.show(
              context,
              'Success',
              model.message!.toString(),
              mode: SnackbarMode.success,
            );
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
        CustomApiSnackbar.show(
          context,
          'Warning',
          'No Internet Connection',
          mode: SnackbarMode.warning,
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
  Future<void> _getClothTypes() async {
    DropdownClothQualityListModel? response = await dropdownServices.clothQualityList();
    if (response != null) {
      setState(() {
        cloths.addAll(response.data!);
      });
    }
  }
}

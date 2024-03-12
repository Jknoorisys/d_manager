import 'package:d_manager/api/manage_party_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/party_list_model.dart';
import 'package:d_manager/models/master_models/update_party_status_model.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PartyList extends StatefulWidget {
  const PartyList({Key? key}) : super(key: key);

  @override
  _PartyListState createState() => _PartyListState();
}

class _PartyListState extends State<PartyList> {
  final searchController = TextEditingController();
  final RefreshController _refreshController = RefreshController();
  List<PartyDetail> parties = [];
  int currentPage = 1;
  bool isLoading = false;
  bool noRecordFound = false;
  bool isNetworkAvailable = true;
  ManagePartyServices partyServices = ManagePartyServices();
  @override
  void initState() {
    super.initState();
    if (HelperFunctions.checkInternet() == false) {
      isNetworkAvailable = false;
      isLoading = false;
    } else {
      setState(() {
        isLoading = !isLoading;
      });
      _loadData(currentPage, searchController.text.trim());
    }
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
        title: S.of(context).partyList,
        isLoading: isLoading,
        noRecordFound: noRecordFound,
        internetNotAvailable: isNetworkAvailable,
        content: Padding(
            padding: EdgeInsets.all(Dimensions.height15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextField(
                          isFilled: false,
                          controller: searchController,
                          hintText: S.of(context).searchParty,
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.close,
                          borderRadius: Dimensions.radius10,
                          borderColor: AppTheme.primary,
                          onSuffixTap: () {
                            setState(() {
                              searchController.clear();
                              parties.clear();
                              currentPage = 1;
                              _loadData(currentPage, searchController.text.trim());
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              parties.clear();
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
                          Navigator.of(context).pushNamed(AppRoutes.partyAdd);
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
                        parties.clear();
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
                      itemCount: parties.length,
                      itemBuilder: (context, index) {
                        var party = parties[index];
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
                                        child: BigText(text: party.partyName![0], color: AppTheme.primary, size: Dimensions.font18),
                                      ),
                                      SizedBox(width: Dimensions.height10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: Dimensions.screenWidth * 0.5,
                                              child: BigText(text: party.partyName!, color: AppTheme.primary, size: Dimensions.font16)
                                          ),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: AppTheme.black,
                                                radius: Dimensions.height10,
                                                child: BigText(text: party.firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                              ),
                                              SizedBox(width: Dimensions.width10),
                                              SizedBox(
                                                  width: Dimensions.screenWidth * 0.5,
                                                  child: SmallText(text: party.firmName!, color: AppTheme.black, size: Dimensions.font12)
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
                            ],
                          ),
                          contentChild: Column(
                            children: [
                              AppTheme.divider,
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Address', party.address ?? ''),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Phone Number', party.phoneNumber ?? ''),
                                  SizedBox(width: Dimensions.width20),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Party State', party.stateName ?? ''),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('GST Number', party.gstNumber ?? ''),
                                  SizedBox(width: Dimensions.width20),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('PAN Number', party.panNumber ?? ''),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Status', party.status == 'active' ? 'Active' : 'Inactive'),
                                  SizedBox(width: Dimensions.width20),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(AppRoutes.partyAdd, arguments: {'partyId': party.partyId});
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
                                      String newStatus = value ? 'active' : 'inactive';
                                      _updateStatus(party.partyId!, newStatus);
                                    },
                                    value: party.status == 'active' ? true : false,
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
          )
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
    setState(() {
      isLoading = true;
    });

    try {
      PartyListModel? partyListModel = await partyServices.partyList(pageNo, search);
      if (partyListModel != null) {
        if (partyListModel.success == true) {
          if(partyListModel.total == 0) {
            setState(() {
              noRecordFound = true;
            });
          }
          if (partyListModel.data!.isNotEmpty) {
            if (pageNo == 1) {
              parties.clear();
            }

            setState(() {
              parties.addAll(partyListModel.data!);
              currentPage++;
            });
          } else {
            _refreshController.loadNoData();
          }
        } else {
          setState(() {
            noRecordFound = true;
          });
          CustomApiSnackbar.show(
            context,
            'Error',
            partyListModel.message.toString(),
            mode: SnackbarMode.error,
          );
        }
      } else {
        setState(() {
          noRecordFound = true;
        });
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

  Future<void> _updateStatus(int partyId, String status) async {
    setState(() {
      isLoading = true;
    });

    try {
      UpdatePartyStatusModel? updatePartyStatusModel = await partyServices.updatePartyStatus(partyId, status);
      if (updatePartyStatusModel != null) {
        if (updatePartyStatusModel.success == true) {
          setState(() {
            parties.clear();
            currentPage = 1;
          });
          await _loadData(currentPage, '');
          CustomApiSnackbar.show(
            context,
            'Success',
            updatePartyStatusModel.message.toString(),
            mode: SnackbarMode.success,
          );
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            updatePartyStatusModel.message.toString(),
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

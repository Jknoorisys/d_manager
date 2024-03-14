import 'package:d_manager/api/manage_hammal_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/hammal_list_model.dart';
import 'package:d_manager/models/master_models/update_hammal_status_model.dart';
import 'package:d_manager/screens/manage_masters/manage_hammal/hammal_add.dart';
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

class HammalList extends StatefulWidget {
  const HammalList({Key? key}) : super(key: key);

  @override
  _HammalListState createState() => _HammalListState();
}

class _HammalListState extends State<HammalList> {
  final searchController = TextEditingController();
  final RefreshController _refreshController = RefreshController();
  List<HammalDetail> hammals = [];
  int currentPage = 1;
  bool isLoading = false;
  bool isNetworkAvailable = true;
  ManageHammalServices hammalServices = ManageHammalServices();

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = !isLoading;
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
        title: S.of(context).hammalList,
        isLoading: isLoading,
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
                          hintText: S.of(context).searchHammal,
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.close,
                          borderRadius: Dimensions.radius10,
                          borderColor: AppTheme.primary,
                          onSuffixTap: () {
                            setState(() {
                              searchController.clear();
                              hammals.clear();
                              currentPage = 1;
                              _loadData(currentPage, searchController.text.trim());
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              hammals.clear();
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const HammalAdd();
                            },
                          );
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
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: () async {
                      setState(() {
                        hammals.clear();
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
                      itemCount: hammals.length,
                      itemBuilder: (context, index) {
                        var hammal = hammals[index];
                        return CustomAccordion(
                          titleChild: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: Dimensions.width10),
                                  CircleAvatar(
                                    backgroundColor: AppTheme.secondary,
                                    radius: Dimensions.height20,
                                    child: BigText(text: hammal.hammalName![0], color: AppTheme.primary, size: Dimensions.font18),
                                  ),
                                  SizedBox(width: Dimensions.height10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        BigText(text: hammal.hammalName!, color: AppTheme.primary, size: Dimensions.font16),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppTheme.black,
                                              radius: Dimensions.height10,
                                              child: Icon(Icons.phone, color: AppTheme.secondaryLight, size: Dimensions.font12),
                                            ),
                                            SizedBox(width: Dimensions.width10),
                                            SmallText(text: hammal.hammalPhoneNo != '' ? hammal.hammalPhoneNo! : 'Not available', color: AppTheme.black, size: Dimensions.font12),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                            ],
                          ),
                          contentChild: Column(
                            children: [
                              AppTheme.divider,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildInfoColumn('', hammal.status == 'active' ? 'Active' : 'Inactive'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return HammalAdd(hammalId: hammal.hammalId);
                                              },
                                            );
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
                                          _updateStatus(hammal.hammalId!, newStatus);
                                        },
                                        value: hammal.status == 'active' ? true : false,
                                        inactiveIcon: null,
                                      ),
                                    ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: title, color: AppTheme.primary, size: Dimensions.font14),
        SmallText(text: value, color: AppTheme.grey, size: Dimensions.font12),
      ],
    );
  }

  Future<void> _loadData(int pageNo, String search) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        HammalListModel? hammalListModel = await hammalServices.hammalList(pageNo, search);
        if (hammalListModel != null) {
          if (hammalListModel.success == true) {
            if (hammalListModel.data!.isNotEmpty) {
              if (pageNo == 1) {
                hammals.clear();
              }

              setState(() {
                hammals.addAll(hammalListModel.data!);
                currentPage++;
              });
            } else {
              _refreshController.loadNoData();
            }
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              hammalListModel.message.toString(),
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

  Future<void> _updateStatus(int hammalId, String status) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        UpdateHammalStatusModel? updateHammalStatusModel = await hammalServices.updateHammalStatus(hammalId, status);
        if (updateHammalStatusModel != null) {
          if (updateHammalStatusModel.success == true) {
            setState(() {
              hammals.clear();
              currentPage = 1;
            });
            await _loadData(currentPage, '');
            CustomApiSnackbar.show(
              context,
              'Success',
              updateHammalStatusModel.message.toString(),
              mode: SnackbarMode.success,
            );
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              updateHammalStatusModel.message.toString(),
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
}

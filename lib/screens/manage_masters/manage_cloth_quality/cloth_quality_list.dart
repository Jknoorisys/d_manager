import 'package:d_manager/api/manage_cloth_quality_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/cloth_quality_list_model.dart';
import 'package:d_manager/models/master_models/update_cloth_quality_status_model.dart';
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

import 'cloth_quality_add.dart';

class ClothQualityList extends StatefulWidget {
  const ClothQualityList({Key? key}) : super(key: key);

  @override
  _ClothQualityListState createState() => _ClothQualityListState();
}

class _ClothQualityListState extends State<ClothQualityList> {
  final searchController = TextEditingController();
  final RefreshController _refreshController = RefreshController();
  List<ClothQuality> qualities = [];
  int currentPage = 1;
  bool isLoading = false;
  bool isNetworkAvailable = true;
  ManageClothQualityServices clothQualityServices = ManageClothQualityServices();

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
        title: S.of(context).clothQualityList,
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
                          hintText: S.of(context).searchClothQuality,
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.close,
                          borderRadius: Dimensions.radius10,
                          borderColor: AppTheme.primary,
                          onSuffixTap: () {
                            setState(() {
                              searchController.clear();
                              qualities.clear();
                              currentPage = 1;
                              _loadData(currentPage, searchController.text.trim());
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              qualities.clear();
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
                              return const ClothQualityAdd();
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
                        qualities.clear();
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
                      itemCount: qualities.length,
                      itemBuilder: (context, index) {
                        var quality = qualities[index];
                        return CustomAccordion(
                          titleChild: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: Dimensions.width10),
                                  CircleAvatar(
                                    backgroundColor: AppTheme.secondary,
                                    radius: Dimensions.height20,
                                    child: BigText(text: quality.qualityName![0], color: AppTheme.primary, size: Dimensions.font18),
                                  ),
                                  SizedBox(width: Dimensions.height10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      BigText(text: quality.qualityName!, color: AppTheme.primary, size: Dimensions.font16),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: AppTheme.black,
                                            radius: Dimensions.height10,
                                            child: BigText(text: quality.status! == 'active' ? 'A' : 'I', color: AppTheme.secondaryLight, size: Dimensions.font12),
                                          ),
                                          SizedBox(width: Dimensions.width10),
                                          SmallText(text: quality.status! == 'active' ? 'Active' : 'Inactive', color: AppTheme.black, size: Dimensions.font12),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                            ],
                          ),
                          contentChild: Column(
                            children: [
                              SizedBox(width: Dimensions.width10),
                              AppTheme.divider,
                              SizedBox(width: Dimensions.width10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ClothQualityAdd(clothQualityId: quality.qualityId);
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
                                      _updateStatus(quality.qualityId!, newStatus);
                                    },
                                    value: quality.status == 'active' ? true : false,
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

  Future<void> _loadData(int pageNo, String search) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        ClothQualityListModel? clothQualityListModel = await clothQualityServices.clothQualityList(pageNo, search);
        if (clothQualityListModel != null) {
          if (clothQualityListModel.success == true) {
            if (clothQualityListModel.data!.isNotEmpty) {
              if (pageNo == 1) {
                qualities.clear();
              }

              setState(() {
                qualities.addAll(clothQualityListModel.data!);
                currentPage++;
              });
            } else {
              _refreshController.loadNoData();
            }
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              clothQualityListModel.message.toString(),
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

  Future<void> _updateStatus(int clothQualityId, String status) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        UpdateClothQualityStatusModel? updateClothQualityStatusModel = await clothQualityServices.updateClothQualityStatus(clothQualityId, status);
        if (updateClothQualityStatusModel != null) {
          if (updateClothQualityStatusModel.success == true) {
            setState(() {
              qualities.clear();
              currentPage = 1;
            });
            await _loadData(currentPage, '');
            CustomApiSnackbar.show(
              context,
              'Success',
              updateClothQualityStatusModel.message.toString(),
              mode: SnackbarMode.success,
            );
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              updateClothQualityStatusModel.message.toString(),
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
}

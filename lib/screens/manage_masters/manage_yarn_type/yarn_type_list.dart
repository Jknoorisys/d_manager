import 'package:d_manager/api/manage_yarn_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/update_yarn_status_model.dart';
import 'package:d_manager/models/master_models/yarn_list_model.dart';
import 'package:d_manager/screens/manage_masters/manage_yarn_type/yarn_type_add.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/no_record_found.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class YarnTypeList extends StatefulWidget {
  const YarnTypeList({Key? key}) : super(key: key);

  @override
  _YarnTypeListState createState() => _YarnTypeListState();
}

class _YarnTypeListState extends State<YarnTypeList> {
  final searchController = TextEditingController();
  bool isLoadingMore = false;
  int totalItems = 0;
  final _controller = ScrollController();
  List<YarnDetail> yarns = [];
  int currentPage = 1;
  bool isLoading = false;
  bool isNetworkAvailable = true;
  ManageYarnServices yarnServices = ManageYarnServices();

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = !isLoading;
    });
    _loadData(currentPage, searchController.text.trim());
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (totalItems > yarns.length && !isLoadingMore) {
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
    return CustomDrawer(
      content: CustomBody(
        title: S.of(context).yarnTypeList,
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
                          hintText: S.of(context).searchYarnType,
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.close,
                          borderRadius: Dimensions.radius10,
                          borderColor: AppTheme.primary,
                          onSuffixTap: () {
                            setState(() {
                              searchController.clear();
                              yarns.clear();
                              currentPage = 1;
                              _loadData(currentPage, searchController.text.trim());
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              yarns.clear();
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
                              return const YarnTypeAdd();
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
                  child: (yarns.isEmpty && isLoading == false) ? const NoRecordFound() : ListView.builder(
                    controller: _controller,
                    itemCount: yarns.length + 1,
                    itemBuilder: (context, index) {
                      if (index < yarns.length) {
                        var yarn = yarns[index];
                        return CustomAccordion(
                          titleChild: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: Dimensions.width10),
                                  CircleAvatar(
                                    backgroundColor: AppTheme.secondary,
                                    radius: Dimensions.height20,
                                    child: BigText(text: yarn.yarnName![0], color: AppTheme.primary, size: Dimensions.font18),
                                  ),
                                  SizedBox(width: Dimensions.height10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        BigText(text: yarn.yarnName!, color: AppTheme.primary, size: Dimensions.font16),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppTheme.black,
                                              radius: Dimensions.height10,
                                              child: BigText(text: yarn.typeName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                            ),
                                            SizedBox(width: Dimensions.width10),
                                            SmallText(text: yarn.typeName!, color: AppTheme.black, size: Dimensions.font12),
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
                              SizedBox(height: Dimensions.height10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildInfoColumn('', yarn.status == 'active' ? 'Active' : 'Inactive'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return YarnTypeAdd(yarnTypeId: yarn.yarnTypeId);
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
                                          _updateStatus(yarn.yarnTypeId!, newStatus);
                                        },
                                        value: yarn.status == 'active' ? true : false,
                                        inactiveIcon: null,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        // if (totalItems > yarns.length) {
                        //   return const CustomLoader();
                        // } else {
                        //   return const SizedBox(height: 0);
                        // }
                        return const SizedBox(height: 0);
                      }
                    },
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
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        YarnListModel? yarnListModel = await yarnServices.yarnList(pageNo, search);
        if (yarnListModel != null) {
          if (yarnListModel.success == true) {
            if (yarnListModel.data!.isNotEmpty) {
              if (pageNo == 1) {
                yarns.clear();
              }

              setState(() {
                yarns.addAll(yarnListModel.data!);
                totalItems = yarnListModel.total ?? 0;
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
              yarnListModel.message.toString(),
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

  Future<void> _updateStatus(int yarnTypeId, String status) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        UpdateYarnStatusModel? updateYarnStatusModel = await yarnServices.updateYarnStatus(yarnTypeId, status);
        if (updateYarnStatusModel != null) {
          if (updateYarnStatusModel.success == true) {
            setState(() {
              yarns.clear();
              currentPage = 1;
            });
            await _loadData(currentPage, '');
            CustomApiSnackbar.show(
              context,
              'Success',
              updateYarnStatusModel.message.toString(),
              mode: SnackbarMode.success,
            );
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              updateYarnStatusModel.message.toString(),
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

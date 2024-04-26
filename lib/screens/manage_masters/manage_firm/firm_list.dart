import 'package:d_manager/api/manage_firm_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/firm_list_model.dart';
import 'package:d_manager/models/master_models/update_firm_status_model.dart';
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

class FirmList extends StatefulWidget {
  const FirmList({Key? key}) : super(key: key);

  @override
  _FirmListState createState() => _FirmListState();
}

class _FirmListState extends State<FirmList> {
  List<FirmDetails> firms = [];
  int currentPage = 1;
  final searchController = TextEditingController();
  final _controller = ScrollController();
  int totalItems = 0;
  bool isLoadingMore = false;
  bool isLoading = false;
  bool isNetworkAvailable = true;
  ManageFirmServices firmServices = ManageFirmServices();
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = !isLoading;
    });
    _loadData(currentPage, searchController.text.trim());
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (totalItems > firms.length && !isLoadingMore) {
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
          title: S.of(context).firmList,
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
                        hintText: S.of(context).searchFirm,
                        prefixIcon: Icons.search,
                        suffixIcon: Icons.close,
                        borderRadius: Dimensions.radius10,
                        borderColor: AppTheme.primary,
                        onSuffixTap: () {
                          setState(() {
                            searchController.clear();
                            firms.clear();
                            currentPage = 1;
                            _loadData(currentPage, searchController.text.trim());
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            firms.clear();
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
                        Navigator.of(context).pushNamed(AppRoutes.firmAdd);
                      }
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                AppTheme.divider,
                SizedBox(height: Dimensions.height10),
                Expanded(
                  child: (firms.isEmpty && isLoading == false) ? const NoRecordFound() : ListView.builder(
                    controller: _controller,
                    itemCount: firms.length + 1,
                    itemBuilder: (context, index) {
                      if (index < firms.length) {
                        var firm = firms[index];
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
                                        child: BigText(text: firm.firmName![0], color: AppTheme.primary, size: Dimensions.font18),
                                      ),
                                      SizedBox(width: Dimensions.height10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: Dimensions.screenWidth * 0.5,
                                              child: BigText(text: firm.firmName!, color: AppTheme.primary, size: Dimensions.font16)
                                          ),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: AppTheme.black,
                                                radius: Dimensions.height10,
                                                child: BigText(text: firm.ownerName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                              ),
                                              SizedBox(width: Dimensions.width10),
                                              SizedBox(
                                                  width: Dimensions.screenWidth * 0.5,
                                                  child: SmallText(text: firm.ownerName!, color: AppTheme.black, size: Dimensions.font12)
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
                                  _buildInfoColumn('Phone Number', firm.phoneNumber!),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Address', firm.address!),
                                  SizedBox(width: Dimensions.width20),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('GST Number', firm.gstNumber!),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('PAN Number', firm.panNumber ?? ''),
                                  SizedBox(width: Dimensions.width20),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Group Code', firm.groupCode ?? ''),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Status', firm.status! == 'active' ? 'Active' : 'Inactive'),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(AppRoutes.firmAdd, arguments: {'firmId': firm.firmId!});
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
                                      _updateStatus(firm.firmId!, newStatus);
                                    },
                                    value: firm.status == 'active' ? true : false,
                                    inactiveIcon: null,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        // if (totalItems > firms.length) {
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
    try {
      setState(() {
        isLoading = true;
      });
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        FirmListModel? firmListModel = await firmServices.firmList(pageNo, search);
        if (firmListModel != null) {
          if (firmListModel.success == true) {
            if (firmListModel.data!.isNotEmpty) {
              if (pageNo == 1) {
                firms.clear();
              }

              setState(() {
                totalItems = firmListModel.total ?? 0;
                firms.addAll(firmListModel.data!);
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
              firmListModel.message.toString(),
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

  Future<void> _updateStatus(int firmId, String status) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        UpdateFirmStatusModel? updateFirmStatusModel = await firmServices.updateFirmStatus(firmId, status);
        if (updateFirmStatusModel != null) {
          if (updateFirmStatusModel.success == true) {
            setState(() {
              firms.clear();
              currentPage = 1;
            });
            await _loadData(currentPage, '');
            CustomApiSnackbar.show(
              context,
              'Success',
              updateFirmStatusModel.message.toString(),
              mode: SnackbarMode.success,
            );
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              updateFirmStatusModel.message.toString(),
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

import 'package:d_manager/api/manage_transport_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/transport_list_model.dart';
import 'package:d_manager/models/master_models/update_transport_status_model.dart';
import 'package:d_manager/screens/manage_masters/manage_transport/transport_add.dart';
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
class TransportList extends StatefulWidget {
  const TransportList({Key? key}) : super(key: key);

  @override
  _TransportListState createState() => _TransportListState();
}

class _TransportListState extends State<TransportList> {
  final searchController = TextEditingController();
  bool isLoadingMore = false;
  int totalItems = 0;
  final _controller = ScrollController();
  List<TransportDetail> transports = [];
  int currentPage = 1;
  bool isLoading = false;
  bool isNetworkAvailable = true;
  ManageTransportServices transportServices = ManageTransportServices();

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = !isLoading;
    });
    _loadData(currentPage, searchController.text.trim());
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (totalItems > transports.length && !isLoadingMore) {
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
        title: S.of(context).transportList,
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
                        hintText: S.of(context).searchTransport,
                        prefixIcon: Icons.search,
                        suffixIcon: Icons.close,
                        borderRadius: Dimensions.radius10,
                        borderColor: AppTheme.primary,
                        onSuffixTap: () {
                          setState(() {
                            searchController.clear();
                            transports.clear();
                            currentPage = 1;
                            _loadData(currentPage, searchController.text.trim());
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            transports.clear();
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
                            return const TransportAdd();
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
                child: (transports.isEmpty && isLoading == false) ? const NoRecordFound() : ListView.builder(
                  controller: _controller,
                  itemCount: transports.length + 1,
                  itemBuilder: (context, index) {
                    if (index < transports.length) {
                      var transport = transports[index];
                      return CustomAccordion(
                        titleChild: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: Dimensions.width10),
                                CircleAvatar(
                                  backgroundColor: AppTheme.secondary,
                                  radius: Dimensions.height20,
                                  child: BigText(text: transport.transportName![0], color: AppTheme.primary, size: Dimensions.font18),
                                ),
                                SizedBox(width: Dimensions.height10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      BigText(text: transport.transportName!, color: AppTheme.primary, size: Dimensions.font16),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: AppTheme.black,
                                            radius: Dimensions.height10,
                                            child: Icon(Icons.phone, color: AppTheme.secondaryLight, size: Dimensions.font12),
                                          ),
                                          SizedBox(width: Dimensions.width10),
                                          SmallText(text: transport.transportPhoneNo != '' ? transport.transportPhoneNo! : 'Not available', color: AppTheme.black, size: Dimensions.font12),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTheme.divider,
                            SizedBox(height: Dimensions.height10),
                            _buildInfoColumn('Address', transport.transportAddress != '' ? transport.transportAddress! : 'Not available'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInfoColumn('', transport.status == 'active' ? 'Active' : 'Inactive'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return TransportAdd(transportId: transport.transportId!);
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
                                        _updateStatus(transport.transportId!, newStatus);
                                      },
                                      value: transport.status == 'active' ? true : false,
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
                      // if (totalItems > transports.length) {
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
      if (await HelperFunctions.isPossiblyNetworkAvailable()){
        TransportListModel? transportListModel = await transportServices.transportList(pageNo, search);
        if (transportListModel != null) {
          if (transportListModel.success == true) {
            if (transportListModel.data!.isNotEmpty) {
              if (pageNo == 1) {
                transports.clear();
              }

              setState(() {
                transports.addAll(transportListModel.data!);
                totalItems = transportListModel.total ?? 0;
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
              transportListModel.message.toString(),
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

  Future<void> _updateStatus(int transportTypeId, String status) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        UpdateTransportStatusModel? updateTransportStatusModel = await transportServices.updateTransportStatus(transportTypeId, status);
        if (updateTransportStatusModel != null) {
          if (updateTransportStatusModel.success == true) {
            setState(() {
              transports.clear();
              currentPage = 1;
            });
            await _loadData(currentPage, '');
            CustomApiSnackbar.show(
              context,
              'Success',
              updateTransportStatusModel.message.toString(),
              mode: SnackbarMode.success,
            );
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              updateTransportStatusModel.message.toString(),
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

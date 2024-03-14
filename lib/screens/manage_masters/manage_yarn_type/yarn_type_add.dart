import 'package:d_manager/api/manage_yarn_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/add_yarn_model.dart';
import 'package:d_manager/models/master_models/update_yarn_model.dart';
import 'package:d_manager/models/master_models/yarn_detail_model.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';

class YarnTypeAdd extends StatefulWidget {
  final int? yarnTypeId;
  const YarnTypeAdd({Key? key, this.yarnTypeId}) : super(key: key);

  @override
  _YarnTypeAddState createState() => _YarnTypeAddState();
}

class _YarnTypeAddState extends State<YarnTypeAdd> {
  final TextEditingController yarnNameController = TextEditingController();
  final TextEditingController yarnTypeController = TextEditingController();
  bool submitted = false;

  bool isLoading = false;
  ManageYarnServices yarnServices = ManageYarnServices();

  @override
  void dispose() {
    yarnNameController.dispose();
    yarnTypeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.yarnTypeId != null) {
      _getYarnDetails();
    }
  }
  @override
  Widget build(BuildContext context) {
    var errorYarnName = submitted == true ? _validateYarnName(yarnNameController.text) : null;
    var errorYarnType = submitted == true ? _validateYarnType(yarnTypeController.text) : null;
    return SingleChildScrollView(
      child: AlertDialog(
        alignment: Alignment.center,
        backgroundColor: AppTheme.white,
        elevation: 10,
        surfaceTintColor: AppTheme.white,
        shadowColor: AppTheme.primary.withOpacity(0.5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.yarnTypeId == null ? S.of(context).addYarnType : S.of(context).updateYarnType,
              style: AppTheme.heading2,
            ),
            IconButton(
              icon: const Icon(Icons.close, color: AppTheme.primary),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: yarnNameController,
              labelText: "Enter Yarn Name",
              keyboardType: TextInputType.name,
              borderRadius: Dimensions.radius10,
              errorText: errorYarnName.toString() != 'null' ? errorYarnName.toString() : '',
            ),
            SizedBox(height: Dimensions.height15),
            CustomTextField(
              controller: yarnTypeController,
              labelText: "Enter Yarn Type",
              keyboardType: TextInputType.name,
              borderRadius: Dimensions.radius10,
              errorText: errorYarnType.toString() != 'null' ? errorYarnType.toString() : '',
            ),
          ],
        ),
        actions: [
          CustomElevatedButton(
            onPressed: () {
              setState(() {
                submitted = true;
              });
              if (_isFormValid()) {
                setState(() {
                  isLoading = !isLoading;
                });
                Map<String, dynamic> body = {
                  "yarn_type_id": widget.yarnTypeId != null ? widget.yarnTypeId.toString() : "",
                  "user_id" : HelperFunctions.getUserID(),
                  "yarn_name": yarnNameController.text,
                  "type_name": yarnTypeController.text,
                };
                if (widget.yarnTypeId == null) {
                  _addYarn(body);
                } else {
                  _updateYarn(body);
                }
              }
            },
            buttonText: "Submit",
          )
        ],
      ),
    );
  }

  String? _validateYarnName(String value) {
    if (value.isEmpty) {
      return 'Yarn Name is required';
    }
    return null;
  }

  String? _validateYarnType(String value) {
    if (value.isEmpty) {
      return 'Yarn Type is required';
    }
    return null;
  }

  bool _isFormValid() {
    String errorYarnName = _validateYarnName(yarnNameController.text) ?? '';
    String errorYarnType = _validateYarnType(yarnTypeController.text) ?? '';
    return errorYarnName.isEmpty || errorYarnType.isEmpty ? true : false;
  }

  Future<void> _addYarn(Map<String, dynamic> body) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      AddYarnModel? addYarnModel = await yarnServices.addYarn(body);
      if (addYarnModel?.message != null) {
        if (addYarnModel?.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            addYarnModel!.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).popAndPushNamed(AppRoutes.yarnTypeList);
        }  else {
          CustomApiSnackbar.show(
            context,
            'Error',
            addYarnModel!.message.toString(),
            mode: SnackbarMode.error,
          );
        }

        setState(() {
          isLoading = false;
        });
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again',
          mode: SnackbarMode.error,
        );
        setState(() {
          isLoading = false;
        });
      }
    } else {
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No Internet Connection',
        mode: SnackbarMode.warning,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateYarn(Map<String, dynamic> body) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      UpdateYarnModel? updateYarnModel = await yarnServices.updateYarn(body);
      if (updateYarnModel?.message != null) {
        if (updateYarnModel?.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            updateYarnModel!.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).popAndPushNamed(AppRoutes.yarnTypeList);
        }  else {
          CustomApiSnackbar.show(
            context,
            'Error',
            updateYarnModel!.message.toString(),
            mode: SnackbarMode.error,
          );
        }

        setState(() {
          isLoading = false;
        });
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again',
          mode: SnackbarMode.error,
        );
        setState(() {
          isLoading = false;
        });
      }
    } else {
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No Internet Connection',
        mode: SnackbarMode.warning,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _getYarnDetails() async {
    setState(() {
      isLoading = true;
    });
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      YarnDetailModel? yarnDetailModel = await yarnServices.viewYarn(widget.yarnTypeId!);
      if (yarnDetailModel?.message != null) {
        if (yarnDetailModel?.success == true) {
          yarnNameController.text = yarnDetailModel!.data!.yarnName.toString();
          yarnTypeController.text = yarnDetailModel.data!.typeName.toString();
          setState(() {
            isLoading = false;
          });
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            yarnDetailModel!.message.toString(),
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
    } else {
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No Internet Connection',
        mode: SnackbarMode.warning,
      );
      setState(() {
        isLoading = false;
      });
    }
  }
}

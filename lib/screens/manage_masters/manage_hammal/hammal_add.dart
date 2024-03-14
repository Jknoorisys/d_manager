import 'package:d_manager/api/manage_hammal_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/add_hammal_model.dart';
import 'package:d_manager/models/master_models/hammal_detail_model.dart';
import 'package:d_manager/models/master_models/update_hammal_model.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';

class HammalAdd extends StatefulWidget {
  final int? hammalId;
  const HammalAdd({Key? key, this.hammalId}) : super(key: key);

  @override
  _HammalAddState createState() => _HammalAddState();
}

class _HammalAddState extends State<HammalAdd> {
  final TextEditingController hammalNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool submitted = false;

  bool isLoading = false;
  ManageHammalServices hammalServices = ManageHammalServices();

  @override
  void dispose() {
    hammalNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.hammalId != null) {
      _getHammalDetails();
    }
  }
  @override
  Widget build(BuildContext context) {
    var errorHammalName = submitted == true ? _validateHammalName(hammalNameController.text) : null;
    var errorPhoneNumber = submitted == true ? _validatePhoneNumber(phoneNumberController.text) : null;
    var errorAddress = submitted == true ? _validateAddress(addressController.text) : null;
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
              widget.hammalId != null ? S.of(context).updateHammal : S.of(context).addHammal,
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
              controller: hammalNameController,
              labelText: "Enter Hammal Name",
              keyboardType: TextInputType.name,
              borderRadius: Dimensions.radius10,
              errorText: errorHammalName.toString() != 'null' ? errorHammalName.toString() : '',
            ),
            SizedBox(height: Dimensions.height15),
            CustomTextField(
              controller: phoneNumberController,
              labelText: "Enter Phone Number",
              keyboardType: TextInputType.phone,
              borderRadius: Dimensions.radius10,
              // errorText: errorPhoneNumber.toString() != 'null' ? errorPhoneNumber.toString() : '',
            ),
            // SizedBox(height: Dimensions.height15),
            // CustomTextField(
            //   controller: addressController,
            //   labelText: "Enter Address",
            //   keyboardType: TextInputType.name,
            //   borderRadius: Dimensions.radius10,
            //   maxLines: 4,
            //   errorText: errorAddress.toString() != 'null' ? errorAddress.toString() : '',
            // ),
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
                  "hammal_id": widget.hammalId != null ? widget.hammalId.toString() : "",
                  "user_id" : HelperFunctions.getUserID(),
                  "hammal_name": hammalNameController.text,
                  "hammal_phone_no": phoneNumberController.text,
                  // "hammal_address": addressController.text,
                };
                if (widget.hammalId == null) {
                  _addHammal(body);
                } else {
                  _updateHammal(body);
                }
              }
            },
            buttonText: "Submit",
          )
        ],
      ),
    );
  }

  String? _validateHammalName(String value) {
    if (value.isEmpty) {
      return 'Hammal Name is required';
    }
    return null;
  }

  String? _validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Phone Number is required';
    }

    if (value.length < 10) {
      return 'Phone Number must be 10 digits';
    }
    return null;
  }

  String? _validateAddress(String value) {
    if (value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  bool _isFormValid() {
    String errorHammalName = _validateHammalName(hammalNameController.text) ?? '';
    String errorPhoneNumber = _validatePhoneNumber(phoneNumberController.text) ?? '';
    String errorAddress = _validateAddress(addressController.text) ?? '';
    return errorHammalName.isEmpty ? true : false;
  }

  Future<void> _addHammal(Map<String, dynamic> body) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      AddHammalModel? addHammalModel = await hammalServices.addHammal(body);
      if (addHammalModel?.message != null) {
        if (addHammalModel?.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            addHammalModel!.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).popAndPushNamed(AppRoutes.hammalList);
        }  else {
          CustomApiSnackbar.show(
            context,
            'Error',
            addHammalModel!.message.toString(),
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
      setState(() {
        isLoading = false;
      });
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No Internet Connection',
        mode: SnackbarMode.warning,
      );
    }
  }

  Future<void> _updateHammal(Map<String, dynamic> body) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      UpdateHammalModel? updateHammalModel = await hammalServices.updateHammal(body);
      if (updateHammalModel?.message != null) {
        if (updateHammalModel?.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            updateHammalModel!.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).popAndPushNamed(AppRoutes.hammalList);
        }  else {
          CustomApiSnackbar.show(
            context,
            'Error',
            updateHammalModel!.message.toString(),
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
      setState(() {
        isLoading = false;
      });
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No Internet Connection',
        mode: SnackbarMode.warning,
      );
    }
  }

  Future<void> _getHammalDetails() async {
    setState(() {
      isLoading = true;
    });
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      HammalDetailModel? hammalDetailModel = await hammalServices.viewHammal(widget.hammalId!);
      if (hammalDetailModel?.message != null) {
        if (hammalDetailModel?.success == true) {
          hammalNameController.text = hammalDetailModel!.data!.hammalName.toString();
          phoneNumberController.text = hammalDetailModel.data!.hammalPhoneNo.toString();
          // addressController.text = hammalDetailModel.data!.hammalAddress.toString();
          setState(() {
            isLoading = false;
          });
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            hammalDetailModel!.message.toString(),
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
      setState(() {
        isLoading = false;
      });
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

import 'package:d_manager/api/manage_transport_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/add_transport_model.dart';
import 'package:d_manager/models/master_models/transport_detail_model.dart';
import 'package:d_manager/models/master_models/update_transport_model.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';

class TransportAdd extends StatefulWidget {
  final int? transportId;
  const TransportAdd({Key? key, this.transportId}) : super(key: key);

  @override
  _TransportAddState createState() => _TransportAddState();
}

class _TransportAddState extends State<TransportAdd> {
  final TextEditingController transportNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool submitted = false;

  bool isLoading = false;
  ManageTransportServices transportServices = ManageTransportServices();

  @override
  void dispose() {
    transportNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.transportId != null) {
      _getTransportDetails();
    }
  }
  @override
  Widget build(BuildContext context) {
    var errorTransportName = submitted == true ? _validateTransportName(transportNameController.text) : null;
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
              widget.transportId == null ? S.of(context).addTransport : S.of(context).updateTransport,
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
              controller: transportNameController,
              labelText: "Enter Transport Name",
              keyboardType: TextInputType.name,
              borderRadius: Dimensions.radius10,
              errorText: errorTransportName.toString() != 'null' ? errorTransportName.toString() : '',
            ),
            SizedBox(height: Dimensions.height15),
            CustomTextField(
              controller: phoneNumberController,
              labelText: "Enter Phone Number",
              keyboardType: TextInputType.phone,
              borderRadius: Dimensions.radius10,
              // errorText: errorPhoneNumber.toString() != 'null' ? errorPhoneNumber.toString() : '',
            ),
            SizedBox(height: Dimensions.height15),
            CustomTextField(
              controller: addressController,
              labelText: "Enter Address",
              keyboardType: TextInputType.name,
              borderRadius: Dimensions.radius10,
              maxLines: 4,
              // errorText: errorAddress.toString() != 'null' ? errorAddress.toString() : '',
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
                  "transport_id": widget.transportId != null ? widget.transportId.toString() : "",
                  "user_id" : HelperFunctions.getUserID(),
                  "transport_name": transportNameController.text,
                  "transport_phone_no": phoneNumberController.text,
                  "transport_address": addressController.text,
                };
                if (widget.transportId == null) {
                  _addTransport(body);
                } else {
                  _updateTransport(body);
                }
              }
            },
            buttonText: "Submit",
          )
        ],
      ),
    );
  }

  String? _validateTransportName(String value) {
    if (value.isEmpty) {
      return 'Transport Name is required';
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
    String errorTransportName = _validateTransportName(transportNameController.text) ?? '';
    String errorPhoneNumber = _validatePhoneNumber(phoneNumberController.text) ?? '';
    String errorAddress = _validateAddress(addressController.text) ?? '';
    return errorTransportName.isEmpty ? true : false;
  }

  Future<void> _addTransport(Map<String, dynamic> body) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      AddTransportModel? addTransportModel = await transportServices.addTransport(body);
      if (addTransportModel?.message != null) {
        if (addTransportModel?.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            addTransportModel!.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).popAndPushNamed(AppRoutes.transportList);
        }  else {
          CustomApiSnackbar.show(
            context,
            'Error',
            addTransportModel!.message.toString(),
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

  Future<void> _updateTransport(Map<String, dynamic> body) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      UpdateTransportModel? updateTransportModel = await transportServices.updateTransport(body);
      if (updateTransportModel?.message != null) {
        if (updateTransportModel?.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            updateTransportModel!.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).popAndPushNamed(AppRoutes.transportList);
        }  else {
          CustomApiSnackbar.show(
            context,
            'Error',
            updateTransportModel!.message.toString(),
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

  Future<void> _getTransportDetails() async {
    setState(() {
      isLoading = true;
    });
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      TransportDetailModel? transportDetailModel = await transportServices.viewTransport(widget.transportId!);
      if (transportDetailModel?.message != null) {
        if (transportDetailModel?.success == true) {
          transportNameController.text = transportDetailModel!.data!.transportName.toString();
          phoneNumberController.text = transportDetailModel.data!.transportPhoneNo.toString();
          addressController.text = transportDetailModel.data!.transportAddress.toString();
          setState(() {
            isLoading = false;
          });
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            transportDetailModel!.message.toString(),
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

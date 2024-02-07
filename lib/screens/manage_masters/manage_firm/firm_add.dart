import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FirmAdd extends StatefulWidget {
  final Map<String, dynamic>? firmData;
  const FirmAdd({Key? key, this.firmData}) : super(key: key);
  @override
  _FirmAddState createState() => _FirmAddState();
}

class _FirmAddState extends State<FirmAdd> {
  final TextEditingController partyNameController = TextEditingController();
  final TextEditingController firmNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController accountHolderNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController groupCodeController = TextEditingController();
  bool submitted = false;

  @override
  void initState() {
    super.initState();
    if (widget.firmData != null) {
      partyNameController.text = widget.firmData!['partyName'] ?? '';
      firmNameController.text = widget.firmData!['myFirm'] ?? '';
      addressController.text = widget.firmData!['address'] ?? '';
      gstNumberController.text = widget.firmData!['gstNumber'] ?? '';
      phoneNumberController.text = widget.firmData!['phoneNumber'] ?? '';
      accountHolderNameController.text = widget.firmData!['accountHolderName'] ?? '';
      bankNameController.text = widget.firmData!['bankName'] ?? '';
      ifscCodeController.text = widget.firmData!['ifscCode'] ?? '';
      accountNumberController.text = widget.firmData!['accountNumber'] ?? '';
      groupCodeController.text = widget.firmData!['groupCode'] ?? '';
    }
  }
  @override
  Widget build(BuildContext context) {
    var errorFirmName = submitted == true ? _validateFirmName(firmNameController.text) : null,
        errorPartyName = submitted == true ? _validatePartyName(partyNameController.text) : null,
        errorAddress = submitted == true ? _validateAddress(addressController.text) : null,
        errorGSTNumber = submitted == true ? _validateGSTNumber(gstNumberController.text) : null,
        errorPhoneNumber = submitted == true ? _validatePhoneNumber(phoneNumberController.text) : null,
        errorAccountHolderName = submitted == true ? _validateAccountHolderName(accountHolderNameController.text) : null,
        errorBankName = submitted == true ? _validateBankName(bankNameController.text) : null,
        errorIFSCCode = submitted == true ? _validateIFSCCode(ifscCodeController.text) : null,
        errorAccountNumber = submitted == true ? _validateAccountNumber(accountNumberController.text) : null,
        errorGroupCode = submitted == true ? _validateGroupCode(groupCodeController.text) : null;
    return CustomDrawer(
        content: CustomBody(
          title: widget.firmData == null ? S.of(context).addFirm : S.of(context).editFirm,
          content: Padding(
            padding: EdgeInsets.only(left: Dimensions.height10, right: Dimensions.height10, bottom: Dimensions.height20),
            child: Card(
              elevation: 10,
              color: AppTheme.white,
              shadowColor: AppTheme.nearlyWhite,
              surfaceTintColor: AppTheme.nearlyWhite,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.height20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Party Details
                      Text(
                        "Party Details",
                        style: AppTheme.heading2,
                      ),
                      Gap(Dimensions.height10),

                      CustomTextField(
                        controller: partyNameController,
                        labelText: "Enter Party Name (nickname)",
                        keyboardType: TextInputType.name,
                        borderRadius: Dimensions.radius10,
                        errorText: errorPartyName.toString() != 'null' ? errorPartyName.toString() : '',
                      ),
                      Gap(Dimensions.height15),

                      CustomTextField(
                        controller: firmNameController,
                        labelText: "Firm Name",
                        keyboardType: TextInputType.name,
                        borderRadius: Dimensions.radius10,
                        errorText: errorFirmName.toString() != 'null' ? errorFirmName.toString() : '',
                      ),
                      Gap(Dimensions.height15),

                      CustomTextField(
                        controller: addressController,
                        labelText: "Address",
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        borderRadius: Dimensions.radius10,
                        errorText: errorAddress.toString() != 'null' ? errorAddress.toString() : '',
                      ),
                      Gap(Dimensions.height15),

                      CustomTextField(
                        controller: gstNumberController,
                        labelText: "GST Number",
                        keyboardType: TextInputType.name,
                        borderRadius: Dimensions.radius10,
                        errorText: errorGSTNumber.toString() != 'null' ? errorGSTNumber.toString() : '',
                      ),
                      Gap(Dimensions.height15),

                      CustomTextField(
                        controller: phoneNumberController,
                        labelText: "Phone Number",
                        keyboardType: TextInputType.phone,
                        borderRadius: Dimensions.radius10,
                        errorText: errorPhoneNumber.toString() != 'null' ? errorPhoneNumber.toString() : '',
                      ),
                      Gap(Dimensions.height15),

                      CustomTextField(
                        controller: groupCodeController,
                        labelText: "Group Code",
                        keyboardType: TextInputType.number,
                        borderRadius: Dimensions.radius10,
                        errorText: errorGroupCode.toString() != 'null' ? errorGroupCode.toString() : '',
                      ),
                      Gap(Dimensions.height30),

                      // Bank Account Details
                      Text(
                        "Bank Account Details",
                        style: AppTheme.heading2,
                      ),
                      Gap(Dimensions.height10),

                      CustomTextField(
                          controller: accountHolderNameController,
                          labelText: "Account Holder Name",
                          keyboardType: TextInputType.name,
                          borderRadius: Dimensions.radius10,
                          errorText: errorAccountHolderName.toString() != 'null' ? errorAccountHolderName.toString() : ''
                      ),
                      Gap(Dimensions.height15),

                      CustomTextField(
                          controller: bankNameController,
                          labelText: "Bank Name",
                          keyboardType: TextInputType.name,
                          borderRadius: Dimensions.radius10,
                          errorText: errorBankName.toString() != 'null' ? errorBankName.toString() : ''
                      ),
                      Gap(Dimensions.height15),

                      CustomTextField(
                          controller: ifscCodeController,
                          labelText: "IFSC Code",
                          keyboardType: TextInputType.name,
                          borderRadius: Dimensions.radius10,
                          errorText: errorIFSCCode.toString() != 'null' ? errorIFSCCode.toString() : ''
                      ),
                      Gap(Dimensions.height15),

                      CustomTextField(
                          controller: accountNumberController,
                          labelText: "Account Number",
                          keyboardType: TextInputType.number,
                          borderRadius: Dimensions.radius10,
                          errorText: errorAccountNumber.toString() != 'null' ? errorAccountNumber.toString() : ''
                      ),
                      Gap(Dimensions.height20),

                      CustomElevatedButton(
                        onPressed: () {
                          setState(() {
                            submitted = true;
                          });
                          if (_isFormValid()) {
                            Navigator.of(context).pushReplacementNamed(AppRoutes.firmList);
                          }
                        },
                        buttonText: "Submit",
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        )
    );
  }

  String? _validatePartyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Party Name is required';
    }
    return null;
  }

  String? _validateFirmName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Firm Name is required';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  String? _validateGSTNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter GST Number';
    }
    if (value.length != 15) {
      return 'GST Number should be 15 characters long';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Phone Number';
    }

    if (value.length < 10 || value.length > 10) {
      return 'Phone Number should be 10 digits long';
    }

    return null;
  }

  String? _validateAccountHolderName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Account Holder Name is required';
    }
    return null;
  }

  String? _validateBankName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bank Name is required';
    }
    return null;
  }

  String? _validateIFSCCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'IFSC Code is required';
    }

    if (value.length != 11) {
      return 'IFSC Code should be 11 characters long';
    }

    // RegExp ifscRegex = RegExp(r'^[A-Za-z]{4}\d{7}$');
    // if (!ifscRegex.hasMatch(value)) {
    //   return 'Invalid IFSC Code format';
    // }
    return null;
  }

  String? _validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Account Number is required';
    }
    if (value.length < 8 || value.length > 20) {
      return 'Account Number should be between 8 and 20 characters';
    }

    // RegExp accountNumberRegex = RegExp(r'^[0-9]+$');
    // if (!accountNumberRegex.hasMatch(value)) {
    //   return 'Invalid Account Number format';
    // }
    return null;
  }

  String? _validateGroupCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Group Code is required';
    }
    return null;
  }

  bool _isFormValid() {
    String partyNameError = _validatePartyName(partyNameController.text) ?? '';
    String firmNameError = _validateFirmName(firmNameController.text) ?? '';
    String addressError = _validateAddress(addressController.text) ?? '';
    String gstNumberError = _validateGSTNumber(gstNumberController.text) ?? '';
    String phoneNumberError = _validatePhoneNumber(phoneNumberController.text) ?? '';
    String accountHolderNameError = _validateAccountHolderName(accountHolderNameController.text) ?? '';
    String bankNameError = _validateBankName(bankNameController.text) ?? '';
    String ifscCodeError = _validateIFSCCode(ifscCodeController.text) ?? '';
    String accountNumberError = _validateAccountNumber(accountNumberController.text) ?? '';
    String groupCodeError = _validateGroupCode(groupCodeController.text) ?? '';

    return partyNameError.isEmpty && firmNameError.isEmpty && addressError.isEmpty && gstNumberError.isEmpty && phoneNumberError.isEmpty && accountHolderNameError.isEmpty && bankNameError.isEmpty && ifscCodeError.isEmpty && accountNumberError.isEmpty && groupCodeError.isEmpty ? true : false;
  }
}

import 'package:d_manager/api/dropdown_services.dart';
import 'package:d_manager/api/manage_party_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/dropdown_models/dropdown_state_list_model.dart';
import 'package:d_manager/models/master_models/add_party_model.dart';
import 'package:d_manager/models/master_models/party_detail_model.dart';
import 'package:d_manager/models/master_models/update_party_model.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PartyAdd extends StatefulWidget {
  final int? partyId;
  const PartyAdd({Key? key, this.partyId}) : super(key: key);

  @override
  _PartyAddState createState() => _PartyAddState();
}

class _PartyAddState extends State<PartyAdd> {
  final TextEditingController partyNameController = TextEditingController();
  final TextEditingController firmNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();
  final TextEditingController panNumberController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController accountHolderNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  bool isInMaharashtra = true;
  bool submitted = false;
  bool isLoading = false;
  bool noRecordFound = false;
  bool isNetworkAvailable = true;
  var selectedState;
  List<StateDetail> states = [];
  DropdownServices dropdownServices = DropdownServices();
  ManagePartyServices partyServices = ManagePartyServices();

  @override
  void initState() {
    super.initState();
    _getStates();
    if (widget.partyId != null) {
      _getPartyDetails();
    }
  }

  @override
  void dispose() {
    partyNameController.dispose();
    firmNameController.dispose();
    addressController.dispose();
    gstNumberController.dispose();
    panNumberController.dispose();
    phoneNumberController.dispose();
    accountHolderNameController.dispose();
    bankNameController.dispose();
    ifscCodeController.dispose();
    accountNumberController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var errorFirmName = submitted == true ? _validateFirmName(firmNameController.text) : null,
        errorPartyName = submitted == true ? _validatePartyName(partyNameController.text) : null,
        errorAddress = submitted == true ? _validateAddress(addressController.text) : null,
        errorGSTNumber = submitted == true ? _validateGSTNumber(gstNumberController.text) : null,
        errorPanNumber = submitted == true ? _validatePanNumber(panNumberController.text) : null,
        errorPhoneNumber = submitted == true ? _validatePhoneNumber(phoneNumberController.text) : null,
        errorAccountHolderName = submitted == true ? _validateAccountHolderName(accountHolderNameController.text) : null,
        errorBankName = submitted == true ? _validateBankName(bankNameController.text) : null,
        errorIFSCCode = submitted == true ? _validateIFSCCode(ifscCodeController.text) : null,
        errorAccountNumber = submitted == true ? _validateAccountNumber(accountNumberController.text) : null,
          errorState = submitted == true ? selectedState == null ? 'Party State is required' : null : null;

    return CustomDrawer(
        content: CustomBody(
          title: widget.partyId == null ? S.of(context).addParty : 'Edit Party',
          isLoading: isLoading,
          noRecordFound: noRecordFound,
          internetNotAvailable: isNetworkAvailable,
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
                        controller: phoneNumberController,
                        labelText: "Phone Number",
                        keyboardType: TextInputType.phone,
                        borderRadius: Dimensions.radius10,
                        errorText: errorPhoneNumber.toString() != 'null' ? errorPhoneNumber.toString() : '',
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
                        controller: panNumberController,
                        labelText: "PAN Number",
                        keyboardType: TextInputType.text,
                        borderRadius: Dimensions.radius10,
                        errorText: errorPanNumber.toString() != 'null' ? errorPanNumber.toString() : '',
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

                      CustomApiDropdown(
                          hintText: 'Select Party State',
                          width: double.infinity,
                          dropdownItems: states.map((e) => DropdownMenuItem<dynamic>(value: e.stateId!, child: BigText(text: e.stateName!, size: Dimensions.font14,))).toList(),
                          selectedValue: selectedState,
                          errorText: errorState.toString() != 'null' ? errorState.toString() : null,
                          onChanged: (newValue) {
                            setState(() {
                              selectedState = newValue!;
                            });
                          }
                      ),
                      Gap(Dimensions.height20),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "Select Party State:",
                      //       style: AppTheme.heading2,
                      //     ),
                      //     Row(
                      //       children: [
                      //         Radio(
                      //           value: true,
                      //           groupValue: isInMaharashtra,
                      //           onChanged: (value) {
                      //             setState(() {
                      //               isInMaharashtra = value as bool;
                      //             });
                      //           },
                      //         ),
                      //         const Text("In Maharashtra"),
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Radio(
                      //           value: false,
                      //           groupValue: isInMaharashtra,
                      //           onChanged: (value) {
                      //             setState(() {
                      //               isInMaharashtra = value as bool;
                      //             });
                      //           },
                      //         ),
                      //         const Text("Outside of Maharashtra"),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // Gap(Dimensions.height20),

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
                              "party_id": widget.partyId != null ? widget.partyId.toString() : "",
                              "user_id" : HelperFunctions.getUserID(),
                              "party_name": partyNameController.text,
                              "firm_name": firmNameController.text,
                              "address": addressController.text,
                              "gst_number": gstNumberController.text,
                              "pan_number": panNumberController.text,
                              "phone_number": phoneNumberController.text,
                              "account_holder_name": accountHolderNameController.text,
                              "bank_name": bankNameController.text,
                              "ifsc_code": ifscCodeController.text,
                              "account_number": accountNumberController.text,
                              "state_id": selectedState.toString(),
                            };
                            if (widget.partyId == null) {
                              _addParty(body);
                            } else {
                              _updateParty(body);
                            }
                          }
                        },
                        buttonText: "Submit",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
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

    // Additional validation for Maharashtra-specific criteria
    if (isInMaharashtra) {
      if (!value.startsWith('27')) {
        return 'GST Number should start with "27" for Maharashtra';
      }
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

  String? _validatePanNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter PAN Number';
    }

    if (value.length != 10) {
      return 'PAN Number should be 10 characters long';
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

  bool _isFormValid() {
    String partyNameError = _validatePartyName(partyNameController.text) ?? '';
    String firmNameError = _validateFirmName(firmNameController.text) ?? '';
    String addressError = _validateAddress(addressController.text) ?? '';
    String gstNumberError = _validateGSTNumber(gstNumberController.text) ?? '';
    String panNumberError = _validatePanNumber(panNumberController.text) ?? '';
    String phoneNumberError = _validatePhoneNumber(phoneNumberController.text) ?? '';
    String accountHolderNameError = _validateAccountHolderName(accountHolderNameController.text) ?? '';
    String bankNameError = _validateBankName(bankNameController.text) ?? '';
    String ifscCodeError = _validateIFSCCode(ifscCodeController.text) ?? '';
    String accountNumberError = _validateAccountNumber(accountNumberController.text) ?? '';

    return partyNameError.isEmpty && firmNameError.isEmpty && addressError.isEmpty && gstNumberError.isEmpty && panNumberError.isEmpty && phoneNumberError.isEmpty && accountHolderNameError.isEmpty && bankNameError.isEmpty && ifscCodeError.isEmpty && accountNumberError.isEmpty ? true : false;
  }

  Future<void> _getStates() async {
    DropdownStateListModel? response = await dropdownServices.stateList();
    if (response != null) {
      setState(() {
        states.addAll(response.data!);
        isLoading = false;
      });
    }
  }

  Future<void> _addParty(Map<String, dynamic> body) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      AddPartyModel? addPartyModel = await partyServices.addParty(body);
      if (addPartyModel?.message != null) {
        if (addPartyModel?.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            addPartyModel!.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).pushReplacementNamed(AppRoutes.partyList);
        }  else {
          CustomApiSnackbar.show(
            context,
            'Error',
            addPartyModel!.message.toString(),
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

  Future<void> _updateParty(Map<String, dynamic> body) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      UpdatePartyModel? updatePartyModel = await partyServices.updateParty(body);
      if (updatePartyModel?.message != null) {
        if (updatePartyModel?.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            updatePartyModel!.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).pushReplacementNamed(AppRoutes.partyList);
        }  else {
          CustomApiSnackbar.show(
            context,
            'Error',
            updatePartyModel!.message.toString(),
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

  Future<void> _getPartyDetails() async {
    setState(() {
      isLoading = true;
    });
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      PartyDetailModel? partyDetailModel = await partyServices.viewParty(widget.partyId!);
      if (partyDetailModel?.message != null) {
        if (partyDetailModel?.success == true) {
          if (partyDetailModel?.data != null) {
            partyNameController.text = partyDetailModel!.data!.partyName ?? '';
            firmNameController.text = partyDetailModel.data!.firmName ?? '';
            addressController.text = partyDetailModel.data!.address ?? '';
            gstNumberController.text = partyDetailModel.data!.gstNumber ?? '';
            panNumberController.text = partyDetailModel.data!.panNumber ?? '';
            phoneNumberController.text = partyDetailModel.data!.phoneNumber ?? '';
            accountHolderNameController.text = partyDetailModel.data!.bankDetails?.accountHolderName ?? '';
            bankNameController.text = partyDetailModel.data!.bankDetails?.bankName ?? '';
            ifscCodeController.text = partyDetailModel.data!.bankDetails?.ifscCode ?? '';
            accountNumberController.text = partyDetailModel.data!.bankDetails?.accountNumber ?? '';
            // isInMaharashtra = partyDetailModel.data!.state == 'maharashtra' ? true : false;
            selectedState = partyDetailModel.data!.stateId;
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              noRecordFound = true;
              isLoading = false;
            });
          }
        } else {
          setState(() {
            isLoading = false;
          });
          CustomApiSnackbar.show(
            context,
            'Error',
            partyDetailModel!.message.toString(),
            mode: SnackbarMode.error,
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
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
    }
  }
}

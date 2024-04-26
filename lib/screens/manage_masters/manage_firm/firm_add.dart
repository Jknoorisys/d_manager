import 'dart:io';
import 'package:d_manager/api/manage_firm_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/add_firm_model.dart';
import 'package:d_manager/models/master_models/firm_detail_model.dart';
import 'package:d_manager/models/master_models/update_firm_model.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class FirmAdd extends StatefulWidget {
  final int? firmId;
  const FirmAdd({Key? key, this.firmId}) : super(key: key);
  @override
  _FirmAddState createState() => _FirmAddState();
}

class _FirmAddState extends State<FirmAdd> {
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
  final TextEditingController groupCodeController = TextEditingController();
  bool submitted = false;

  bool isLoading = false;
  dynamic _selectedFile;
  ManageFirmServices manageFirmServices = ManageFirmServices();

  _imgFromGallery() async {
    try {
      final File? pickedFile =
      await HelperFunctions.imagePicker(ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedFile = pickedFile;
        });
      }
    } catch (e) {
      setState(() {});
    }
  }
  _imgFromCamera() async {
    try {
      final File? pickedFile =
      await HelperFunctions.imagePicker(ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _selectedFile = pickedFile;
        });
      }
    } catch (e) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.firmId != null) {
      _getFirmDetails();
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
    groupCodeController.dispose();
    _selectedFile = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var errorFirmName = submitted == true ? _validateFirmName(firmNameController.text) : null,
        errorPartyName = submitted == true ? _validatePartyName(partyNameController.text) : null,
        errorAddress = submitted == true ? _validateAddress(addressController.text) : null,
        errorGSTNumber = submitted == true ? _validateGSTNumber(gstNumberController.text) : null,
        errorPANNumber = submitted == true ? _validatePANNumber(panNumberController.text) : null,
        errorPhoneNumber = submitted == true ? _validatePhoneNumber(phoneNumberController.text) : null,
        errorAccountHolderName = submitted == true ? _validateAccountHolderName(accountHolderNameController.text) : null,
        errorBankName = submitted == true ? _validateBankName(bankNameController.text) : null,
        errorIFSCCode = submitted == true ? _validateIFSCCode(ifscCodeController.text) : null,
        errorAccountNumber = submitted == true ? _validateAccountNumber(accountNumberController.text) : null,
        errorGroupCode = submitted == true ? _validateGroupCode(groupCodeController.text) : null;
    return CustomDrawer(
        content: CustomBody(
          isLoading: isLoading,
          title: widget.firmId == null ? S.of(context).addFirm : S.of(context).editFirm,
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
                        "Firm Details",
                        style: AppTheme.heading2,
                      ),
                      Gap(Dimensions.height10),

                      CustomTextField(
                        controller: partyNameController,
                        labelText: "Owner Name (nickname)",
                        keyboardType: TextInputType.name,
                        borderRadius: Dimensions.radius10,
                        errorText: errorPartyName.toString() != 'null' ? errorPartyName.toString() : '',
                        autoFocus: true,
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
                        errorText: errorPANNumber.toString() != 'null' ? errorPANNumber.toString() : '',
                      ),
                      Gap(Dimensions.height15),

                      CustomTextField(
                        controller: groupCodeController,
                        labelText: "Group Code",
                        keyboardType: TextInputType.text,
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
                      Gap(Dimensions.height15),

                      FittedBox(
                      fit: BoxFit.contain,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => showPickerDialog(context),
                          );
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Container(
                                    height: Dimensions.height50,
                                    width: MediaQuery.of(context).size.width / 3.6,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppTheme.black, width: 0.2),
                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius10/2)),
                                      color: AppTheme.white,
                                    ),
                                    child: _selectedFile == null ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          color: AppTheme.deactivatedText,
                                          size: Dimensions.height20,
                                        ),
                                        Text(
                                          "Upload Signature",
                                          style: TextStyle(
                                            color: AppTheme.grey,
                                            fontSize: Dimensions.font12/2.5,
                                          ),
                                        ),
                                      ],
                                    ) : ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                        child: _selectedFile != null
                                            ? _selectedFile is File
                                            ? Image.file(
                                          _selectedFile,
                                          fit: BoxFit.cover,
                                        )
                                            : CachedNetworkImage(
                                          imageUrl: '$baseUrl/$_selectedFile',
                                          errorWidget: (_, __, ___) =>
                                              Image.asset(AppImages.appLogoTransparent),
                                          fit: BoxFit.cover,
                                        ): const SizedBox(),
                                    ) ,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                      // Gap(Dimensions.height15),
                      // CustomElevatedButton(
                      //   onPressed: () async {
                      //     await _selectFile();
                      //   },
                      //   buttonText: 'Upload Signature Image',
                      //   isBackgroundGradient: false,
                      //   backgroundColor: AppTheme.primary,
                      // ),
                      Gap(Dimensions.height20),

                      CustomElevatedButton(
                        onPressed: () {
                          setState(() {
                            submitted = true;
                          });
                          if (_isFormValid()) {
                            setState(() {
                              isLoading = !isLoading;
                            });
                            Map<String, String> body = {
                              "firm_id": widget.firmId != null ? widget.firmId.toString() : "",
                              "user_id" : HelperFunctions.getUserID(),
                              "owner_name": partyNameController.text,
                              "firm_name": firmNameController.text,
                              "address": addressController.text,
                              "gst_number": gstNumberController.text,
                              "pan_number": panNumberController.text,
                              "phone_number": phoneNumberController.text,
                              "account_holder_name": accountHolderNameController.text,
                              "bank_name": bankNameController.text,
                              "ifsc_code": ifscCodeController.text,
                              "account_number": accountNumberController.text,
                              "group_code": groupCodeController.text,
                            };
                            if (widget.firmId == null) {
                              _addFirm(body, _selectedFile);
                            } else {
                              var imageUrl = _selectedFile != null ? _selectedFile is File ? _selectedFile : null : null;
                              _updateFirm(body, imageUrl);
                            }
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

  Widget showPickerDialog(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: AlertDialog(
        surfaceTintColor: AppTheme.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius10),
        ),
        shadowColor: AppTheme.nearlyWhite,
        // title: Row(
        //   children: [
        //     Text('Choose option',
        //         style: AppTheme.hintText),
        //     Spacer(),
        //     IconButton(
        //       icon: Icon(Icons.close, color: AppTheme.deactivatedText),
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //       },
        //     ),
        //   ],
        // ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Choose from', style: AppTheme.hintText),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _imgFromGallery();
                    },
                    child: Text('Gallery',
                      style: AppTheme.hintText,
                    )),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _imgFromCamera();
                      setState(() {});
                    },
                    child: Text(
                      'Camera',
                      style: AppTheme.hintText,
                    )),
              ],
            ),
          ],
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
    return null;
  }

  String? _validatePANNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter PAN Number';
    }
    if (value.length != 10) {
      return 'PAN Number should be 10 characters long';
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
    String panNumberError = _validatePANNumber(panNumberController.text) ?? '';
    String phoneNumberError = _validatePhoneNumber(phoneNumberController.text) ?? '';
    String accountHolderNameError = _validateAccountHolderName(accountHolderNameController.text) ?? '';
    String bankNameError = _validateBankName(bankNameController.text) ?? '';
    String ifscCodeError = _validateIFSCCode(ifscCodeController.text) ?? '';
    String accountNumberError = _validateAccountNumber(accountNumberController.text) ?? '';
    String groupCodeError = _validateGroupCode(groupCodeController.text) ?? '';

    return partyNameError.isEmpty && firmNameError.isEmpty && addressError.isEmpty && gstNumberError.isEmpty && panNumberError.isEmpty && phoneNumberError.isEmpty && accountHolderNameError.isEmpty && bankNameError.isEmpty && ifscCodeError.isEmpty && accountNumberError.isEmpty && groupCodeError.isEmpty ? true : false;
  }

  Future<void> _addFirm(Map<String, String> body, File? signature) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      AddFirmModel? addFirmModel = await manageFirmServices.addFirm(body, signature);
      if (addFirmModel?.message != null) {
        if (addFirmModel?.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            addFirmModel!.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).pushReplacementNamed(AppRoutes.firmList);
        }  else {
          CustomApiSnackbar.show(
            context,
            'Error',
            addFirmModel!.message.toString(),
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
        'No internet connection',
        mode: SnackbarMode.warning,
      );
    }
  }

  Future<void> _updateFirm(Map<String, String> body, File? signature) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()){
      UpdateFirmModel? updateFirmModel = await manageFirmServices.updateFirm(body, signature);
      if (updateFirmModel?.message != null) {
        if (updateFirmModel?.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            updateFirmModel!.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).pushReplacementNamed(AppRoutes.firmList);
        }  else {
          CustomApiSnackbar.show(
            context,
            'Error',
            updateFirmModel!.message.toString(),
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
        'No internet connection',
        mode: SnackbarMode.warning,
      );
    }
  }

  Future<void> _getFirmDetails() async {
    setState(() {
      isLoading = true;
    });
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      FirmDetailModel? firmDetailModel = await manageFirmServices.viewFirm(widget.firmId!);
      if (firmDetailModel?.message != null) {
        if (firmDetailModel?.success == true) {
          partyNameController.text = firmDetailModel!.data!.ownerName ?? '';
          firmNameController.text = firmDetailModel.data!.firmName ?? '';
          addressController.text = firmDetailModel.data!.address ?? '';
          gstNumberController.text = firmDetailModel.data!.gstNumber ?? '';
          panNumberController.text = firmDetailModel.data!.panNumber ?? '';
          phoneNumberController.text = firmDetailModel.data!.phoneNumber ?? '';
          accountHolderNameController.text = firmDetailModel.data!.bankDetails?.accountHolderName ?? '';
          bankNameController.text = firmDetailModel.data!.bankDetails?.bankName ?? '';
          ifscCodeController.text = firmDetailModel.data!.bankDetails?.ifscCode ?? '';
          accountNumberController.text = firmDetailModel.data!.bankDetails?.accountNumber ?? '';
          groupCodeController.text = firmDetailModel.data!.groupCode ?? '';
          _selectedFile = firmDetailModel.data!.signature ?? null;
          setState(() {
            isLoading = false;
          });
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            firmDetailModel!.message.toString(),
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
        'No internet connection',
        mode: SnackbarMode.warning,
      );
    }
  }
}

import 'package:d_manager/api/manage_cloth_quality_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/add_cloth_quality_model.dart';
import 'package:d_manager/models/master_models/cloth_quality_detail_model.dart';
import 'package:d_manager/models/master_models/update_cloth_quality_model.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ClothQualityAdd extends StatefulWidget {
  final int? clothQualityId;
  const ClothQualityAdd({Key? key, this.clothQualityId}) : super(key: key);

  @override
  _ClothQualityAddState createState() => _ClothQualityAddState();
}

class _ClothQualityAddState extends State<ClothQualityAdd> {
  final TextEditingController clothQualityController = TextEditingController();
  bool submitted = false;
  bool isLoading = false;
  ManageClothQualityServices clothQualityServices = ManageClothQualityServices();

  @override
  void dispose() {
    clothQualityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.clothQualityId != null) {
      _getClothQualityDetails();
    }
  }
  @override
  Widget build(BuildContext context) {
    var errorClothQualityName = submitted == true ? _validateClothQualityName(clothQualityController.text) : null;
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
              S.of(context).addClothQuality,
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
              controller: clothQualityController,
              labelText: "Enter Cloth Quality",
              keyboardType: TextInputType.name,
              borderRadius: Dimensions.radius10,
              errorText: errorClothQualityName.toString() != 'null' ? errorClothQualityName.toString() : '',
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
                if (HelperFunctions.checkInternet() == false) {
                  CustomApiSnackbar.show(
                    context,
                    'Warning',
                    'No internet connection',
                    mode: SnackbarMode.warning,
                  );
                } else {
                  setState(() {
                    isLoading = !isLoading;
                  });
                  Map<String, dynamic> body = {
                    "quality_id": widget.clothQualityId != null ? widget.clothQualityId.toString() : "",
                    "user_id" : HelperFunctions.getUserID(),
                    "quality_name": clothQualityController.text,
                  };
                  if (widget.clothQualityId == null) {
                    _addClothQuality(body);
                  } else {
                    _updateClothQuality(body);
                  }
                }
              }
            },
            buttonText: "Submit",
          )
        ],
      ),
    );
  }

  String? _validateClothQualityName(String value) {
    if (value.isEmpty) {
      return 'Cloth Quality is required';
    }
    return null;
  }

  bool _isFormValid() {
    String errorClothQualityName = _validateClothQualityName(clothQualityController.text) ?? '';
    return errorClothQualityName.isEmpty ? true : false;
  }

  Future<void> _addClothQuality(Map<String, dynamic> body) async {
    AddClothQualityModel? addClothQualityModel = await clothQualityServices.addClothQuality(body);
    if (addClothQualityModel?.message != null) {
      if (addClothQualityModel?.success == true) {
        CustomApiSnackbar.show(
          context,
          'Success',
          addClothQualityModel!.message.toString(),
          mode: SnackbarMode.success,
        );
        Navigator.of(context).popAndPushNamed(AppRoutes.clothQualityList);
      }  else {
        CustomApiSnackbar.show(
          context,
          'Error',
          addClothQualityModel!.message.toString(),
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
  }

  Future<void> _updateClothQuality(Map<String, dynamic> body) async {
    UpdateClothQualityModel? updateClothQualityModel = await clothQualityServices.updateClothQuality(body);
    if (updateClothQualityModel?.message != null) {
      if (updateClothQualityModel?.success == true) {
        CustomApiSnackbar.show(
          context,
          'Success',
          updateClothQualityModel!.message.toString(),
          mode: SnackbarMode.success,
        );
        Navigator.of(context).pop();
      }  else {
        CustomApiSnackbar.show(
          context,
          'Error',
          updateClothQualityModel!.message.toString(),
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
  }

  Future<void> _getClothQualityDetails() async {
    setState(() {
      isLoading = true;
    });
    ClothQualityDetailModel? yarnDetailModel = await clothQualityServices.viewClothQuality(widget.clothQualityId!);
    if (yarnDetailModel?.message != null) {
      if (yarnDetailModel?.success == true) {
        clothQualityController.text = yarnDetailModel!.data!.qualityName.toString();
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
  }
}

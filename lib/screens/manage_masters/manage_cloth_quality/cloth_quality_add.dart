import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ClothQualityAdd extends StatefulWidget {
  final Map<String, dynamic>? clothQualityData;
  const ClothQualityAdd({Key? key, this.clothQualityData}) : super(key: key);

  @override
  _ClothQualityAddState createState() => _ClothQualityAddState();
}

class _ClothQualityAddState extends State<ClothQualityAdd> {
  final TextEditingController clothQualityController = TextEditingController();
  bool submitted = false;

  @override
  void initState() {
    super.initState();
    if (widget.clothQualityData != null) {
      clothQualityController.text = widget.clothQualityData!['clothQuality'] ?? '';
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
                Navigator.of(context).pop();
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
}

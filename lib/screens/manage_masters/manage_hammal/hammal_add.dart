import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';

class HammalAdd extends StatefulWidget {
  final Map<String, dynamic>? hammalData;
  const HammalAdd({Key? key, this.hammalData}) : super(key: key);

  @override
  _HammalAddState createState() => _HammalAddState();
}

class _HammalAddState extends State<HammalAdd> {
  final TextEditingController hammalNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool submitted = false;

  @override
  void initState() {
    super.initState();
    if (widget.hammalData != null) {
      hammalNameController.text = widget.hammalData!['hammalName'] ?? '';
      phoneNumberController.text = widget.hammalData!['phoneNumber'] ?? '';
      descriptionController.text = widget.hammalData!['description'] ?? '';
    }
  }
  @override
  Widget build(BuildContext context) {
    var errorHammalName = submitted == true ? _validateHammalName(hammalNameController.text) : null;
    var errorPhoneNumber = submitted == true ? _validatePhoneNumber(phoneNumberController.text) : null;
    var errorDescription = submitted == true ? _validateDescription(descriptionController.text) : null;
    return AlertDialog(
      backgroundColor: AppTheme.white,
      elevation: 10,
      surfaceTintColor: AppTheme.white,
      shadowColor: AppTheme.primary.withOpacity(0.5),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).addHammal,
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
            errorText: errorPhoneNumber.toString() != 'null' ? errorPhoneNumber.toString() : '',
          ),
          SizedBox(height: Dimensions.height15),
          CustomTextField(
            controller: descriptionController,
            labelText: "Enter Description",
            keyboardType: TextInputType.name,
            borderRadius: Dimensions.radius10,
            maxLines: 4,
            errorText: errorDescription.toString() != 'null' ? errorDescription.toString() : '',
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

  String? _validateDescription(String value) {
    if (value.isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  bool _isFormValid() {
    String errorHammalName = _validateHammalName(hammalNameController.text) ?? '';
    String errorPhoneNumber = _validatePhoneNumber(phoneNumberController.text) ?? '';
    String errorDescription = _validateDescription(descriptionController.text) ?? '';
    return errorHammalName.isEmpty || errorDescription.isEmpty || errorPhoneNumber.isEmpty ? true : false;
  }
}

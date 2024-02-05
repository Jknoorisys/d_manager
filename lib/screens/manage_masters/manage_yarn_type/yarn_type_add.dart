import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';

class YarnTypeAdd extends StatefulWidget {
  final Map<String, dynamic>? yarnTypeData;
  const YarnTypeAdd({Key? key, this.yarnTypeData}) : super(key: key);

  @override
  _YarnTypeAddState createState() => _YarnTypeAddState();
}

class _YarnTypeAddState extends State<YarnTypeAdd> {
  final TextEditingController yarnNameController = TextEditingController();
  final TextEditingController yarnTypeController = TextEditingController();
  bool submitted = false;

  @override
  void initState() {
    super.initState();
    if (widget.yarnTypeData != null) {
      yarnNameController.text = widget.yarnTypeData!['yarnName'] ?? '';
      yarnTypeController.text = widget.yarnTypeData!['yarnType'] ?? '';
    }
  }
  @override
  Widget build(BuildContext context) {
    var errorYarnName = submitted == true ? _validateYarnName(yarnNameController.text) : null;
    var errorYarnType = submitted == true ? _validateYarnType(yarnTypeController.text) : null;
    return AlertDialog(
      backgroundColor: AppTheme.white,
      elevation: 10,
      surfaceTintColor: AppTheme.white,
      shadowColor: AppTheme.primary.withOpacity(0.5),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).addYarnType,
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
              Navigator.of(context).pop();
            }
          },
          buttonText: "Submit",
        )
      ],
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
}

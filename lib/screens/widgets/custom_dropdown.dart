import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> dropdownItems;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  final double? height;
  final double? width;

  CustomDropdown({
    required this.dropdownItems,
    required this.selectedValue,
    required this.onChanged,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2, vertical: Dimensions.height10/2),
      height: height ?? Dimensions.height50,
      width: width ?? MediaQuery.of(context).size.width / 2.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        color: Colors.white,
        border: Border.all(color: AppTheme.black, width: 0.5),
      ),
      child: Center(
        child: DropdownButton<String>(
          dropdownColor: AppTheme.white,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.height10/2, vertical: Dimensions.height10/2),
          alignment: Alignment.center,
          isExpanded: true,
          isDense: true,
          value: selectedValue,
          onChanged: onChanged,
          underline: Container(
            height: 0,
            color: Colors.transparent,
          ),
          items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: BigText(text: value, size: Dimensions.font14,),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CustomApiDropdown<V, D> extends StatelessWidget {
  final List<DropdownMenuItem<V>> dropdownItems;
  final V? selectedValue;
  final ValueChanged<V?> onChanged;
  final String? hintText;
  final String? errorText;

  final double? height;
  final double? width;

  CustomApiDropdown({
    required this.dropdownItems,
    required this.selectedValue,
    required this.onChanged,
    this.height,
    this.width,
    this.hintText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2, vertical: Dimensions.height10 / 2),
          height: height ?? Dimensions.height50,
          width: width ?? MediaQuery.of(context).size.width / 2.65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius10),
            color: Colors.white,
            border: Border.all(color: errorText != null ? Colors.red : AppTheme.black, width: 0.5),
          ),
          child: Center(
            child: DropdownButton<V>(
              hint: hintText != null ? SmallText(text: hintText!, size: Dimensions.font14,) : null,
              dropdownColor: AppTheme.white,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.height10 / 2, vertical: Dimensions.height10 / 2),
              alignment: Alignment.center,
              isExpanded: true,
              isDense: true,
              value: selectedValue,
              onChanged: onChanged,
              underline: Container(
                height: 0,
                color: Colors.transparent,
              ),
              items: dropdownItems,
            ),
          ),
        ),
        if (errorText != null) SizedBox(height: Dimensions.width10,),
        if (errorText != null) SmallText(text: errorText!, color: Colors.red),
      ],
    );
  }
}



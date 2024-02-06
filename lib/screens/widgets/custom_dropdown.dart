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
      height: height ?? Dimensions.height50,
      width: width ?? MediaQuery.of(context).size.width / 2.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        color: Colors.white,
        border: Border.all(color: AppTheme.primary, width: 0.5),
      ),
      child: DropdownButton<String>(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2, vertical: Dimensions.height10/2),
        alignment: Alignment.center,
        isExpanded: true,
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
    );
  }
}

import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';

class CustomDropdownNew<T> extends StatelessWidget {
  final List<T> dropdownItems;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final String Function(T)? displayTextFunction;
  final double? height;
  final double? width;
  final String? hintText;
  final String? errorText;

  CustomDropdownNew({
    required this.dropdownItems,
    required this.selectedValue,
    required this.onChanged,
    this.displayTextFunction,
    this.height,
    this.width,
    this.hintText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2, vertical: Dimensions.height10/2),
          height: height ?? Dimensions.height50,
          width: width ?? MediaQuery.of(context).size.width / 2.65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius10),
            color: Colors.white,
            border: Border.all(color: AppTheme.black, width: 0.5),
          ),
          child: Center(
            child: DropdownButton<T>(
              dropdownColor: AppTheme.white,
              hint: hintText != null ? SmallText(text: hintText!, size: Dimensions.font14,) : null,
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
              items: dropdownItems.map<DropdownMenuItem<T>>((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child:BigText(text: displayTextFunction != null ? displayTextFunction!(item) : item.toString(), size: Dimensions.font14,),
                );
              }).toList(),
            ),
          ),
        ),
        if (errorText != null) SizedBox(height: Dimensions.width10,),
        if (errorText != null) SmallText(text: errorText!, color: Colors.red),
      ],
    );
  }
}

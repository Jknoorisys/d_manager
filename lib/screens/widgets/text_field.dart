import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  TextEditingController? controller;
  bool? isObscure;
  TextInputType? textInputType;
  bool? isSuffixIcon;
  bool? isPrefixIcon;
  final double? height;
  final double? width;
  final int? maxLines;
  final String? errorText;
  final Function? onTap;

  AppTextField({super.key, this.hintText, this.icon, this.controller, this.isObscure = false, this.textInputType = TextInputType.text,  this.isSuffixIcon = false, this.isPrefixIcon = false, this.height, this.width, this.maxLines, this.labelText, this.errorText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height ?? Dimensions.height50,
          width: width ?? double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: TextField(
            obscureText: isObscure! ? true : false,
            controller: controller,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: Dimensions.height10, horizontal: Dimensions.height10),
              hintText: hintText,
              labelText: labelText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: Dimensions.font12, fontWeight: FontWeight.w400),
              suffixIcon: isSuffixIcon == true ? GestureDetector(
                onTap: () {
                  onTap!();
                },
                child: Material(
                  elevation: 5.0,
                  color: AppTheme.primary,
                  shadowColor: AppTheme.primary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius10),
                    bottomRight: Radius.circular(Dimensions.radius10),
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
              ) : null,
              prefixIcon: isPrefixIcon == true ? GestureDetector(
                onTap: () {
                  onTap!();
                },
                child: Container(
                  margin: EdgeInsets.only(right: Dimensions.width10/1.2),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius10),
                      bottomLeft: Radius.circular(Dimensions.radius10),
                    ),
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
              ) : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius10),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius10),
                borderSide: const BorderSide(color: Colors.white),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius10),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
            cursorColor: Colors.grey,
          ),
        ),
        errorText != null ? Gap(Dimensions.height10/2) : Container(),
        errorText != null ? Text(errorText!, style: TextStyle(color: Colors.red, fontSize: Dimensions.font12)) : Container(),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hintText;
  final String errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? labelText;
  final bool isFilled;
  final Color? fillColor;
  final bool isBorder;
  final Color? borderColor;
  final double? borderRadius;
  final int? maxLines;
  final bool isObscure;
  final ValueChanged<String>? onChanged;
  final Function? onTap;
  final Function? onSuffixTap;

  const CustomTextField({
    super.key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.errorText = '',
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.isFilled = true,
    this.isBorder = true,
    this.isObscure = false,
    this.onChanged,
    this.onTap,
    this.fillColor,
    this.onSuffixTap,
    this.borderRadius,
    this.maxLines,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: borderColor ?? AppTheme.nearlyBlack),
      keyboardType: keyboardType,
      controller: controller ?? TextEditingController(),
      onChanged: onChanged,
      obscureText: isObscure,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: AppTheme.hintText.copyWith(color: borderColor ?? AppTheme.deactivatedText),
        hintText: hintText,
        hintStyle: AppTheme.hintText.copyWith(color: borderColor ?? AppTheme.deactivatedText),
        fillColor: fillColor ?? Colors.white,
        filled: isFilled,
        contentPadding: EdgeInsets.all(Dimensions.height15),
        prefixIcon: prefixIcon != null ? IconButton(icon: Icon(prefixIcon), color: AppTheme.primary, onPressed: (){
              onTap!();
            },) : null,
        suffixIcon: suffixIcon != null ? IconButton(icon: Icon(suffixIcon), color: AppTheme.primary, onPressed: (){
              onSuffixTap!();
            },) : null,
        errorText: errorText != '' ? errorText : null,
        errorStyle: TextStyle(color: Colors.red, fontSize: Dimensions.font12, fontWeight: FontWeight.w400),
        border: isBorder
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? Dimensions.radius30),
          borderSide: BorderSide(color: borderColor ?? AppTheme.nearlyBlack, width: 0.5),
        )
            : InputBorder.none,
        focusedBorder: isBorder
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? Dimensions.radius30),
          borderSide: BorderSide(color: borderColor ?? AppTheme.nearlyBlack, width: 0.5),
        )
            : InputBorder.none,
        focusedErrorBorder: isBorder
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? Dimensions.radius30),
          borderSide: const BorderSide(color: Colors.red, width: 0.5),
        )
            : InputBorder.none,
        errorBorder: isBorder
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? Dimensions.radius30),
          borderSide: const BorderSide(color: Colors.red, width: 0.5),
        )
            : InputBorder.none,
        enabledBorder: isBorder
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? Dimensions.radius30),
          borderSide: BorderSide(color: borderColor ?? AppTheme.nearlyBlack, width: 0.5),
        )
            : InputBorder.none,
      ),
    );
  }
}


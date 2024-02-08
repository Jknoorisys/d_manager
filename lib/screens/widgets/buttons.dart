import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double? textSize;
  final bool submitted;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.submitted = false,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          padding: EdgeInsets.symmetric(vertical: Dimensions.height15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: textSize ?? Dimensions.font16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final Color? iconColor;
  final double? iconSize;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? radius;
  final VoidCallback? onPressed;

  const CustomIconButton({super.key,
    required this.iconData,
    this.iconColor,
    this.iconSize,
    this.backgroundColor,
    this.width,
    this.height,
    this.radius,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? Dimensions.height50,
        width: width ?? Dimensions.height50,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppTheme.secondaryLight,
          borderRadius: BorderRadius.circular(radius ?? Dimensions.radius30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            iconData,
            color: iconColor ?? AppTheme.black,
            size: iconSize ?? Dimensions.font22,
          ),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? buttonText;
  final double? textSize;
  final bool submitted;
  final IconData? icon;
  final SvgPicture? image;
  final double? iconSize;
  final bool? isBackgroundGradient;
  final Color? backgroundColor;
  final Color? color;
  final VisualDensity? visualDensity;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.buttonText,
    this.submitted = false,
    this.textSize,
    this.icon,
    this.iconSize,
    this.isBackgroundGradient = true,
    this.color,
    this.backgroundColor,
    this.image, this.visualDensity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius30),
        gradient: isBackgroundGradient == true ? AppTheme.appGradient : null,
        color: backgroundColor,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          visualDensity: visualDensity ?? VisualDensity.standard,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, size: iconSize ?? Dimensions.font20, color: color ?? AppTheme.white,),
            if (icon != null) SizedBox(width: Dimensions.height10),
            if (image != null) image!,
            if (image != null) SizedBox(width: Dimensions.height10),
            BigText(
              text: buttonText ?? '',
                size: textSize ?? Dimensions.font16,
                color: color ?? AppTheme.white,
            ),
          ],
        ),
      ),
    );
  }
}


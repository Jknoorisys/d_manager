import 'package:d_manager/constants/dimension.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFFAF7F1);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);

  static const Color black = Color(0xff333333);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color darkGrey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xff333333);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const Color primary = Color(0xff39827e);
  static const Color secondary = Color(0xffb8db8f);
  static const Color secondaryLight = Color(0xffe6f3d8);

  static const appGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [primary, secondary],
  );

  static const appGradientLight = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [secondaryLight,Colors.white]
  );

  static const appGradientWhite = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [white,white]
  );

  static TextStyle display1 = TextStyle( // h4 -> display1
    fontWeight: FontWeight.bold,
    fontSize: Dimensions.font18 * 2,
    letterSpacing: 0.4,
    height: 0.9,
    color: black,
  );

  static TextStyle headline = TextStyle( // h5 -> headline
    fontWeight: FontWeight.bold,
    fontSize: Dimensions.font22,
    letterSpacing: 0.27,
    color: black,
  );

static TextStyle title = TextStyle( // h6 -> title

    fontWeight: FontWeight.bold,
    fontSize: Dimensions.font16,
    letterSpacing: 0.18,
    color: black,
  );

  static TextStyle heading2 = TextStyle( // h6 -> title
    fontWeight: FontWeight.w500,
    fontSize: Dimensions.font18,
    letterSpacing: 0.18,
    color: nearlyBlack,
  );

  static TextStyle subtitle = TextStyle( // subtitle2 -> subtitle
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.font16,
    letterSpacing: -0.04,
    color: darkText,
  );

  static TextStyle body2 = TextStyle( // body1 -> body2
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.font14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static TextStyle body1 = TextStyle( // body2 -> body1
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.font16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static TextStyle caption = TextStyle( // Caption -> caption
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.font12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static TextStyle hintText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.font14,
    letterSpacing: -0.05,
    color: primary, // was lightText
  );

  static Divider divider = const Divider(
    color: secondary,
    thickness: 1.2,
  );
}

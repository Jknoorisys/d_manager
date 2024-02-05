import 'package:flutter/material.dart';

class Dimensions {
  static double screenHeight = 0.0;
  static double screenWidth = 0.0;

  static double pageView = 0.0;
  static double pageViewContainer = 0.0;
  static double pageViewTextContainer = 0.0;

  static double height10 = 0.0;
  static double height15 = 0.0;
  static double height20 = 0.0;
  static double height25 = 0.0;
  static double height30 = 0.0;
  static double height40 = 0.0;
  static double height45 = 0.0;
  static double height50 = 0.0;
  static double height60 = 0.0;

  static double width10 = 0.0;
  static double width15 = 0.0;
  static double width20 = 0.0;
  static double width25 = 0.0;
  static double width30 = 0.0;
  static double width40 = 0.0;
  static double width50 = 0.0;
  static double width60 = 0.0;

  static double font12 = 0.0;
  static double font14 = 0.0;
  static double font15 = 0.0;
  static double font16 = 0.0;
  static double font18 = 0.0;
  static double font20 = 0.0;
  static double font22 = 0.0;
  static double font24 = 0.0;
  static double font26 = 0.0;

  static double iconSize16 = 0.0;
  static double iconSize20 = 0.0;
  static double iconSize24 = 0.0;

  static double radius10 = 0.0;
  static double radius15 = 0.0;
  static double radius20 = 0.0;
  static double radius30 = 0.0;

  static double listViewImgWidth = 0.0;
  static double listViewImgHeight = 0.0;
  static double listViewTextContainer = 0.0;

  static double imageSize = 0.0;

  static void initDimensions(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    pageView = screenHeight / 2.64;
    pageViewContainer = screenHeight / 3.84;
    pageViewTextContainer = screenHeight / 7.03;

    height10 = screenHeight / 84.4;
    height15 = screenHeight / 56.3;
    height20 = screenHeight / 42.2;
    height25 = screenHeight / 33.76;
    height30 = screenHeight / 28.13;
    height40 = screenHeight / 21.1;
    height45 = screenHeight / 18.75;
    height50 = screenHeight / 16.88;
    height60 = screenHeight / 14.06;

    width10 = screenWidth / 56.27;
    width15 = screenWidth / 37.51;
    width20 = screenWidth / 28.13;
    width25 = screenWidth / 22.5;
    width30 = screenWidth / 18.75;
    width40 = screenWidth / 14.06;
    width50 = screenWidth / 11.25;
    width60 = screenWidth / 9.38;

    font12 = screenHeight / 70.31;
    font14 = screenHeight / 60.16;
    font15 = screenHeight / 56.27;
    font16 = screenHeight / 52.75;
    font18 = screenHeight / 46.88;
    font20 = screenHeight / 42.2;
    font22 = screenHeight / 38.2;
    font24 = screenHeight / 35.16;
    font26 = screenHeight / 32.46;

    iconSize16 = screenHeight / 52.75;
    iconSize20 = screenHeight / 42.2;
    iconSize24 = screenHeight / 35.17;

    radius10 = screenHeight / 84.4;
    radius15 = screenHeight / 56.27;
    radius20 = screenHeight / 42.2;
    radius30 = screenHeight / 28.13;

    listViewImgWidth = screenWidth / 3.25;
    listViewImgHeight = screenHeight / 6.4;
    listViewTextContainer = screenWidth / 3.9;

    imageSize = screenHeight / 2.41;
  }
}

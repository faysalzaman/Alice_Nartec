import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_color.dart';
import 'dimensions.dart';

class CustomStyle {
  static var textStyle = TextStyle(
      color: CustomColor.greyColor,
      fontSize: Dimensions.defaultTextSize
  );

  static var hintTextStyle = TextStyle(
      color: Colors.grey.withOpacity(0.5),
      fontSize: Dimensions.defaultTextSize
  );

  static var listStyle = TextStyle(
      color: Colors.white,
      fontSize: Dimensions.largeTextSize,
  );

  static var defaultStyle = TextStyle(
      color: Colors.black,
      fontSize: Dimensions.largeTextSize
  );

  static var focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: BorderSide(color: Colors.transparent),
  );

  static var focusErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: BorderSide(color: Colors.transparent),
  );

  static var focusBorder2 = OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(Dimensions.radius),
      bottomLeft: Radius.circular(Dimensions.radius),
    ),
    borderSide: BorderSide(color: Colors.transparent),
  );

  static var focusErrorBorder2 = OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(Dimensions.radius),
      bottomLeft: Radius.circular(Dimensions.radius),
    ),
    borderSide: BorderSide(color: Colors.transparent),
  );

  static var searchBox = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
  );
}
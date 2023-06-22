import 'package:grosshop/utils/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:grosshop/utils/dimensions.dart';

class HeaderWidget extends StatefulWidget {
  final String? title;

  const HeaderWidget({Key? key, this.title}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.heightSize,
      ),
      child: Text(
        widget.title!,
        style: TextStyle(
            fontSize: Dimensions.extraLargeTextSize,
            fontWeight: FontWeight.bold,
            color: CustomColor.accentColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartQuantityWidget extends StatefulWidget {
  @override
  _CartQuantityWidgetState createState() => _CartQuantityWidgetState();
}

class _CartQuantityWidgetState extends State<CartQuantityWidget> {

  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Container(
            height: 25,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Colors.black.withOpacity(0.5)
                )
            ),
            child: Center(
              child: Icon(
                  Icons.remove,
                color: CustomColor.primaryColor,
              ),
            ),
          ),
          onTap: () {
            setState(() {
              if(qty > 1) {
                qty--;
              } else {
                Fluttertoast.showToast(
                    msg: Strings.quantityCantZero,
                    backgroundColor: Colors.red,
                    textColor: Colors.white
                );
              }
            });
          },
        ),
        SizedBox(width: Dimensions.widthSize * 0.5),
        Text(
          qty.toString(),
          style: TextStyle(
              color: CustomColor.accentColor,
              fontSize: Dimensions.largeTextSize,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(width: Dimensions.widthSize * 0.5),
        GestureDetector(
          child: Container(
            height: 25,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Colors.black.withOpacity(0.5)
                )
            ),
            child: Center(
              child: Icon(
                  Icons.add,
                color: CustomColor.primaryColor,
              ),
            ),
          ),
          onTap: () {
            setState(() {
              if(qty < 10) {
                qty++;
              } else {
                Fluttertoast.showToast(
                    msg: Strings.quantityCantMax,
                    backgroundColor: Colors.red,
                    textColor: Colors.white
                );
              }
            });
          },
        ),
      ],
    );
  }
}

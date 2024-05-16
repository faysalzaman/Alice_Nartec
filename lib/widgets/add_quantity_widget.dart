import 'package:flutter/material.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/dimensions.dart';

class AddQuantityWidget extends StatefulWidget {
  final int qty;
  final VoidCallback addCart;
  final VoidCallback minusCart;

  AddQuantityWidget({
    required this.qty,
    required this.addCart,
    required this.minusCart,
  });

  @override
  _AddQuantityWidgetState createState() => _AddQuantityWidgetState();
}

class _AddQuantityWidgetState extends State<AddQuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black.withOpacity(0.5))),
            child: Center(
              child: Icon(Icons.remove),
            ),
          ),
          onTap: widget.minusCart,
        ),
        SizedBox(width: Dimensions.widthSize * 2),
        Text(
          widget.qty.toString(),
          style: TextStyle(
              color: CustomColor.accentColor,
              fontSize: Dimensions.extraLargeTextSize * 1.5,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(width: Dimensions.widthSize * 2),
        GestureDetector(
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black.withOpacity(0.5))),
            child: Center(
              child: Icon(Icons.add),
            ),
          ),
          onTap: widget.addCart,
        ),
      ],
    );
  }
}

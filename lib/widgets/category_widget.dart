import 'package:grosshop/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final int? color;
  final String? icon;
  final String? title;
  final GestureTapCallback? onTap;

  const CategoryWidget(
      {Key? key, this.color, this.icon, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          GestureDetector(
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(Dimensions.radius),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: Color(color!),
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: Image.asset(icon!),
              ),
            ),
            onTap: onTap,
          ),
          SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          Text(
            title!,
            style: TextStyle(
                color: Colors.black, fontSize: Dimensions.largeTextSize),
          )
        ],
      ),
    );
  }
}

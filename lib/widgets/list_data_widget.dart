import 'package:flutter/material.dart';
import 'package:grosshop/utils/custom_style.dart';

class ListDataWidget extends StatelessWidget {
  final String? icon;
  final String? title;
  final Color? color;
  final GestureTapCallback? onTap;

  const ListDataWidget({
    Key? key,
    this.icon,
    this.title,
    this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        leading: Image.asset(
          icon!,
          width: 30,
          height: 20,
          color: color ?? null,
        ),
        title: Text(
          title!,
          style: CustomStyle.listStyle,
        ),
        onTap: onTap,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/widgets/header_widget.dart';
import 'package:grosshop/widgets/order/order_status_widget.dart';
import 'package:grosshop/widgets/order/order_tracking_widget.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              HeaderWidget(title: Strings.orders,),
              Divider(
                color: Colors.grey,
              ),
              bodyWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return detailsWidget(context);
  }

  detailsWidget(BuildContext context) {
    int totalPages = 2;
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: PageView.builder(
          itemCount: totalPages,
          itemBuilder: (context, index) {
            return ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.marginSize,
                    right: Dimensions.marginSize
                  ),
                  child: Container(
                    height: 30.0,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.orderStatus,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimensions.defaultTextSize,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Container(
                                height: 2,
                                color: index == 0 ? CustomColor.primaryColor : Colors.grey
                                    .withOpacity(0.2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: Dimensions.widthSize * 6,),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.trackMyOrder,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimensions.defaultTextSize,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Container(
                                height: 2,
                                color: index == 1 ? CustomColor.primaryColor : Colors.grey.withOpacity(0.2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: pageViewWidget(index),
                )
              ],
            );
          }
      ),
    );
  }

  pageViewWidget(int i) {
    switch(i) {
      case 0 :
        return OrderStatusWidget();
      case 1 :
        return OrderTrackingWidget();
    }
  }
}

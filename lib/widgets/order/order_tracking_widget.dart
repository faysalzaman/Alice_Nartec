import 'package:grosshop/data/order.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:flutter/material.dart';

class OrderTrackingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
        top: Dimensions.heightSize,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: OrderList.list().length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Order order = OrderList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(top: Dimensions.heightSize),
              child: ExpansionTile(
                title: Text(
                  order.orderId!,
                  style: TextStyle(
                      fontSize: Dimensions.largeTextSize,
                      color: CustomColor.accentColor,
                      fontWeight: FontWeight.bold),
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.transparent,
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: Dimensions.heightSize,
                        bottom: Dimensions.heightSize,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 100,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: CustomColor.secondaryColor,
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.radius)),
                              child: Image.asset(
                                order.image!,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.widthSize,
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.name!,
                                  style: TextStyle(
                                      fontSize: Dimensions.largeTextSize,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize,
                                ),
                                Text(
                                  'Contrary to popular belief',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.8)),
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                                Text(
                                  '\$${order.newPrice}',
                                  style: TextStyle(
                                      fontSize: Dimensions.largeTextSize * 1.5,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                                Text(
                                  order.date!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.smallTextSize),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  statusWidget(context),
                  SizedBox(
                    height: Dimensions.heightSize * 2,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  statusWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: Dimensions.heightSize * 2,
            left: Dimensions.marginSize * 2,
            right: Dimensions.marginSize * 2,
          ),
          child: Row(
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(5)),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 3,
                  color: CustomColor.primaryColor,
                ),
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(5)),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 3,
                  color: CustomColor.primaryColor,
                ),
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(5)),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 3,
                  color: CustomColor.primaryColor,
                ),
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.heightSize,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  Strings.pending,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(Strings.picked,
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                flex: 1,
                child: Text(Strings.shipped,
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  Strings.delivered,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.heightSize,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  '01 jan, 2021',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text('05 jan, 2021',
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                flex: 1,
                child: Text('10 jan, 2021',
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '20 jan, 2021',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

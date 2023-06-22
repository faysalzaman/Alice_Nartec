import 'package:grosshop/data/cart.dart';
import 'package:flutter/material.dart';

import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/widgets/header_widget.dart';
import 'package:grosshop/widgets/cart_quantity_widget.dart';
import 'package:grosshop/widgets/primary_button_widget.dart';
import 'package:grosshop/screens/address_screen.dart';

class MyCartScreen extends StatefulWidget {
  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              HeaderWidget(
                title: Strings.cart,
              ),
              bodyWidget(context),
              SizedBox(
                height: 100,
              ),
              checkOutWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return ListView.builder(
      itemCount: CartList.list().length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        Cart cart = CartList.list()[index];
        return Padding(
          padding: const EdgeInsets.only(
            top: Dimensions.heightSize,
            right: Dimensions.marginSize * 0.5,
            left: Dimensions.marginSize * 0.5,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.radius),
              boxShadow: [
                BoxShadow(
                  color: CustomColor.greyColor.withOpacity(0.3),
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
                  right: Dimensions.marginSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.delete), onPressed: null),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustomColor.secondaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Image.asset(
                            cart.image!,
                            fit: BoxFit.cover,
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
                                cart.name!,
                                style: TextStyle(
                                    fontSize: Dimensions.largeTextSize,
                                    color: CustomColor.accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: Dimensions.heightSize * 0.5,
                              ),
                              Text(
                                '1 kg',
                                style: TextStyle(
                                    fontSize: Dimensions.defaultTextSize,
                                    color: CustomColor.greyColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: Dimensions.heightSize * 0.5,
                              ),
                              Text(
                                '\$${cart.newPrice}',
                                style: TextStyle(
                                    fontSize: Dimensions.defaultTextSize,
                                    color: CustomColor.accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.widthSize,
                  ),
                  CartQuantityWidget()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  checkOutWidget(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: CustomColor.secondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 2),
          topRight: Radius.circular(Dimensions.radius * 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(1, 1), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'USD 276.00',
                    style: TextStyle(
                        color: CustomColor.primaryColor,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Strings.total,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.largeTextSize),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: PrimaryButtonWidget(
                title: Strings.checkOut,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddressScreen()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

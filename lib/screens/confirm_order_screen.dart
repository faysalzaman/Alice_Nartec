import 'package:grosshop/data/cart.dart';
import 'package:grosshop/screens/success_order_screen.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:grosshop/widgets/primary_button_widget.dart';

class ConfirmOrderScreen extends StatefulWidget {
  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
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
              BackWidget(
                title: Strings.confirmOrder,
              ),
              bodyWidget(context),
              SizedBox(
                height: Dimensions.heightSize,
              ),
              buttonWidget(context),
              SizedBox(
                height: Dimensions.heightSize,
              )
            ],
          ),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        statusWidget(context),
        SizedBox(
          height: Dimensions.heightSize * 4,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius * 2),
              topRight: Radius.circular(Dimensions.radius * 2),
            ),
            boxShadow: [
              BoxShadow(
                color: CustomColor.primaryColor.withOpacity(0.1),
                spreadRadius: 4,
                blurRadius: 7,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.heightSize,
            ),
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                cartWidget(context),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
                deliveryWidget(context),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
                paymentWidget(context),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
                totalAmountWidget(context)
              ],
            ),
          ),
        ),
      ],
    );
  }

  statusWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: Dimensions.heightSize * 2,
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: CustomColor.primaryColor)),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 3,
                  color: CustomColor.primaryColor,
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: CustomColor.primaryColor)),
                child: Icon(
                  Icons.payment,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 3,
                  color: CustomColor.primaryColor,
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: CustomColor.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: CustomColor.primaryColor)),
                child: Icon(
                  Icons.done,
                  color: CustomColor.primaryColor,
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
                  Strings.address,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(Strings.payment,
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  Strings.confirm,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  cartWidget(BuildContext context) {
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
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: Dimensions.heightSize,
                  bottom: Dimensions.heightSize,
                  right: Dimensions.marginSize,
                  left: Dimensions.marginSize),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
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
                  Column(
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  deliveryWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.shippingAddress,
            style: TextStyle(
                color: CustomColor.accentColor,
                fontSize: Dimensions.largeTextSize,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.6)),
                borderRadius: BorderRadius.circular(Dimensions.radius)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: Dimensions.marginSize),
                child: Text(
                  Strings.demoAddress,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: Dimensions.defaultTextSize,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  paymentWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.payment,
            style: TextStyle(
                color: CustomColor.accentColor,
                fontSize: Dimensions.largeTextSize,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.6)),
                borderRadius: BorderRadius.circular(Dimensions.radius)),
            child: Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.marginSize,
                right: Dimensions.marginSize,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Strings.demoCardNumber,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: Dimensions.defaultTextSize,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  Image.asset(
                    'assets/images/card/mastercard.png',
                    height: 20,
                    width: 30,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  totalAmountWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.marginSize),
      child: Text(
        '${Strings.total}: \$183',
        style: TextStyle(
            color: CustomColor.accentColor,
            fontSize: Dimensions.largeTextSize,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  buttonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: PrimaryButtonWidget(
        title: Strings.placeOrder,
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SuccessOrderScreen()));
        },
      ),
    );
  }

  openOrderSuccessDialog(BuildContext context) {
    showGeneralDialog(
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierDismissible: true,
        barrierColor: Colors.white.withOpacity(0.6),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (_, __, ___) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.marginSize,
                  right: Dimensions.marginSize,
                ),
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 12, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/tik.png'),
                      SizedBox(
                        height: Dimensions.heightSize,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: Dimensions.marginSize,
                          right: Dimensions.marginSize,
                        ),
                        child: Text(
                          Strings.youHaveSuccessfullyPlaced,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.heightSize * 2,
                      ),
                      GestureDetector(
                        child: Container(
                          height: Dimensions.buttonHeight,
                          width: 150,
                          decoration: BoxDecoration(
                              color: CustomColor.accentColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius)),
                          child: Center(
                            child: Text(
                              Strings.backToHome.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.largeTextSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          /*Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                              DashboardScreen()));*/
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position:
                Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child: child,
          );
        });
  }
}

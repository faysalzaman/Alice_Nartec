import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grosshop/screens/NFC/select_payment_method.dart';

import '../../data/card.dart';
import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';
import '../../utils/strings.dart';

class NFCDetail extends StatefulWidget {
  String id;
  String userId;
  String nfcSerialNo;
  String nfcCardType;
  String nfcDetails;
  String cardAvailableAmount;

  NFCDetail({
    required this.id,
    required this.userId,
    required this.nfcSerialNo,
    required this.nfcCardType,
    required this.nfcDetails,
    required this.cardAvailableAmount,
  });

  @override
  State<NFCDetail> createState() => _NFCDetailState();
}

class _NFCDetailState extends State<NFCDetail> {
  get amountController => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.green,
          flexibleSpace: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color.fromARGB(255, 102, 187, 106),
                  Color.fromARGB(255, 67, 168, 70),
                ],
              ),
            ),
            child: Center(
              child: const Text(
                'Wallet Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10,
        onPressed: () {
          Get.to(
            () => SelectPaymentMethod(
              id: widget.id,
              userId: widget.userId,
              nfcSerialNo: widget.nfcSerialNo,
              nfcCardType: widget.nfcCardType,
              nfcDetails: widget.nfcDetails,
              cardAvailableAmount: widget.cardAvailableAmount,
            ),
          );
        },
        label: Text('Top Up'),
        icon: Icon(Icons.payment),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Card(
          elevation: 10,
          color: Colors.green[50],
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'User ID: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(widget.userId),
                    ],
                  ),
                ),
                Divider(color: Colors.black),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'NFC Serial No: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(widget.nfcSerialNo),
                    ],
                  ),
                ),
                Divider(color: Colors.black),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'NFC Card Type: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(widget.nfcCardType),
                    ],
                  ),
                ),
                Divider(color: Colors.black),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'NFC Details: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(widget.nfcDetails),
                    ],
                  ),
                ),
                Divider(color: Colors.black),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Card Available Amount: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(widget.cardAvailableAmount),
                    ],
                  ),
                ),
                // const SizedBox(height: 20),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.green,
                //     onPrimary: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(32.0),
                //     ),
                //   ),
                //   onPressed: () {
                //     _inputAmountDialog(context);
                //   },
                //   child: Text('Pay'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _inputAmountDialog(BuildContext context) {
    showGeneralDialog(
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.6),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (_, __, ___) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -40,
                      left: 0,
                      right: 0,
                      child: Align(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45),
                                color: CustomColor.primaryColor,
                                border: Border.all(
                                    width: 5,
                                    color: CustomColor.primaryColor
                                        .withOpacity(0.5))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/nfc/tapToPay.png",
                                height: 80,
                                width: 80,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 200,
                            child: TextFormField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.extraLargeTextSize,
                                  fontWeight: FontWeight.bold),
                              controller: amountController,
                              cursorColor: Colors.black,
                              cursorHeight: 30,
                              keyboardType: TextInputType.number,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return Strings.pleaseFillOutTheField;
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: Strings.amount,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                labelStyle: CustomStyle.textStyle,
                                filled: true,
                                fillColor: Colors.white,
                                hintStyle: CustomStyle.textStyle,
                                focusedBorder: CustomStyle.focusBorder,
                                enabledBorder: CustomStyle.focusErrorBorder,
                                focusedErrorBorder:
                                    CustomStyle.focusErrorBorder,
                                errorBorder: CustomStyle.focusErrorBorder,
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              height: 60,
                              width: 200,
                              decoration: BoxDecoration(
                                gradient: CustomColor.primaryButtonGradient,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius),
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              /*Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                  PaymentPreviewScreen()));*/
                            },
                          )
                        ],
                      ),
                    ),
                  ],
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

  gatewayWidget(Gateway gateway) {
    return GestureDetector(
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(1, 1), // Shadow position
            ),
          ],
        ),
        child: Image.asset(gateway.image!),
      ),
      onTap: () {
        _inputAmountDialog(context);
      },
    );
  }
}

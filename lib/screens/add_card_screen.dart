import 'dart:convert';

import 'package:get/get.dart';
import 'package:grosshop/screens/drawer/my_wallet_screen.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/widgets/back_widget.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AddCardScreen extends StatefulWidget {
  final String userId;
  final String nfcSerialNo;
  final String nfcCardType;
  final String nfcDetails;

  AddCardScreen({
    required this.userId,
    required this.nfcSerialNo,
    required this.nfcCardType,
    required this.nfcDetails,
  });

  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            BackWidget(
              title: Strings.addCard,
            ),
            bodyWidget(context)
          ],
        ),
      ),
    );
  }

  // void onCreditCardModelChange(CreditCardModel creditCardModel) {
  //   setState(() {
  //     cardNumber = creditCardModel.cardNumber;
  //     expiryDate = creditCardModel.expiryDate;
  //     cardHolderName = creditCardModel.cardHolderName;
  //     cvvCode = creditCardModel.cvvCode;
  //     isCvvFocused = creditCardModel.isCvvFocused;
  //   });
  // }

  bodyWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Image.asset(
            "assets/images/nfc/nfc-card.png",
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("User ID"),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: FittedBox(
                    child: Text(
                      widget.userId,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.heightSize * 1),
              Text("NFC Serial No"),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: FittedBox(
                    child: Text(
                      widget.nfcSerialNo,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.heightSize * 1),
              Text("NFC Card Type"),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: FittedBox(
                    child: Text(
                      widget.nfcCardType,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.heightSize * 1),
              Text("NFC Details"),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: FittedBox(
                    child: Text(
                      widget.nfcDetails,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.heightSize * 1),
              Text("Card Available Amount"),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: FittedBox(
                    child: Text(
                      "0.00",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.heightSize * 1),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: CustomColor.primaryColor,
                ),
                child: Container(
                  height: Dimensions.buttonHeight,
                  child: Center(
                    child: Text(
                      Strings.proceed.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        package: 'flutter_credit_card',
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                          color: Colors.transparent,
                          child: Center(child: CircularProgressIndicator()));
                    },
                  );
                  _postUser(
                    widget.userId,
                    widget.nfcSerialNo,
                    widget.nfcCardType,
                    widget.nfcDetails,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _postUser(
      String userId, String nfcId, String cardType, String nfcDetails) async {
    final url = 'http://gs1ksa.org:4000/api/postWallet';
    final uri = Uri.parse(url);
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Host': 'gs1ksa.org',
    };

    final body = <String, dynamic>{
      'userId': userId,
      'nfcSerialNumber': nfcId,
      'nfcCardType': cardType,
      'nfcDetails': nfcDetails,
      'cardAvailableAmount': "0.00",
    };

    final response =
        await http.post(uri, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      Get.off(
        () => MyWalletScreen(),
      );
      print('Success');
      Get.snackbar(
        "Success",
        "Card Added Successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else if (response.statusCode == 400) {
      Navigator.pop(context);
      Get.off(() => MyWalletScreen());
      Get.snackbar(
        "Error",
        "NFC Serial Number already exists for another user",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      print('Failed');
      Navigator.pop(context);
      Get.snackbar(
        "Error",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

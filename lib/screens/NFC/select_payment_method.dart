import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grosshop/screens/NFC/enter_amount_screen.dart';

class SelectPaymentMethod extends StatefulWidget {
  final String id;
  final String userId;
  final String nfcSerialNo;
  final String nfcCardType;
  final String nfcDetails;
  final String cardAvailableAmount;

  SelectPaymentMethod({
    Key? key,
    required this.id,
    required this.userId,
    required this.nfcSerialNo,
    required this.nfcCardType,
    required this.nfcDetails,
    required this.cardAvailableAmount,
  }) : super(key: key);

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  String? paymentType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 127, 224, 130),
                  Color.fromARGB(255, 33, 135, 36),
                ],
              ),
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  "Payment Methods",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              "PayPal",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: RadioListTile(
                title: Image.asset(
                  'assets/images/icon/cardPay.png',
                  width: double.infinity,
                  height: 100,
                ),
                value: "payPal",
                groupValue: paymentType,
                onChanged: (value) {
                  setState(() {
                    paymentType = value.toString();
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "STC Pay",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: RadioListTile(
                title: Image.asset(
                  'assets/images/icon/stcPay.jpg',
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
                value: "stcPay",
                groupValue: paymentType,
                onChanged: (value) {
                  setState(() {
                    paymentType = value.toString();
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Cash",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            Container(
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: RadioListTile(
                title: Image.asset(
                  'assets/images/icon/cashPay.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
                value: "cashPay",
                groupValue: paymentType,
                onChanged: (value) {
                  setState(() {
                    paymentType = value.toString();
                  });
                },
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Get.to(
                  () => EnterAmountScreen(
                    typeOfPayment: paymentType.toString(),
                    id: widget.id,
                    userId: widget.userId,
                    nfcSerialNo: widget.nfcSerialNo,
                    nfcCardType: widget.nfcCardType,
                    nfcDetails: widget.nfcDetails,
                    cardAvailableAmount: widget.cardAvailableAmount,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text("Pay"),
            ),
          ],
        ),
      ),
    );
  }
}

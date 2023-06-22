import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grosshop/screens/NFC/cash_instruction_screen.dart';
import 'package:grosshop/screens/NFC/paypal_instruction_screen.dart';
import 'package:grosshop/screens/NFC/stcpay_instruction_screen.dart';
import 'package:grosshop/screens/dashboard_screen.dart';
import 'package:moyasar_payment/model/paymodel.dart';
import 'package:moyasar_payment/model/source/stcpaymodel.dart';
import 'package:moyasar_payment/moyasar_payment.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class EnterAmountScreen extends StatefulWidget {
  String typeOfPayment;

  String id;
  String userId;
  String nfcSerialNo;
  String nfcCardType;
  String nfcDetails;
  String cardAvailableAmount;

  EnterAmountScreen({
    Key? key,
    required this.typeOfPayment,
    required this.id,
    required this.userId,
    required this.nfcSerialNo,
    required this.nfcCardType,
    required this.nfcDetails,
    required this.cardAvailableAmount,
  }) : super(key: key);

  @override
  State<EnterAmountScreen> createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends State<EnterAmountScreen> {
  TextEditingController amountController = TextEditingController();

  Future<void> requestForPayment() async {
    final String url = "http://gs1ksa.org:4000/api/postPaymentRequest";

    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Content-Type': 'application/json',
      "Host": "gs1ksa.org",
    };

    var body = {
      "userId": widget.userId,
      "nfcSerialNumber": widget.nfcSerialNo,
      "paymentMethod": widget.typeOfPayment,
      "amount": amountController.text.trim().toString(),
    };

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        Navigator.pop(context);
        print("Status Code: ${response.statusCode}");
        print("Status Code: ${response.body}");

        if (widget.typeOfPayment == "payPal") {
          Get.off(() => PaypalInstructionScreen());
        } else if (widget.typeOfPayment == "stcPay") {
          Get.off(() => StcPayInstructionScreen());
        } else {
          Get.off(() => CashInstructionScreen());
        }

        // Get.offAll(DashboardScreen());

        Get.snackbar(
          "Payment Request",
          "Payment Request Sent Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Navigator.pop(context);
        print("Status Code: ${response.statusCode}");
        print("Status Code: ${response.body}");
        Get.snackbar(
          "Payment Request",
          "Payment Request Failed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Navigator.pop(context);
      throw Exception(e);
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          automaticallyImplyLeading: false,
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
              child: Text(
                "Enter Amount",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter amount";
                    } else {
                      return null;
                    }
                  },
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter Amount",
                    hintText: "Enter Amount",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),
                Text(
                  "SAR ${amountController.text}",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                            color: Colors.transparent,
                            child: Center(child: CircularProgressIndicator()));
                      },
                    );
                    if (_formKey.currentState!.validate()) {
                      requestForPayment();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                      child: Text(
                        "Request for Payment",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

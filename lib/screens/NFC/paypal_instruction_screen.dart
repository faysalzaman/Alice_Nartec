import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dashboard_screen.dart';

class PaypalInstructionScreen extends StatefulWidget {
  const PaypalInstructionScreen({super.key});

  @override
  State<PaypalInstructionScreen> createState() =>
      _PaypalInstructionScreenState();
}

class _PaypalInstructionScreenState extends State<PaypalInstructionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/nfc/paypal.png', height: 200),
            SizedBox(height: 30),
            Text(
              '''Pay with your paypal account to proceed the your payment''',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                Get.offAll(DashboardScreen());
              },
              child: Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

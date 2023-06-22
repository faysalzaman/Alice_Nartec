import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dashboard_screen.dart';

class StcPayInstructionScreen extends StatefulWidget {
  const StcPayInstructionScreen({super.key});

  @override
  State<StcPayInstructionScreen> createState() =>
      _StcPayInstructionScreenState();
}

class _StcPayInstructionScreenState extends State<StcPayInstructionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/icon/stcPay.jpg', height: 200),
            SizedBox(height: 30),
            Text(
              '1. Click the “Transfer money to contacts” button',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              '2. Select a contact you want to transfer money to',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              '3. Enter the amount > confirm',
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

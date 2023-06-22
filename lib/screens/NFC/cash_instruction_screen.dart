import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grosshop/screens/dashboard_screen.dart';

class CashInstructionScreen extends StatefulWidget {
  const CashInstructionScreen({super.key});

  @override
  State<CashInstructionScreen> createState() => _CashInstructionScreenState();
}

class _CashInstructionScreenState extends State<CashInstructionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/nfc/cash.png', height: 200),
            SizedBox(height: 30),
            Text(
              '''Pay the cash to proceed the your payment''',
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

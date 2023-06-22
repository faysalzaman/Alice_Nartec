import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grosshop/screens/auth/sign_in_screen.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.hourglass_empty,
                size: 100,
                color: Colors.green,
              ),
              SizedBox(height: 20),
              Text(
                'Your account is under review. Kindly check it in an hour, it will be approved.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Get.offAll(() => SignInScreen());
                },
                child: Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:get/get.dart';
import 'package:grosshop/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<Color> colors = <Color>[Colors.red, Colors.blue, Colors.amber];

  Box<bool>? stayLoggedIn;

  Future<void> storeDataInHive() async {
    var stayLoggedIn = await Hive.openBox<bool>("stayLoggedIn");
    stayLoggedIn.add(false);

    print("Stay Logged In: ${stayLoggedIn.get("stayLoggedIn")}");

    Future.delayed(Duration(seconds: 3), () {
      Get.to(() => SignInScreen());
    });

    // if (stayLoggedIn.get("stayLoggedIn") == true) {
    //   Future.delayed(Duration(seconds: 3), () {
    //     Get.to(() => HomeScreen());
    //   });
    // } else {
    //   Future.delayed(Duration(seconds: 3), () {
    //     Get.to(() => SignInScreen());
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    storeDataInHive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/images/icon/alice-logo.jpg',
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ),
    );
  }
}

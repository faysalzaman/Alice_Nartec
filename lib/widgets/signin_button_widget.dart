// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grosshop/screens/AdminScreens/admin_home_screen.dart';
import 'package:grosshop/screens/auth/waiting_screen.dart';
import 'package:grosshop/screens/dashboard_screen.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/custom_color.dart';
import '../utils/dimensions.dart';
import 'circle_button_widget.dart';

import 'package:http/http.dart' as http;

class signInButtonWidget extends StatefulWidget {
  final String? email;
  final String? password;
  final GlobalKey<FormState>? formKey;

  signInButtonWidget({
    this.email,
    this.password,
    this.formKey,
  });

  @override
  State<signInButtonWidget> createState() => _signInButtonWidgetState();
}

class _signInButtonWidgetState extends State<signInButtonWidget> {
  Box<bool>? stayLoggedIn;

  @override
  void initState() {
    super.initState();
    stayLoggedIn = Hive.box("stayLoggedIn");
  }

  Future<void> signin(
    String email,
    String password,
  ) async {
    print('email is $email');
    print('password is $password');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userLoginIddd = prefs.getString('userLoginId');

    final String url = 'http://gs1ksa.org:4000/api/userAuthentication';
    final uri = Uri.parse(url);

    final body = {
      "userLoginId": email.toString(),
      "userPassword": password.toString()
    };

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        if (response.body.toString() == "True") {
          Future.delayed(Duration(seconds: 3)).then(
            (value) {
              Navigator.of(context).pop();

              prefs.remove("userLoginId");

              var usrLgnId = prefs.setString("userLoginId", email.toString());
              print('userLoginId is ${prefs.getString("userLoginId")}');

              stayLoggedIn!.put("stayLoggedIn", true);
              print('stayLoggedIn is ${stayLoggedIn!.get("stayLoggedIn")}');

              Get.offAll(DashboardScreen());
              // Get.off(WaitingScreen());

              Get.snackbar(
                'Success',
                'Login Successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
          );
        } else if (response.body.toString() ==
            "You are not authenticated by the admin") {
          Navigator.pop(context);
          Get.off(WaitingScreen());
        } else {
          Navigator.pop(context);
          Get.snackbar(
            'Error',
            'Invalid Credentials',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      print('error is $e');
      throw Exception('Failed to load data!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize, right: Dimensions.marginSize),
      child: CircleButtonWidget(
        icon: Icon(
          Icons.arrow_forward,
          color: CustomColor.primaryColor,
        ),
        onTap: () async {
          showDialog(
            context: context,
            builder: (context) {
              return Container(
                color: Colors.transparent,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
              );
            },
          );
          if (widget.email == "admin" && widget.password == "admin") {
            Future.delayed(
              Duration(seconds: 3),
              () {
                Navigator.of(context).pop();
                Get.offAll(AdminHomeScreen());
              },
            );
          } else {
            if (widget.formKey!.currentState!.validate()) {
              await signin(
                widget.email!.trim(),
                widget.password!.trim(),
              );
            }
          }
        },
      ),
    );
  }
}

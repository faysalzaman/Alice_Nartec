// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:grosshop/model/get_all_users_model.dart';
import 'package:grosshop/widgets/circle_button_widget.dart';
import 'package:flutter/material.dart';

import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/utils/custom_style.dart';
import 'package:grosshop/widgets/back_widget.dart';
import 'package:grosshop/screens/auth/sign_up_screen.dart';
import '../../widgets/signin_button_widget.dart';
import 'forgot_password_screen.dart';

import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _toggleVisibility = true;
  bool checkedValue = false;

  List userId = [];
  List userLoginId = [];
  List userPassword = [];
  List fullName = [];
  List email = [];
  List mobile = [];

  Future<GetAllUserModel?> getAllUsers() async {
    final url = 'http://gs1ksa.org:4000/api/GetAlluser';
    final uri = Uri.parse(url);
    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("status code 200");

      for (var i = 0; i < data.length; i++) {
        userId.add(GetAllUserModel.fromJson(data[i]).userId);
        userLoginId.add(GetAllUserModel.fromJson(data[i]).userLoginId);
        userPassword.add(GetAllUserModel.fromJson(data[i]).userPassword);
        fullName.add(GetAllUserModel.fromJson(data[i]).fullName);
        email.add(GetAllUserModel.fromJson(data[i]).emailId);
        mobile.add(GetAllUserModel.fromJson(data[i]).mobileNo);

        print("userId: ${userId[i]}");
      }
    } else {
      print("status code 400");
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        //width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            BackWidget(
              title: Strings.signInAccount,
            ),
            bodyWidget(context),
          ],
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          headingWidget(context),
          inputFiledWidget(context),
          SizedBox(height: Dimensions.heightSize),
          // rememberForgotWidget(context),
          // SizedBox(height: Dimensions.heightSize * 2),
          signInButtonWidget(
            email: emailController.text,
            password: passwordController.text,
            formKey: formKey,
          ),
          SizedBox(height: Dimensions.heightSize * 4),
          alreadyHaveAccountWidget(context),
        ],
      ),
    );
  }

  headingWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize * 2),
      child: Image.asset(
        "assets/images/icon/bgr-logo.png",
        height: 100,
        width: 100,
      ),
    );
  }

  inputFiledWidget(BuildContext context) {
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(
              top: Dimensions.heightSize * 2,
              left: Dimensions.marginSize,
              right: Dimensions.marginSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleData('User Login Id'),
              TextFormField(
                style: CustomStyle.textStyle,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Type Login Id",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: CustomStyle.textStyle,
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: CustomColor.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.heightSize),
              const SizedBox(height: Dimensions.heightSize),
              _titleData(Strings.password),
              TextFormField(
                style: CustomStyle.textStyle,
                controller: passwordController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: Strings.typePassword,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: CustomStyle.textStyle,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: CustomColor.primaryColor,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _toggleVisibility = !_toggleVisibility;
                      });
                    },
                    icon: _toggleVisibility
                        ? Icon(
                            Icons.visibility_off,
                            color: CustomColor.primaryColor,
                          )
                        : Icon(
                            Icons.visibility,
                            color: CustomColor.primaryColor,
                          ),
                  ),
                ),
                obscureText: _toggleVisibility,
              ),
              SizedBox(height: Dimensions.heightSize),
            ],
          ),
        ));
  }

  rememberForgotWidget(BuildContext context) {
    return CheckboxListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Strings.rememberMe,
            style: CustomStyle.textStyle,
          ),
          GestureDetector(
            child: Text(
              Strings.forgotPassword,
              style: CustomStyle.textStyle.copyWith(
                color: CustomColor.primaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ForgotPasswordScreen()));
            },
          ),
        ],
      ),
      value: checkedValue,
      onChanged: (newValue) {
        setState(() {
          checkedValue = newValue!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }

  orSignInWidget(BuildContext context) {
    return Column(
      children: [
        Text('Or'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleButtonWidget(
              icon: Image.asset('assets/images/icon/facebook.png'),
              onTap: () {},
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            CircleButtonWidget(
              icon: Image.asset('assets/images/icon/google.png'),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  alreadyHaveAccountWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.ifYouHaveNoAccount,
          style: CustomStyle.textStyle,
        ),
        GestureDetector(
          child: Text(
            Strings.signUp.toUpperCase(),
            style: TextStyle(
                color: CustomColor.primaryColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
        )
      ],
    );
  }

  _titleData(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Dimensions.heightSize * 0.5,
        top: Dimensions.heightSize,
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

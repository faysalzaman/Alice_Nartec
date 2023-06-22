import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grosshop/model/get_all_users_model.dart';
import 'package:grosshop/screens/auth/sign_in_screen.dart';
import 'package:grosshop/screens/auth/waiting_screen.dart';

import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/utils/custom_style.dart';
import 'package:grosshop/widgets/back_widget.dart';
import 'package:grosshop/widgets/circle_button_widget.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController userLoginIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController userTypeIdNoController = TextEditingController();
  TextEditingController adminAccessNo = TextEditingController();

  bool _toggleVisibility = true;
  bool checkedValue = false;

  String dropdownvalue = 'Student';

  // List of items in our dropdown menu
  var items = [
    'Student',
    'Staff',
    'Reseller',
    'Fetcher',
  ];

  Box<bool>? stayLoggedIn;

  List<GetAllUserModel> allUserLength = [];

  Future<GetAllUserModel> _getAllUsers() async {
    final url = 'http://gs1ksa.org:4000/api/GetAlluser';
    final uri = Uri.parse(url);
    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (var i = 0; i < data.length; i++) {
        allUserLength.add(GetAllUserModel.fromJson(data[i]));
      }

      print("length of user is: ${allUserLength.length}");

      return GetAllUserModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllUsers();
    stayLoggedIn = Hive.box("stayLoggedIn");
  }

  Future<void> _postUser(
    String lengthOfUser,
    String userLoginId,
    String userPassword,
    String fullName,
    String emailId,
    String mobileNo,
    int userTypeIdNo,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("length of user is: $lengthOfUser");

    final url = 'http://gs1ksa.org:4000/api/PostUser';
    final uri = Uri.parse(url);
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Host': 'gs1ksa.org',
    };

    int lengthOfUsers = allUserLength.length + 1;

    final body = {
      'userId': "${lengthOfUsers.toString()}",
      'userLoginId': "${userLoginId.toString()}",
      'userPassword': "${userPassword.toString()}",
      'fullName': "${fullName.toString()}",
      'emailId': "${emailId.toString()}",
      'mobileNo': "${mobileNo.toString()}",
      'userTypeIdNo': "${userTypeIdNo.toString()}",
      'adminAccess': false,
    };

    print('body: ${jsonEncode(body)}');

    try {
      final response =
          await http.post(uri, headers: headers, body: jsonEncode(body));

      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar(
          'Error',
          'Password Not Matched',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      } else {
        if (response.statusCode == 200) {
          print('Success');
          prefs.clear();

          await stayLoggedIn!.put('stayLoggedIn', true);

          prefs.setBool('isLogin', true);
          prefs.setInt('userId', lengthOfUsers);
          prefs.setString('userLoginId', "${userLoginIdController.text}");
          prefs.setString("userPassword", "${passwordController.text}");
          prefs.setString('fullName', '${fullNameController.text}');
          prefs.setString('emailId', "${emailController.text}");
          prefs.setString('mobileNo', "${mobileController.text}");

          print('User Id: ${prefs.getInt('userId')}');
          print('User Login Id: ${prefs.getString('userLoginId')}');
          print('User Password: ${prefs.getString('userPassword')}');
          print('User Full Name: ${prefs.getString('fullName')}');
          print('User Email Id: ${prefs.getString('emailId')}');
          print('User Mobile No: ${prefs.getString('mobileNo')}');
          print('User Type Id No: ${prefs.getString('userTypeIdNo')}');

          // Get.offAll(HomeScreen());
          Get.off(() => WaitingScreen());

          Get.snackbar(
            'Success',
            'User Created Successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
          );
        } else if (response.statusCode == 400) {
          print("status code: ${response.statusCode}");
          Navigator.pop(context);
          Get.snackbar(
            'Error',
            'User Already Exists',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
          );
        } else {
          print("status code: ${response.statusCode}");
          Navigator.of(context).pop();
          print('status code: ${response.statusCode}');
          Get.snackbar(
            'Error',
            'User Not Created',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
          );
        }
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Something went wrong, Please check your internet connection and try again',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            SizedBox(height: Dimensions.heightSize * 1),
            BackWidget(title: Strings.createAnAccount),
            inputFieldWidget(context),
            // termsCheckBoxWidget(context),
            SizedBox(height: Dimensions.heightSize * 1),
            buttonWidget(context),
            SizedBox(height: Dimensions.heightSize * 1),
            ifYouDontHaveAccountWidget(context),
            SizedBox(height: Dimensions.heightSize * 1),
          ],
        ),
      ),
    );
  }

  headingWidget(BuildContext context) {
    return Image.asset('assets/images/sign_in.png');
  }

  bool _obscureText = false;
  bool _confrmObscureText = false;

  inputFieldWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleData("User Login Id"),
                TextFormField(
                  style: CustomStyle.textStyle,
                  controller: userLoginIdController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return Strings.pleaseFillOutTheField;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Login Id",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelStyle: CustomStyle.textStyle,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: CustomColor.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.heightSize * 1),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _titleData("Password"),
                      TextFormField(
                        style: CustomStyle.textStyle,
                        controller: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          } else {
                            return null;
                          }
                        },
                        obscureText: _obscureText == true ? false : true,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText == true
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                              color: CustomColor.primaryColor,
                            ),
                          ),
                          hintText: "password",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          labelStyle: CustomStyle.textStyle,
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: CustomStyle.textStyle,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: CustomColor.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Dimensions.widthSize * 1),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _titleData("Confirm Password"),
                      TextFormField(
                        style: CustomStyle.textStyle,
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            return "Password does not match";
                          } else if (passwordController.text ==
                              confirmPasswordController.text) {
                            if (value!.length < 6) {
                              return "Password must be 6 characters";
                            } else {
                              return null;
                            }
                          } else {
                            return null;
                          }
                        },
                        obscureText: _confrmObscureText == true ? false : true,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _confrmObscureText = !_confrmObscureText;
                              });
                            },
                            child: Icon(
                              _confrmObscureText == true
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                              color: CustomColor.primaryColor,
                            ),
                          ),
                          hintText: "Confirm Password",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          labelStyle: CustomStyle.textStyle,
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: CustomStyle.textStyle,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: CustomColor.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleData("Mobile No"),
                IntlPhoneField(
                  controller: mobileController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'SA',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null) {
                      return Strings.pleaseFillOutTheField;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),
              ],
            ),
            _titleData("Full Name"),
            TextFormField(
              style: CustomStyle.textStyle,
              controller: fullNameController,
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return Strings.pleaseFillOutTheField;
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: "Full Name",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                labelStyle: CustomStyle.textStyle,
                filled: true,
                fillColor: Colors.white,
                hintStyle: CustomStyle.textStyle,
                prefixIcon: Icon(
                  Icons.person,
                  color: CustomColor.primaryColor,
                ),
              ),
            ),
            _titleData("Email"),
            TextFormField(
              style: CustomStyle.textStyle,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return Strings.pleaseFillOutTheField;
                } else if (value.contains("@") && value.contains(".")) {
                  return null;
                } else if (value.contains("@") && !value.contains(".")) {
                  return "Please enter a valid email";
                } else if (!value.contains("@") && value.contains(".")) {
                  return "Please enter a valid email";
                } else if (!value.contains("@") && !value.contains(".")) {
                  return "Please enter a valid email";
                } else if (value.isEmpty || value == "" || value == null) {
                  return "Please enter a valid email";
                } else if (value == " ") {
                  return "Please enter a valid email";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: "Email",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                labelStyle: CustomStyle.textStyle,
                filled: true,
                fillColor: Colors.white,
                hintStyle: CustomStyle.textStyle,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: CustomColor.primaryColor,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleData("Registration Type"),
                Container(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                    focusColor: Colors.green,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      labelStyle: CustomStyle.textStyle,
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: CustomStyle.textStyle,
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: CustomColor.primaryColor,
                      ),
                    ),
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(
                        () {
                          dropdownvalue = newValue!;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  termsCheckBoxWidget(BuildContext context) {
    return CheckboxListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "I accept the ",
            style: CustomStyle.textStyle,
          ),
          GestureDetector(
            child: Text(
              "Terms and Conditions",
              style: TextStyle(
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.blueColor,
                  decoration: TextDecoration.underline),
            ),
            onTap: () {
              print('go to privacy url');
              _showTermsConditions();
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

  buttonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: CircleButtonWidget(
        icon: Icon(
          Icons.arrow_forward,
          color: CustomColor.primaryColor,
        ),
        onTap: () {
          if (formKey.currentState!.validate()) {
            showDialog(
              context: context,
              builder: (context) {
                return Container(
                  color: Colors.transparent,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
            _postUser(
              allUserLength.toString(),
              userLoginIdController.text,
              passwordController.text,
              fullNameController.text,
              emailController.text,
              mobileController.text,
              dropdownvalue == "Student"
                  ? 1
                  : dropdownvalue == "Staff"
                      ? 2
                      : dropdownvalue == "Reseller"
                          ? 3
                          : dropdownvalue == "Fetcher"
                              ? 4
                              : 0,
            );
          }
        },
      ),
    );
  }

  orSignUpWidget(BuildContext context) {
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

  ifYouDontHaveAccountWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.ifYouHaveNoAccount,
          style: CustomStyle.textStyle,
        ),
        GestureDetector(
          child: Text(
            "SIGN IN",
            style: TextStyle(
                color: CustomColor.primaryColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignInScreen()));
          },
        )
      ],
    );
  }

  _titleData(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Dimensions.heightSize * 0.1,
        top: Dimensions.heightSize,
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Future<bool> _showTermsConditions() async {
    return (await showDialog(
          context: context,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: CustomColor.primaryColor,
            child: Stack(
              children: [
                Positioned(
                    top: -35.0,
                    left: -50.0,
                    child: Image.asset('assets/images/splash_logo.png')),
                Positioned(
                    right: -35.0,
                    bottom: -20.0,
                    child: Image.asset('assets/images/splash_logo.png')),
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.defaultPaddingSize * 2,
                      bottom: Dimensions.defaultPaddingSize * 2),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: AlertDialog(
                      content: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 45,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Dimensions.heightSize * 2,
                                  ),
                                  Text(
                                    Strings.ourPolicyTerms,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: Dimensions.largeTextSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: Dimensions.heightSize),
                                  Text(
                                    'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old',
                                    style: CustomStyle.textStyle,
                                  ),
                                  SizedBox(height: Dimensions.heightSize),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '•',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: CustomColor.accentColor,
                                            fontSize:
                                                Dimensions.extraLargeTextSize),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'simply random text. It has roots in a piece of classical Latin literature ',
                                          style: CustomStyle.textStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.heightSize),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '•',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: CustomColor.accentColor,
                                            fontSize:
                                                Dimensions.extraLargeTextSize),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Distracted by the readable content of a page when looking at its layout.',
                                          style: CustomStyle.textStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.heightSize),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '•',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: CustomColor.accentColor,
                                            fontSize:
                                                Dimensions.extraLargeTextSize),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Available, but the majority have suffered alteration',
                                          style: CustomStyle.textStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.heightSize * 2,
                                  ),
                                  Text(
                                    'When do we contact information ?',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: Dimensions.largeTextSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: Dimensions.heightSize),
                                  Text(
                                    'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old',
                                    style: CustomStyle.textStyle,
                                  ),
                                  SizedBox(
                                    height: Dimensions.heightSize * 2,
                                  ),
                                  Text(
                                    'Do we use cookies ?',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: Dimensions.largeTextSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: Dimensions.heightSize),
                                  Text(
                                    'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old',
                                    style: CustomStyle.textStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        height: 35.0,
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                            color: CustomColor.secondaryColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: Center(
                                          child: Text(
                                            Strings.decline,
                                            style: TextStyle(
                                                color: CustomColor.primaryColor,
                                                fontSize:
                                                    Dimensions.defaultTextSize,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        height: 35.0,
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                            color: CustomColor.primaryColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: Center(
                                          child: Text(
                                            Strings.agree,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    Dimensions.defaultTextSize,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )) ??
        false;
  }
}

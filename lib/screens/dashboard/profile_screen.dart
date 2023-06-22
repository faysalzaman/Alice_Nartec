import 'package:flutter/material.dart';
import 'package:grosshop/screens/dashboard/home_screen.dart';

import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/utils/custom_style.dart';
import 'package:grosshop/widgets/header_widget.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../../model/get_user_by_id_model.dart';
import '../../model/update_user_by_id_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String fullName = '';
  String emailId = '';
  String mobileNo = '';
  String userLoginId = '';
  String userPicture = '';

  bool isEdit = true;

  File? _image;
  final picker = ImagePicker();

  Future<GetUserByIdModel> getUserById() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // String fullNamee = prefs.getString('fullName')!;
    // String emailIdd = prefs.getString('emailId')!;
    // String mobileNoo = prefs.getString('mobileNo')!;
    String userLoginIdd = prefs.getString('userLoginId')!;

    print('*******userId******: $userLoginId');

    final String url = "http://gs1ksa.org:4000/api/getUserById/$userLoginIdd";

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      print('response: ${response.body}');
      var data = GetUserByIdModel.fromJson(jsonDecode(response.body));

      setState(() {
        fullName = data.fullName.toString();
        userLoginId = data.userLoginId.toString();
        emailId = data.emailId.toString();
        mobileNo = data.mobileNo.toString();
        userPicture = data.userPicture.toString();
        nameController.text = fullName;
        emailController.text = emailId;
        isLoading = false;
      });

      return GetUserByIdModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  @override
  void initState() {
    super.initState();

    getUserById();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  HeaderWidget(
                    title: Strings.profile,
                  ),
                  bodyWidget(context)
                ],
              ),
            ),
    );
  }

  bodyWidget(BuildContext context) {
    return Column(
      children: [
        headingWidget(context),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                inputFiledWidget(context),
                SizedBox(height: Dimensions.heightSize * 2),
                buttonWidget(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  headingWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              userPicture == ""
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/profile.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        File(userPicture),
                        height: 150,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/profile.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
              Positioned(
                right: -5,
                bottom: 0,
                child: GestureDetector(
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: CustomColor.primaryColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  onTap: () {
                    _openImageSourceOptions(context);
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  bool isName = false;

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
            _titleData(Strings.fullName),
            TextFormField(
              readOnly: isEdit,
              style: CustomStyle.textStyle,
              controller: nameController,
              keyboardType: TextInputType.name,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return Strings.pleaseFillOutTheField;
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: fullName,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                labelStyle: CustomStyle.textStyle,
                filled: true,
                fillColor: Colors.white,
                hintStyle: CustomStyle.textStyle,
              ),
            ),
            const SizedBox(height: 20),
            _titleData(Strings.email),
            TextFormField(
              readOnly: isEdit,
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
                hintText: emailId,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                labelStyle: CustomStyle.textStyle,
                filled: true,
                fillColor: Colors.white,
                hintStyle: CustomStyle.textStyle,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(height: Dimensions.heightSize),
          ],
        ),
      ),
    );
  }

  buttonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize, right: Dimensions.marginSize),
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: isEdit ? Colors.grey : CustomColor.primaryColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius))),
          child: Center(
            child: Text(
              isEdit
                  ? Strings.edit.toUpperCase()
                  : Strings.update.toUpperCase(),
              style: TextStyle(
                  color: isEdit ? Colors.black : Colors.white,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () {
          if (isEdit == true) {
            setState(() {
              isEdit = !isEdit;
            });
          } else {
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
            if (fullName.isNotEmpty && emailId.isNotEmpty && _image != null) {
              if (formKey.currentState!.validate()) {
                updateUserById(
                  nameController.text.toString(),
                  emailController.text.toString(),
                  _image!.path.toString(),
                );
              }
            } else {
              Navigator.pop(context);
              Get.snackbar(
                "Error",
                "${Strings.pleaseFillOutTheField} and Select an Image",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          }
          // setState(() {
          //   isEdit = !isEdit;
          // });
          // if (isEdit == true) {
          //   _storeDataInLocal();
          // }
        },
      ),
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

  _openImageSourceOptions(BuildContext context) {
    showGeneralDialog(
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.camera_alt,
                          size: 40.0,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          _chooseFromCamera();
                        },
                      ),
                      Text(
                        Strings.takePhoto,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.defaultTextSize),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.photo,
                          size: 40.0,
                          color: Colors.green,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          _chooseFromGallery();
                        },
                      ),
                      Text(
                        Strings.fromGallery,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.defaultTextSize),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  Future _chooseFromGallery() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        prefs.setString("userImage", _image!.path);

        setState(() {
          userPicture = _image!.path;
        });

        print("userPicture: $userPicture");
      } else {
        print('No image selected.');
      }
    });
  }

  Future _chooseFromCamera() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        prefs.setString("userImage", _image!.path);

        setState(() {
          userPicture = _image!.path;
        });

        print("userPicture: $userPicture");
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> updateUserById(String name, String email, String picture) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userLoginIdd = prefs.getString('userLoginId')!;

    print('*******userId******: $userLoginIdd');
    print('*******name******: $name');
    print('*******email******: $email');
    print('*******picture******: $picture');

    final String url =
        "http://gs1ksa.org:4000/api/updateuserById/$userLoginIdd";

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    final body = {
      "fullName": name,
      "emailId": email,
      "userPicture": picture,
    };

    var response = await http.put(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      print('response: ${response.body}');
      var data = GetUserByIdModel.fromJson(jsonDecode(response.body));

      print("user updated successfully");

      setState(() {
        fullName = data.fullName.toString();
        emailId = data.emailId.toString();
        userPicture = data.userPicture.toString();
      });

      prefs.setString("fullName", name);
      prefs.setString("emailId", email);
      prefs.setString("userPicture", picture);

      Get.snackbar(
        "Success",
        "Profile Updated Successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAll(() => HomeScreen());
    } else {
      Navigator.pop(context);
      Get.snackbar(
        "Error",
        "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

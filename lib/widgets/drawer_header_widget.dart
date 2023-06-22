import 'dart:io';

import 'package:grosshop/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/screens/dashboard/profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/get_user_by_id_model.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DrawerHeaderWidget extends StatefulWidget {
  @override
  State<DrawerHeaderWidget> createState() => _DrawerHeaderWidgetState();
}

class _DrawerHeaderWidgetState extends State<DrawerHeaderWidget> {
  String fullName = '';
  String emailId = '';
  String userLoginId = '';
  String userPicture = '';

  String image = '';

  File? _image;
  final picker = ImagePicker();

  Future<GetUserByIdModel> getUserById() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userLoginIdd = prefs.getString('userLoginId')!;

    print('*******userId******: $userLoginIdd');

    final String url = "http://gs1ksa.org:4000/api/getUserById/$userLoginIdd";

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      print('response: ${response.body}');
      var data = GetUserByIdModel.fromJson(jsonDecode(response.body));

      fullName = data.fullName.toString();
      userLoginId = data.userLoginId.toString();
      emailId = data.emailId.toString();
      userPicture = data.userPicture.toString();

      return GetUserByIdModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserById().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Dimensions.heightSize, bottom: Dimensions.heightSize),
      child: ListTile(
        leading: userPicture == ""
            ? Image.asset(
                'assets/images/profile.png',
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  File(userPicture),
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/profile.png',
                      height: 100,
                      width: 50,
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
        title: fullName == ""
            ? Text("Edit Your Profile")
            : Text(
                fullName,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.largeTextSize),
              ),
        subtitle: Text(
          emailId,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProfileScreen()));
        },
      ),
    );
  }
}

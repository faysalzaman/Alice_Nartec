// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:grosshop/staff/attendance_screen.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../model/attendance_model.dart';

class AttendanceDetailScreen extends StatefulWidget {
  final String name;
  final String email;
  final String mobile;
  final String nfc;
  final String userId;

  AttendanceDetailScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.mobile,
    required this.nfc,
    required this.userId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AttendanceDetailScreenState();
}

class AttendanceDetailScreenState extends State<AttendanceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    _markAttendance(widget.userId);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 127, 224, 130),
                  Color.fromARGB(255, 33, 135, 36),
                ],
              ),
            ),
            child: Center(
              child: Text(
                "NFC Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Card(
          elevation: 10,
          margin: EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Name: " + widget.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Email: " + widget.email,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Mobile: " + widget.mobile,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "NFC: " + widget.nfc,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                FittedBox(
                  child: Text(
                    DateTime.now().toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<AttendanceModel> _markAttendance(String usrID) async {
    print('usrID: $usrID');

    final now = DateTime.now();
    final checkInTime = DateFormat.yMd().add_jm();
    var checkOutTime = now.hour < 12
        ? DateFormat.jm().format(now.add(Duration(hours: 4)))
        : DateFormat.jm().format(now.add(Duration(hours: 8)));

    var typeOfEntry = now.hour < 12 ? "in" : "out";

    print('typeOfEntry: $typeOfEntry');

    final String url = "http://gs1ksa.org:4000/api/postAttendance";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    final body = {
      "userId": usrID,
      "typeofEntry": typeOfEntry,
    };

    try {
      final response =
          await http.post(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("status code: ${response.statusCode}");

        var jsonData = json.decode(response.body);
        print("jsonData: $jsonData");

        Get.snackbar(
          "Success",
          jsonData['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );

        Future.delayed(Duration(seconds: 3), () {
          Get.off(() => AttendanceScreen());
        });

        return AttendanceModel.fromJson(jsonData);
      }
      if (response.statusCode == 400) {
        print("status code: ${response.statusCode}");
        var data = json.decode(response.body);

        Get.off(() => AttendanceScreen());
        Get.snackbar(
          "Error",
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        Future.delayed(Duration(seconds: 3), () {
          Get.off(() => AttendanceScreen());
        });
        throw Exception('No Data Found');
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }
}

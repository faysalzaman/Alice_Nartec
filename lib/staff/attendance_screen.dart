// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grosshop/staff/attendance_detail_screen.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../model/get_user_loginId_by_Nfc_Model.dart';

import 'package:http/http.dart' as http;

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String userId = '';
  String userLoginId = '';

  List nfcList = [];

  String _getUserLoginId = '';
  String _getUserFullName = '';
  String _getUserEmailId = '';
  String _getUserMobileNo = '';

  Future<GetUserLoginIdByNfcModel> _getNFC(String NFC) async {
    print("the value of NFC is: " + NFC);
    final String url = "http://gs1ksa.org:4000/api/GetUserLoginIdByNfc/$nfc";

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print("jsonResponse: " + jsonResponse.toString());
      print(jsonResponse["message"].toString());

      var getAllData = GetUserLoginIdByNfcModel.fromJson(jsonResponse);

      setState(() {
        _getUserLoginId = getAllData.user!.userLoginId!.toString();
        _getUserFullName = getAllData.user!.fullName!.toString();
        _getUserEmailId = getAllData.user!.emailId!.toString();
        _getUserMobileNo = getAllData.user!.mobileNo!.toString();
      });

      print("userLoginId: " + _getUserLoginId);
      print("fullName: " + _getUserFullName);
      print("emailId: " + _getUserEmailId);
      print("mobileNo: " + _getUserMobileNo);

      Get.off(() => AttendanceDetailScreen(
            name: _getUserFullName,
            email: _getUserEmailId,
            mobile: _getUserMobileNo,
            nfc: NFC,
            userId: _getUserLoginId,
          ));

      return GetUserLoginIdByNfcModel.fromJson(jsonResponse);
    } else if (response.statusCode == 400) {
      print("400");
      var jsonResponse = json.decode(response.body);
      Get.snackbar(
        "Error",
        jsonResponse["message"].toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return GetUserLoginIdByNfcModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  ValueNotifier<dynamic> result = ValueNotifier(null);

  List _identifier = [];
  bool _isVisible = false;

  String nfc = '';
  String tech = '';
  String cardType = '';

  Future _tagRead() async {
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        result.value = tag.data;
        NfcManager.instance.stopSession();

        var resultt = tag.data;
        print("result: " + resultt.toString());

        _identifier = tag.data['isodep']['identifier'] as List;
        _identifier.forEach((element) {
          setState(() {
            nfc += element.toString();
          });
        });

        setState(
          () {
            tech =
                tag.data.containsKey("isodep") && tag.data.containsKey("nfca")
                    ? "isoDep, NfcA"
                    : "NfcA";

            cardType = 'ISO 14443-4';
            _isVisible = true;
          },
        );
        print("tech: " + tech);
        print("identifier: " + nfc);
        await _getNFC(nfc);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _tagRead();
    // getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: true,
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
                nfc != "" ? "NFC Details" : "Mark Your Attendance",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20.0),
            Image.asset('assets/images/nfc/nfc-card.png'),
            SizedBox(height: 20.0),
            Center(
              child: Text(
                "Scan your NFC to mark your attendance",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

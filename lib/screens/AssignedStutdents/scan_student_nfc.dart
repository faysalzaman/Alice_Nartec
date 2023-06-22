import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grosshop/screens/AssignedStutdents/add_sudents_screen.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../../model/get_user_by_id_model.dart';
import '../../model/get_wallet_by_nfc_number_model.dart';

class ScanStudentNFCScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScanStudentNFCScreenState();
}

class ScanStudentNFCScreenState extends State<ScanStudentNFCScreen> {
  String fullName = '';

  Future<GetUserByIdModel> getUserById() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lginId = prefs.getString('userLoginId')!;

    print('*******userId******: $lginId');

    final String url = "http://gs1ksa.org:4000/api/getUserById/$lginId";

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print('response: ${response.body}');
        var data = GetUserByIdModel.fromJson(jsonDecode(response.body));

        setState(() {
          fullName = data.fullName.toString();
        });

        return GetUserByIdModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      print('error: $e');
      throw Exception('Failed to load data!');
    }
  }

  @override
  void initState() {
    super.initState();

    getUserById();
  }

  Future<void> postAssociate(
    String userAssociateNo,
    String userNameAssociate,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lginId = prefs.getString('userLoginId')!;

    print('userLoginId is $lginId');
    print("fullName is $fullName");

    final String url = "http://gs1ksa.org:4000/api/PostAssociate";

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Content-Type": "application/json",
      "Host": "gs1ksa.org",
    };

    final body = {
      "userId": lginId.toString(),
      "userIdAssociateNo": userAssociateNo,
      "userNameCaller": fullName.toString(),
      "userNameAssociate": userNameAssociate
    };

    try {
      final response =
          await http.post(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        Navigator.pop(context);
        Get.to(() => AddStudentScreen());
        print("Associate Success");

        Get.snackbar(
          "Associate Added",
          "Please try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Navigator.pop(context);

        print("Associate Failed");

        Get.snackbar(
          "This card is not registered",
          "Failed to add associate, Please try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        throw Exception('Failed to load data!');
      }
    } catch (e) {
      print(e);
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
          nfc += element.toString();
        });

        tech = tag.data.containsKey("isodep") && tag.data.containsKey("nfca")
            ? "isoDep, NfcA"
            : "NfcA";

        cardType = 'ISO 14443-4';

        print("tech: " + tech);

        print("identifier: " + nfc);

        nfc != "" ? getWallet(nfc) : print("nfc is empty");

        setState(
          () {
            _isVisible = true;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("nfc is $nfc");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Scan your NFC tag',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: SafeArea(
          child: FutureBuilder<bool>(
            future: NfcManager.instance.isAvailable(),
            builder: (context, ss) => ss.data != true
                ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
                : Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.vertical,
                    children: [
                      Flexible(
                        flex: 1,
                        child: ValueListenableBuilder<dynamic>(
                          valueListenable: result,
                          builder: (context, value, _) => Center(
                            child: Text(
                              nfc,
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Visibility(
                              visible: nfc == '' ? true : false,
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ),
                                  onPressed: _tagRead,
                                  child: const Text('Press to Scan'),
                                ),
                              ),
                            ),
                            nfc == ""
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 200,
                                    child: Image.asset(
                                      "assets/images/nfc/scan.png",
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container();
                                      },
                                    ),
                                  )
                                : Container(
                                    child: Column(
                                      children: [
                                        Card(
                                          color: Colors.white,
                                          margin: EdgeInsets.all(30),
                                          elevation: 0,
                                          child: ListTile(
                                            leading: Image.file(
                                              File(
                                                userPicture,
                                              ),
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.grey,
                                                  child: Icon(
                                                    Icons.person,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                );
                                              },
                                            ),
                                            title: Text(
                                              associateName,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(
                                              mobileNo,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: 100,
                                          child: Image.asset(
                                            "assets/images/nfc/done.png",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            nfc != ""
                                ? Text(
                                    "Wallet NFC Tag Found",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  )
                                : Text(
                                    "Approach an NFC Tag",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Visibility(
                                visible: _isVisible == true ? true : false,
                                child: Flexible(
                                  flex: 2,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.green,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            color: Colors.transparent,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.green),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      postAssociate(
                                        userLognId,
                                        fullName,
                                      );
                                    },
                                    child: const Text('Add Associate'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  String associateName = "";
  String mobileNo = "";
  String userPicture = "";
  String userLognId = "";

  Future<GetWalletByNFCSerialNumberModel> getWallet(String nfc) async {
    print('****nfc****: $nfc');

    final String url =
        "http://gs1ksa.org:4000/api/getWalletByNfcSerialNumber/$nfc";

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      print("status code: ${response.statusCode}");
      print('response: ${response.body}');
      var data = GetWalletByNFCSerialNumberModel.fromJson(
          jsonDecode(response.body.toString()));

      setState(() {
        associateName = data.user!.fullName!;
        mobileNo = data.user!.mobileNo!;
        userPicture = data.user!.userPicture!;
        userLognId = data.user!.userLoginId!;
      });

      return GetWalletByNFCSerialNumberModel.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

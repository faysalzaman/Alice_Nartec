import 'package:flutter/material.dart';
import 'package:grosshop/screens/add_card_screen.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../drawer/my_wallet_screen.dart';

class NFCScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NFCScreenState();
}

class NFCScreenState extends State<NFCScreen> {
  String userId = '';
  String userLoginId = '';

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var usrId = prefs.getInt('userId');
    var usrLoginId = prefs.getString("userLoginId");

    setState(() {
      userId = usrId.toString();
      userLoginId = usrLoginId.toString();
    });

    print(userId);
  }

  List nfcList = [];

  Future<void> _getNFC() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var usrId = prefs.getString('userLoginId');

    print('userId: $usrId');
    final String url = "http://gs1ksa.org:4000/api/getWalletById/$usrId";

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      print("userLoginId: $userLoginId");

      print("status code: " + response.statusCode.toString());
      var data = json.decode(response.body);
      var nfc = data[0]['nfcSerialNumber'];
      print(nfc);

      for (int i = 0, len = data.length; i < len; i++) {
        nfcList.add(data[i]['nfcSerialNumber']);
      }
    } else {
      print("status code: " + response.statusCode.toString());
      throw Exception('Failed to load data!');
    }
  }

  @override
  void initState() {
    super.initState();
    _getNFC();
    getUserId();
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
                                    ),
                                  )
                                : Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 200,
                                    child: Image.asset(
                                      "assets/images/nfc/done.png",
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
                            nfcList.contains(nfc)
                                ? Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          "NFC Serial Number is\nalready exists",
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.red,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        ElevatedButton(
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
                                            Get.off(() => MyWalletScreen());
                                          },
                                          child: const Text('Please Go Back'),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Visibility(
                                      visible:
                                          _isVisible == true ? true : false,
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
                                            Get.off(
                                              () => AddCardScreen(
                                                userId: userLoginId,
                                                nfcSerialNo: nfc,
                                                nfcCardType: cardType,
                                                nfcDetails: tech,
                                              ),
                                            );
                                          },
                                          child: const Text('Next Page'),
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
}

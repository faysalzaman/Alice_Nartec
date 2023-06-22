import 'package:get/get.dart';
import 'package:grosshop/data/card.dart';
import 'package:grosshop/screens/NFC/display_nfc_detail.dart';
import 'package:grosshop/screens/NFC/nfc_screen.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/widgets/back_widget.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../model/get_wallet_by_id_model.dart';

class MyWalletScreen extends StatefulWidget {
  @override
  _MyWalletScreenState createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  final amountController = TextEditingController();

  bool isLoading = true;

  Future<List<GetWalletByIdModel>> getWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var usrId = prefs.getString('userLoginId');

    print('userId: $usrId');

    final String url = "http://gs1ksa.org:4000/api/getWalletById/$usrId";

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body) as List;

      return jsonResponse.map((e) => GetWalletByIdModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          BackWidget(
            title: Strings.myWallet,
          ),
          bodyWidget(context),
        ],
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 2),
          topRight: Radius.circular(Dimensions.radius * 2),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: Dimensions.heightSize * 3),
            InkWell(
              onTap: () {
                Get.off(() => NFCScreen());
              },
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 10,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 50,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            FutureBuilder<List<GetWalletByIdModel>>(
                future: getWallet(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Something went wrong",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Container(
                      height: 100,
                      child: Center(
                        child: const Text(
                            "Click the above Icon\nScan your NFC card"),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: CustomColor.primaryColor,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // _inputAmountDialog(context);
                          Get.off(
                            () => NFCDetail(
                              id: snapshot.data![index].sId.toString(),
                              userId: snapshot.data![index].userId.toString(),
                              nfcSerialNo: snapshot.data![index].nfcSerialNumber
                                  .toString(),
                              nfcCardType:
                                  snapshot.data![index].nfcCardType.toString(),
                              nfcDetails:
                                  snapshot.data![index].nfcDetails.toString(),
                              cardAvailableAmount: snapshot
                                  .data![index].cardAvailableAmount
                                  .toString(),
                            ),
                          );
                        },
                        child: Dismissible(
                          key: Key(
                              snapshot.data![index].nfcSerialNumber.toString()),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) async {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm"),
                                  content: const Text(
                                      "Are you sure you wish to delete this item?"),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text("DELETE")),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("CANCEL"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          movementDuration: Duration(seconds: 1),
                          behavior: HitTestBehavior.opaque,
                          secondaryBackground: Container(
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            padding: EdgeInsets.only(right: 20),
                          ),
                          background: Container(
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            padding: EdgeInsets.only(right: 20),
                          ),
                          onDismissed: (direcrtion) {
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
                            deleteWallet(snapshot.data![index].nfcSerialNumber
                                .toString());
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: Card(
                              elevation: 10,
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      width: 90,
                                      height: 80,
                                      child: Image.asset(
                                        "assets/images/nfc/tapToPay.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data![index].nfcSerialNumber
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  _currentBalanceWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$',
              style: TextStyle(
                  color: Colors.black, fontSize: Dimensions.extraLargeTextSize),
            ),
            Text(
              '450.00',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.extraLargeTextSize * 1.8,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          Strings.totalDeposit,
          style: TextStyle(
              color: Colors.black, fontSize: Dimensions.largeTextSize),
        ),
      ],
    );
  }

  _paymentGatewayWidget(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: GatewayList.list().length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Gateway gateway = GatewayList.list()[index];
          return Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.marginSize,
                right: Dimensions.marginSize * 0.5,
                top: Dimensions.heightSize,
                bottom: Dimensions.heightSize,
              ),
              child: _addCardWidget(context));
        },
      ),
    );
  }

  _addCardWidget(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(1, 1), // Shadow position
            ),
          ],
        ),
        child: Icon(
          Icons.add,
          color: CustomColor.primaryColor,
          size: 40,
        ),
      ),
      onTap: () {
        Get.to(() => NFCScreen());
      },
    );
  }

  Future<void> deleteWallet(String nfcSerialNo) async {
    final url = "http://gs1ksa.org:4000/api/deleteWallet";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Host': 'gs1ksa.org',
    };

    final body = {
      "nfcSerialNumber": nfcSerialNo,
    };

    final response =
        await http.delete(uri, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      print("Wallet Deleted");
      Get.snackbar(
        "Success",
        "Wallet Deleted Successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Navigator.pop(context);
      print("Wallet Not Deleted");
      Get.snackbar(
        "Error",
        "Wallet Not Deleted",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

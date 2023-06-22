import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../../model/admin/get_payment_request_model.dart';

class TopUpPaymentRequestScreen extends StatefulWidget {
  const TopUpPaymentRequestScreen({super.key});

  @override
  State<TopUpPaymentRequestScreen> createState() =>
      _TopUpPaymentRequestScreenState();
}

class _TopUpPaymentRequestScreenState extends State<TopUpPaymentRequestScreen> {
  Future<GetPaymentRequestModel> getPaymentRequest() async {
    final String url = 'http://gs1ksa.org:4000/api/getPaymentRequests';
    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        print("status code is ${response.statusCode}");
        return GetPaymentRequestModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('No Data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.green,
                  Colors.green[800]!,
                ],
              ),
            ),
            child: Center(
              child: Text(
                "Requested Payment List",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<GetPaymentRequestModel>(
        future: getPaymentRequest(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 10,
                  shadowColor: Colors.green,
                  child: ListTile(
                    title: Text(
                      "NFC No. " +
                          snapshot.data!.data![index].singlePaymentRequest!
                              .nfcSerialNumber!,
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: " +
                              snapshot.data!.data![index].name.toString(),
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "Amount: SAR " +
                              snapshot.data!.data![index].singlePaymentRequest!
                                  .amount
                                  .toString(),
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            "Date: " +
                                snapshot.data!.data![index]
                                    .singlePaymentRequest!.createdAt!,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          "Payment Type: " +
                              snapshot.data!.data![index].singlePaymentRequest!
                                  .paymentMethod!,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Mobile: " +
                              snapshot.data!.data![index].mobileNo!.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    trailing: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text(
                                "Approve Payment",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              content: Text(
                                  "Are you sure you want to approve this payment?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "No",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                            color: Colors.transparent,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()));
                                      },
                                    );
                                    approvePaymentRequest(
                                      snapshot.data!.data![index]
                                          .singlePaymentRequest!.sId!
                                          .toString(),
                                      snapshot
                                          .data!
                                          .data![index]
                                          .singlePaymentRequest!
                                          .nfcSerialNumber!
                                          .toString(),
                                      snapshot.data!.data![index]
                                          .singlePaymentRequest!.userId!
                                          .toString(),
                                      int.parse(snapshot.data!.data![index]
                                          .singlePaymentRequest!.amount!
                                          .toString()),
                                    );
                                  },
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          "Approve",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("No Data Found"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> approvePaymentRequest(
    String sId,
    String nfcSerialNumber,
    String userId,
    int amount,
  ) async {
    final String url = 'http://gs1ksa.org:4000/api/approvePaymentRequest';
    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    final body = {
      "paymentRequestId": sId,
      "nfcSerialNumber": nfcSerialNumber,
      "userId": userId,
      "amount": amount,
    };

    try {
      final response =
          await http.post(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        print("status code is ${response.statusCode}");
        Get.snackbar(
          "Success",
          "Payment Approved Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        setState(() {});
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).pop();

        throw Exception('No Data');
      }
    } catch (e) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      throw Exception(e);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:grosshop/model/admin/get_all_inactive_products_model.dart';
import 'package:grosshop/screens/AdminScreens/admin_home_screen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class ProductsApprovalScreen extends StatefulWidget {
  const ProductsApprovalScreen({super.key});

  @override
  State<ProductsApprovalScreen> createState() => _ProductsApprovalScreenState();
}

class _ProductsApprovalScreenState extends State<ProductsApprovalScreen> {
  String mgs = '';

  Future<GetAllInActiveProductsModel> getAllInActiveProducts() async {
    String url = "http://gs1ksa.org:4000/api/getAllInActiveProducts";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        print('response is ${response.body}');
        return GetAllInActiveProductsModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        setState(() {
          mgs = 'No Data Found';
        });
        throw Exception('No Data Found');
      } else {
        print('response is ${response.body}');
        throw Exception('No Data Found');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // here the desired height
        child: AppBar(
          automaticallyImplyLeading: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.greenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                "Products Approval List",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<GetAllInActiveProductsModel>(
        future: getAllInActiveProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                mgs == '' ? "No data found" : mgs,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: mgs == ''
                    ? CircularProgressIndicator(
                        color: Colors.green,
                      )
                    : Text("No data found"));
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            );
          }

          var length = snapshot.data!.allData!.length;

          return ListView.builder(
            itemCount: length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                shadowColor: Colors.green,
                margin: EdgeInsets.all(5.0),
                child: ListTile(
                  leading: Image.network(
                    "http://gs1ksa.org:4000/" +
                        snapshot.data!.allData![index].images![0].imagePath
                            .toString()
                            .replaceAll("\\", "/"),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    snapshot.data!.allData![index].productName.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    snapshot.data!.allData![index].description.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    maxLines: 10,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          title: Text(
                            "Are you sure?",
                            style: TextStyle(color: Colors.green),
                          ),
                          content: Text("Do you want to approve this product?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                updateProductStatus(
                                    snapshot.data!.allData![index].sId!);
                              },
                              child: Text("Yes"),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> updateProductStatus(String productId) async {
    String url = "http://gs1ksa.org:4000/api/updateProductStatus";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    final body = {"productId": "$productId"};

    try {
      final response =
          await http.post(uri, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('response is ${response.body}');
        Get.back();
        Get.off(() => AdminHomeScreen());
        Get.snackbar(
          "Success",
          "Product Approved Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        print('response is ${response.body}');
        Get.back();
        Get.snackbar(
          "Error",
          "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

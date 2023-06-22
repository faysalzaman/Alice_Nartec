import 'package:flutter/material.dart';
import 'package:grosshop/model/Products/get_product_by_user_id_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SeeAllProductsScreen extends StatefulWidget {
  const SeeAllProductsScreen({super.key});

  @override
  State<SeeAllProductsScreen> createState() => _SeeAllProductsScreenState();
}

class _SeeAllProductsScreenState extends State<SeeAllProductsScreen> {
  Future<GetProductByUserIdModel> getAllProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdd = prefs.getString("userLoginId");

    final String url =
        'http://gs1ksa.org:4000/api/getProductsByUserId/$userIdd';
    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Content-Type': 'application/json',
      "Host": "gs1ksa.org",
    };

    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        print('response: ${response.body}');
        var data = GetProductByUserIdModel.fromJson(jsonDecode(response.body));
        return GetProductByUserIdModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('No data found!');
      }
    } catch (e) {
      print('error: $e');
      throw Exception('Failed to load data!, please try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green,
                  Colors.green[800]!,
                ],
              ),
            ),
            child: Center(
              child: Text(
                'See All Products',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<GetProductByUserIdModel>(
        future: getAllProducts(),
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
              // show opposite direction
              reverse: true,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                return Opacity(
                  opacity: snapshot.data!.data![index].productStatus! == 'true'
                      ? 1
                      : 0.5,
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.green,
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        snapshot.data!.data![index].productName!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                      subtitle: Text(
                        "Price: SAR " + snapshot.data!.data![index].offerPrice!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.amber,
                        ),
                      ),
                      trailing: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: snapshot.data!.data![index].productStatus! ==
                                  'true'
                              ? Colors.green
                              : Colors.red,
                        ),
                        child: Text(
                          snapshot.data!.data![index].productStatus! == 'true'
                              ? "Approved"
                              : "Pending",
                          style: TextStyle(
                            color: Colors.white,
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
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grosshop/model/Products/get_cart_by_id_model.dart';
import 'package:grosshop/screens/checkout_screen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<GetCartByIdModel> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdd = prefs.getString("userLoginId");

    print('*******User Id: $userIdd*******');

    final String url = "http://gs1ksa.org:4000/api/getMyCarts/$userIdd";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Content-Type': 'application/json',
      "Host": "gs1ksa.org",
    };

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");

        return GetCartByIdModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        print("Status Code: ${response.statusCode}");
        throw Exception("No My Carts Found");
      } else {
        print("Status Code: ${response.statusCode}");

        throw Exception("No My Carts Found");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _deleteCart(String cartId, String userId) async {
    final String url = "http://gs1ksa.org:4000/api/deleteOneCart";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Content-Type': 'application/json',
      "Host": "gs1ksa.org",
    };

    final body = {"cartId": cartId, "userId": userId};

    try {
      final response =
          await http.delete(uri, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        print("Status Code: ${response.statusCode}");

        Get.snackbar(
          "Cart Deleted",
          "Cart has been deleted successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      } else if (response.statusCode == 400) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();

        print("Status Code: ${response.statusCode}");
        Get.snackbar(
          "Cart Not Deleted",
          "Cart has not been deleted",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        throw Exception("No Cart Found");
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        print("Status Code: ${response.statusCode}");

        Get.snackbar(
          "Cart Not Deleted",
          "Cart has not been deleted",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );

        throw Exception("No Cart Found");
      }
    } catch (e) {
      Navigator.of(context).pop();
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.green,
          flexibleSpace: Container(
            child: Center(
              child: Text(
                "My Cart",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<GetCartByIdModel>(
        future: getCart(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            );
          }

          var addAllPrice = 0;
          for (var i = 0; i < snapshot.data!.data!.length; i++) {
            addAllPrice +=
                int.parse(snapshot.data!.data![i].itemPrice.toString()) *
                    int.parse(snapshot.data!.data![i].totalQty!.toString());
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                child: Text(
                  "Swipe Right to Delete",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      var price = int.parse(snapshot
                              .data!.data![index].itemPrice
                              .toString()) *
                          int.parse(
                              snapshot.data!.data![index].totalQty!.toString());

                      print("price: $price");
                      return Dismissible(
                        key: Key(snapshot.data!.data![index].sId.toString()),
                        behavior: HitTestBehavior.opaque,
                        onDismissed: (direction) {
                          Get.dialog(
                            AlertDialog(
                              title: Text(
                                "Delete Cart",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                "Are you sure you want to delete this cart?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      },
                                    );
                                    _deleteCart(
                                      snapshot.data!.data![index].sId
                                          .toString(),
                                      snapshot.data!.data![index].userId!
                                          .toLowerCase(),
                                    );
                                  },
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        direction: DismissDirection.startToEnd,
                        movementDuration: Duration(seconds: 1),
                        background: Container(
                          color: Colors.red,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 40,
                          ),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 4,
                          ),
                        ),
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.green,
                          margin: EdgeInsets.all(5),
                          child: ListTile(
                            // leading: Image.network(snapshot.data!.data![index]
                            //     .productId!.images![0].imagePath!
                            //     .toString()
                            //     .replaceAll("\\", "/")),
                            title: Text(
                              snapshot
                                  .data!.data![index].productId!.productName!
                                  .toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            subtitle: Text(
                              "SAR " + "$price",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              'x' +
                                  snapshot.data!.data![index].totalQty
                                      .toString(),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            child: Column(
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "SAR " + addAllPrice.toString(),
                                  style: TextStyle(
                                    color: Colors.amber[200],
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 30),
                            child: ElevatedButton(
                              onPressed: () async {
                                // await MoneyConverter.convert(
                                //   Currency(Currency.USD),
                                //   Currency(Currency.EGP),
                                // );
                                Get.to(
                                  () => CheckoutScreen(
                                    totalAmount: addAllPrice.toString(),
                                    itemName: snapshot
                                        .data!.data![0].productId!.productName!
                                        .toString(),
                                    itemPrice: snapshot.data!.data![0].itemPrice
                                        .toString(),
                                    itemQuantity: snapshot
                                        .data!.data![0].totalQty
                                        .toString(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                "Check Out",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

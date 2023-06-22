import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/widgets/back_widget.dart';
import 'package:grosshop/widgets/add_quantity_widget.dart';
import 'package:grosshop/widgets/primary_button_widget.dart';
import 'package:grosshop/widgets/secondary_button_widget.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'dashboard/cart_screen.dart';

class GroceryDetailsScreen extends StatefulWidget {
  String productName;
  String offerPrice;
  String retailPrice;
  String images;
  String id;
  String userId;
  String productItemCode;
  int gtin;
  String description;
  String productPhotoIdNo;
  String productOnSale;
  String itemBackNo;
  String itemSerialNo;
  String itemAvailableQty;

  GroceryDetailsScreen({
    Key? key,
    required this.productName,
    required this.offerPrice,
    required this.retailPrice,
    required this.images,
    required this.id,
    required this.userId,
    required this.productItemCode,
    required this.gtin,
    required this.description,
    required this.productPhotoIdNo,
    required this.productOnSale,
    required this.itemBackNo,
    required this.itemSerialNo,
    required this.itemAvailableQty,
  }) : super(key: key);

  @override
  _GroceryDetailsScreenState createState() => _GroceryDetailsScreenState();
}

class _GroceryDetailsScreenState extends State<GroceryDetailsScreen> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            //shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              BackWidget(
                title: Strings.groceryDetails,
              ),
              SizedBox(
                height: Dimensions.heightSize,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.network(
                  "http://gs1ksa.org:4000/" +
                      "${widget.images.replaceAll("\\", "/")}",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: Dimensions.heightSize,
              ),
              _itemDetails(
                widget.offerPrice,
                widget.productName,
              ),
              SizedBox(
                height: Dimensions.heightSize,
              ),
              _buttonsWidget(context),
              SizedBox(
                height: Dimensions.heightSize,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _itemDetails(
    String price,
    String name,
  ) {
    return Column(
      children: [
        // Container(
        //   height: Dimensions.buttonHeight,
        //   width: 100,
        //   decoration: BoxDecoration(
        //       color: CustomColor.primaryColor,
        //       borderRadius: BorderRadius.circular(Dimensions.radius)),
        //   child: Center(
        //     child: Text(
        //       '1KG',
        //       style: TextStyle(
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //           fontSize: Dimensions.largeTextSize),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: Dimensions.heightSize,
        ),
        Text(
          'SAR $price',
          style: TextStyle(
              color: CustomColor.accentColor,
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.extraLargeTextSize * 1.5),
        ),
        Text(
          name,
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.largeTextSize,
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Icon(
        //       Icons.star,
        //       size: 25,
        //       color: Colors.orange,
        //     ),
        //     Text(
        //       '(879 Review)',
        //       style: TextStyle(
        //           color: Colors.grey,
        //           fontSize: Dimensions.largeTextSize,
        //           fontWeight: FontWeight.bold),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  void minusCart() {
    setState(() {
      if (qty > 1) {
        qty--;
      } else {
        Fluttertoast.showToast(
            msg: Strings.quantityCantZero,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    });
  }

  void addCart() {
    setState(() {
      if (qty < 10) {
        qty++;
      } else {
        Fluttertoast.showToast(
            msg: Strings.quantityCantMax,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    });
  }

  Future<void> _addToCart(
    String prdctId,
    String dscptn,
    String qty,
    String offrPrce,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userLoginId');

    print("userId: $userId");
    print("prouductId: $prdctId");
    print("productDescription: $dscptn");
    print("totalQty: $qty");
    print("itemPrice: $offrPrce");

    final String url = 'http://gs1ksa.org:4000/api/postMyCarts';
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Host": "gs1ksa.org",
      "Content-Type": "application/json",
    };

    final body = {
      "userId": userId,
      "productId": prdctId,
      "productDescription": dscptn,
      "totalQty": qty,
      "itemPrice": offrPrce,
      "couponAmount": "0",
      "couponIdNo": "0"
    };

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        print("Status Code: ${response.statusCode}");
        Get.to(() => CartScreen());
        Get.snackbar(
          "Success",
          "${widget.productName} Added to cart",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          animationDuration: Duration(milliseconds: 500),
          backgroundGradient: LinearGradient(
            colors: [Colors.green, Colors.green],
          ),
        );
      } else {
        Navigator.of(context).pop();
        print("Status Code: ${response.statusCode}");
        Get.snackbar(
          "Error",
          "Something went wrong",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          animationDuration: Duration(milliseconds: 500),
          backgroundGradient: LinearGradient(
            colors: [Colors.red, Colors.red],
          ),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      print("Error: ${e.toString()}");
    }
  }

  _buttonsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        children: [
          AddQuantityWidget(
            qty: qty,
            minusCart: minusCart,
            addCart: addCart,
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          SecondaryButtonWidget(
            title: "Add to cart",
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Container(
                      color: Colors.transparent,
                      child: Center(child: CircularProgressIndicator()));
                },
              );

              _addToCart(
                widget.id,
                widget.description,
                qty.toString(),
                widget.offerPrice,
              );
            },
          ),
        ],
      ),
    );
  }
}

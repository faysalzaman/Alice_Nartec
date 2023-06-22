import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grosshop/Reseller/add_product_screen.dart';
import 'package:grosshop/Reseller/see_all_products_screen.dart';
import 'package:grosshop/Reseller/update_product_screen.dart';
import 'package:grosshop/model/Products/GetAllProductsModel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({super.key});

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  Future<List<GetAllProductsModel>> getProduct() async {
    final String url = "http://gs1ksa.org:4000/api/getAllProducts";
    final String uri = Uri.encodeFull(url);

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Host': 'gs1ksa.org',
    };
    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List;

        List<GetAllProductsModel> products = jsonData
            .map((product) => GetAllProductsModel.fromJson(product))
            .toList();

        return products;
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
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
                "My Products",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              Get.off(() => AddProductScreen());
            },
            label: Text('Add Product'),
            icon: Icon(Icons.add),
            backgroundColor: Colors.green,
            heroTag: 1,
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            onPressed: () {
              Get.to(() => SeeAllProductsScreen());
            },
            heroTag: 2,
            label: Text('See Un Approved Products'),
            icon: Icon(Icons.pending_actions),
            backgroundColor: Colors.green,
          ),
        ],
      ),
      body: FutureBuilder<List<GetAllProductsModel>>(
        future: getProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  color: Colors.grey,
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

          return Container(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(left: 10),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                int lengthOfImage = snapshot.data![index].images!.length;
                return MyProductCardWidget(
                  productName: snapshot.data![index].productName!,
                  offerPrice: snapshot.data![index].offerPrice!,
                  retailPrice: snapshot.data![index].retailPrice!,
                  productImage: snapshot
                      .data![index].images![lengthOfImage - 1].imagePath!,
                  id: snapshot.data![index].sId!,
                  userId: snapshot.data![index].userId!,
                  productItemCode: snapshot.data![index].productItemCode!,
                  gtin: snapshot.data![index].gtin!,
                  description: snapshot.data![index].description!,
                  productPhotoIdNo: snapshot.data![index].productPhotoIdNo!,
                  productOnSale: snapshot.data![index].productOnSale!,
                  itemBackNo: snapshot.data![index].itemBatchNo!,
                  itemSerialNo: snapshot.data![index].itemSerialNumber!,
                  itemAvailableQty: snapshot.data![index].itemAvailableQty!,
                  imageId:
                      snapshot.data![index].images!.map((e) => e.sId!).toList(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MyProductCardWidget extends StatelessWidget {
  String productName;
  String offerPrice;
  String retailPrice;
  String productImage;
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
  List<String> imageId = [];

  MyProductCardWidget({
    required this.productName,
    required this.offerPrice,
    required this.retailPrice,
    required this.productImage,
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
    required this.imageId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.off(
          () => UpdateProductScreen(
            id: id,
            userId: userId,
            productItemCode: productItemCode,
            gtin: gtin,
            description: description,
            productPhotoIdNo: productPhotoIdNo,
            productOnSale: productOnSale,
            itemBackNo: itemBackNo,
            itemSerialNo: itemSerialNo,
            itemAvailableQty: itemAvailableQty,
            productName: productName,
            offerPrice: offerPrice,
            retailPrice: retailPrice,
            images: productImage,
          ),
        );
      },
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30), topLeft: Radius.circular(30)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: 150,
          child: GridTile(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Image.network(
                    "http://gs1ksa.org:4000/" +
                        "${productImage.replaceAll("\\", "/")}",
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              ),
            ),
            header: Container(
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  productName,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        Text(
                          "SAR " + retailPrice,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "-------",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(width: 7),
                    Text(
                      offerPrice,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text("100k"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

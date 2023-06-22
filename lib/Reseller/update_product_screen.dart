import 'dart:io';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:grosshop/Reseller/my_product_screen.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProductScreen extends StatefulWidget {
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

  UpdateProductScreen({
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
  });

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productItemCode = TextEditingController();
  final TextEditingController _gtinController = TextEditingController();
  final TextEditingController _retailPriceController = TextEditingController();
  final TextEditingController _offerPriceController = TextEditingController();
  final TextEditingController _productOnSellController =
      TextEditingController();
  final TextEditingController _itemUnitController = TextEditingController();
  final TextEditingController _itemExpiryDate = TextEditingController();
  final TextEditingController _itemAvailableQtyController =
      TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }

  Future<void> deleteItem() async {
    try {
      String url = 'http://gs1ksa.org:4000/api/deleteProductById/${widget.id}';
      String uri = Uri.encodeFull(url);

      final headers = <String, String>{
        'Content-Type': 'application/json',
        'Host': 'gs1ksa.org',
      };

      final response = await http.delete(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        Get.off(() => MyProductsScreen());

        Get.snackbar(
          "Success",
          "Product Deleted Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Navigator.of(context).pop();
        Get.off(() => MyProductsScreen());

        Get.snackbar(
          "Error",
          "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.off(() => MyProductsScreen());

      Get.snackbar(
        "Error",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateItem(
    String productItemCode,
    String gtin,
    String description,
    String retailPrice,
    String offerPrice,
    String productName,
    String itemAvailableQty,
    String productOnSale,
    String itemUnit,
    String itemExpiryDate,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userLoginId = prefs.getString('userLoginId');
    print("userLoginId: $userLoginId");

    // upload image
    String url = 'http://gs1ksa.org:4000/api/updateProducts/${widget.id}';

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(url),
    );

    request.fields['userId'] = userLoginId.toString();
    request.fields['productItemCode'] = productItemCode;
    request.fields['gtin'] = gtin;
    request.fields['description'] = description;
    request.fields['retailPrice'] = retailPrice;
    request.fields['offerPrice'] = offerPrice;
    request.fields['productName'] = productName;
    request.fields['itemAvailableQty'] = itemAvailableQty;
    request.fields['productOnSale'] = productOnSale;
    request.fields['itemUnit'] = itemUnit;
    request.fields['itemExpiryDate'] = itemExpiryDate;

    // Add image file to request

    for (int i = 0; i < imageFileList!.length; i++) {
      final imageFile = imageFileList![i];
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var imageMultipartFile = http.MultipartFile(
          'image${i + 1}', imageStream, imageLength,
          filename: imageFile.path);
      request.files.add(imageMultipartFile);
    }

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        print("Product updated Successfully");
        Get.off(() => MyProductsScreen());
        Get.snackbar(
          "Success",
          "Product updated Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        print("Error: ${response.statusCode}");
        Navigator.of(context).pop();
        Get.off(() => MyProductsScreen());
        Get.snackbar(
          "Error",
          "${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _productDescriptionController.dispose();
    _productNameController.dispose();
    _productItemCode.dispose();
    _gtinController.dispose();
    _retailPriceController.dispose();
    _offerPriceController.dispose();
    _productOnSellController.dispose();
    _itemUnitController.dispose();
    _itemExpiryDate.dispose();
    _itemAvailableQtyController.dispose();
  }

  GlobalKey globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      _productDescriptionController.text = widget.description;
      _productNameController.text = widget.productName;
      _productItemCode.text = widget.productItemCode;
      _gtinController.text = widget.gtin.toString();
      _retailPriceController.text = widget.retailPrice;
      _offerPriceController.text = widget.offerPrice;
      _productOnSellController.text = widget.productOnSale;
      _itemUnitController.text = widget.itemAvailableQty;
      _itemExpiryDate.text = widget.itemAvailableQty;
      _itemAvailableQtyController.text = widget.itemAvailableQty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Update Product",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: globalFormKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  imageFileList!.isEmpty
                      ? Container(
                          height: 100,
                          width: 200,
                          child: Image.network(
                            "http://gs1ksa.org:4000/" +
                                "${widget.images.replaceAll("\\", "/")}",
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.medium,
                          ),
                        )
                      : CarouselSliderWidget(images: imageFileList!),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      selectImages();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/grocery/file.png",
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Add Images",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // product description
                  Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Put some description';
                        else
                          return null;
                      },
                      controller: _productDescriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product Description',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                      title: "Fill Some Name",
                      onPressed: (value) {
                        if (value.isEmpty)
                          return;
                        else
                          return null;
                      },
                      controller: _productNameController,
                      name: "Product Name"),
                  const SizedBox(height: 5),
                  TextFieldWidget(
                      title: "Fill The Field",
                      onPressed: (value) {
                        if (value.isEmpty)
                          return;
                        else
                          return null;
                      },
                      controller: _productItemCode,
                      name: "Product Item Code"),
                  const SizedBox(height: 5),
                  TextFieldWidget(
                    title: "Fill The Field",
                    onPressed: (value) {
                      if (value.isEmpty)
                        return;
                      else
                        return null;
                    },
                    controller: _gtinController,
                    name: "GTIN",
                  ),
                  const SizedBox(height: 5),
                  TextFieldWidget(
                      title: "Fill the price in numbers.",
                      onPressed: (value) {
                        if (value.isEmpty || value.numericOnly() == false)
                          return;
                        else
                          return null;
                      },
                      controller: _retailPriceController,
                      name: "Retail Price"),
                  const SizedBox(height: 5),
                  TextFieldWidget(
                      title: 'Fill the price in numbers.',
                      onPressed: (value) {
                        if (value.isEmpty || value.numericOnly() == false)
                          return;
                        else
                          return null;
                      },
                      controller: _offerPriceController,
                      name: "Offer Price"),
                  const SizedBox(height: 5),
                  TextFieldWidget(
                      title: 'Fill just True and False',
                      onPressed: (value) {
                        if (value.isEmpty || !value.isBool)
                          return;
                        else
                          return null;
                      },
                      controller: _productOnSellController,
                      name: "Product On Sell"),
                  const SizedBox(height: 5),
                  TextFieldWidget(
                      title: 'Fill the field',
                      onPressed: (value) {
                        if (value.isEmpty)
                          return;
                        else
                          return null;
                      },
                      controller: _itemUnitController,
                      name: "Item Unit"),
                  const SizedBox(height: 5),
                  TextFieldWidget(
                      title: '12/12/2000',
                      onPressed: (value) {
                        if (value.isEmpty)
                          return;
                        else
                          return null;
                      },
                      controller: _itemExpiryDate,
                      name: "Item Expiry Date"),
                  const SizedBox(height: 5),

                  TextFieldWidget(
                      title: "Fill the Quality",
                      onPressed: (value) {
                        if (value.isEmpty || value.numericOnly() == false)
                          return;
                        else
                          return null;
                      },
                      controller: _itemAvailableQtyController,
                      name: "Item Available Qty"),
                  const SizedBox(height: 5),
                  // save button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                    color: Colors.transparent,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              },
                            );

                            await updateItem(
                              _productItemCode.text.trim().toString(),
                              _gtinController.text.trim().toString(),
                              _productDescriptionController.text
                                  .trim()
                                  .toString(),
                              _retailPriceController.text.trim().toString(),
                              _offerPriceController.text.trim().toString(),
                              _productNameController.text.trim().toString(),
                              _itemAvailableQtyController.text
                                  .trim()
                                  .toString(),
                              _productOnSellController.text.trim().toString(),
                              _itemUnitController.text.trim().toString(),
                              _itemExpiryDate.text.trim().toString(),
                            );
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 33, 135, 36),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 30,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                    color: Colors.transparent,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              },
                            );
                            await deleteItem();
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 33, 135, 36),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
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
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  String name;
  Function onPressed;
  String title;

  TextEditingController controller;

  TextFieldWidget({
    super.key,
    required this.controller,
    required this.name,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: controller == '' ? 30 : 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty)
                  return title;
                else
                  return null;
              },
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    super.key,
    required this.images,
  });

  final List<XFile?> images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        return Stack(
          children: [
            Image.file(
              File(images[index]!.path),
              fit: BoxFit.cover,
              width: 150.0,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Row(
                // make the dots to be centered with the slider
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < images.length; i++) ...[
                    const SizedBox(width: 5),
                    Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == index ? Colors.green : Colors.black,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
      carouselController: CarouselController(),
      options: CarouselOptions(
        height: 150.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
        pageSnapping: true,
        animateToClosest: true,
        autoPlayInterval: Duration(seconds: 2),
        initialPage: 0,
      ),
    );
  }
}

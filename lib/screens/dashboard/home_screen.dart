// ignore_for_file: must_be_immutable, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:grosshop/data/category.dart';
import 'package:grosshop/data/discount.dart';
import 'package:grosshop/data/grocery.dart';
import 'package:grosshop/screens/AssignedStutdents/add_sudents_screen.dart';
import 'package:grosshop/screens/dashboard/profile_screen.dart';
import 'package:grosshop/staff/attendance_screen.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/custom_style.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/widgets/drawer_header_widget.dart';
import 'package:grosshop/widgets/list_data_widget.dart';
import 'package:hive/hive.dart';
import 'package:grosshop/screens/category_details_screen.dart';
import 'package:grosshop/screens/grocery_details_screen.dart';
import 'package:grosshop/screens/filter_screen.dart';
import 'package:grosshop/screens/auth/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Reseller/my_product_screen.dart';
import '../../model/Products/GetAllProductsModel.dart';
import '../../model/get_user_by_id_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import '../drawer/my_wallet_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentLocation;
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Box<bool>? stayLoggedIn;

  int userTypeIdNo = 0;

  Future<GetUserByIdModel> _getAllUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? userLoginId = prefs.getString('userLoginId');

      final String url = 'http://gs1ksa.org:4000/api/getUserById/$userLoginId';
      var uri = Uri.parse(url);
      final headers = <String, String>{
        'Host': 'gs1ksa.org',
        'Content-Type': 'application/json',
      };
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        print('response.body is ${response.body}');

        var data = jsonDecode(response.body);
        final usrTypeIdNo = data['userTypeIdNo'].toString();

        setState(() {
          userTypeIdNo = int.parse(usrTypeIdNo);
        });

        print('userTypeIdNo is $userTypeIdNo');

        return GetUserByIdModel.fromJson(jsonDecode(response.body));
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(response.body.toString());
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('error is $e');
      return GetUserByIdModel.fromJson({});
    }
  }

  // bool isCallScreen = false;

  // String _associateName = '';
  // String _associateId = '';

  // Future<GetQueueDataById> _getQueueData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String? userLoginId = prefs.getString('userLoginId');

  //   final String url =
  //       "http://gs1ksa.org:4000/api/GetUserDataFromQueue/$userLoginId";
  //   final uri = Uri.parse(url);

  //   final headers = <String, String>{
  //     'Host': 'gs1ksa.org',
  //     'Content-Type': 'application/json',
  //   };

  //   final response = await http.get(uri, headers: headers);

  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);

  //     var jsonData = GetQueueDataById.fromJson(data);
  //     print("userId: " + jsonData.data![0].userId.toString());

  //     setState(() {
  //       isCallScreen = true;
  //       _associateName = jsonData.data![0].userNameCaller!.toString();
  //       _associateId = jsonData.data![0].userIdAssociateNo!.toString();
  //     });

  //     print('isCallScreen is $isCallScreen');

  //     return jsonData;
  //   } else {

  //     return GetQueueDataById.fromJson({});
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // _determinePosition();
    // currentLocation = '';
    // getUserLocation();
    _getAllUser();

    // _getQueueData().then(
    //   (value) {
    //     if (userTypeIdNo == 1) {
    //       FlutterRingtonePlayer.play(
    //         fromAsset: "assets/ringtone/beep.mp3",
    //         ios: IosSounds.glass,
    //         looping: true,
    //       );
    //       Get.to(
    //         () => ReveiveCallScreen(
    //           name: _associateName,
    //           userLoginId: _associateId,
    //         ),
    //       );
    //     }
    //   },
    // );
  }

  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userLoginId');

    // stayLoggedIn!.put("stayLoggedIn", false);

    // print('stayLoggedIn is ${stayLoggedIn!.get("stayLoggedIn")}');
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
    );
  }

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
      } else if (response.statusCode == 400) {
        print('response.statusCode is ${response.statusCode}');
        throw Exception('Failed to load data!');
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  String msg = '';

  Future<List<GetAllProductsModel>> getProducts() async {
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
      } else if (response.statusCode == 400) {
        print('response.statusCode is ${response.statusCode}');
        setState(() {
          msg = 'No Product Found';
        });
        throw Exception('Failed to load data!');
      } else {
        print('response.statusCode is ${response.statusCode}');
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: CustomColor.primaryColor,
          child: ListView(
            children: <Widget>[
              Container(
                height: 200,
                child: DrawerHeader(
                  child: DrawerHeaderWidget(),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              ListDataWidget(
                icon: 'assets/images/person.png',
                color: Colors.white,
                title: "My Profile",
                onTap: () {
                  Navigator.of(context).pop();
                  Get.to(() => ProfileScreen());
                },
              ),
              ListDataWidget(
                icon: 'assets/images/icon/wallet.png',
                title: Strings.myWallet,
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyWalletScreen()));
                },
              ),
              Visibility(
                visible: userTypeIdNo == 4 ? true : false,
                child: ListDataWidget(
                  icon: "assets/images/icon/assign.png",
                  color: Colors.white,
                  title: "Assigned Students",
                  onTap: () {
                    Get.to(() => AddStudentScreen());
                  },
                ),
              ),
              Visibility(
                visible: userTypeIdNo == 2 ? true : false,
                child: ListDataWidget(
                  icon: "assets/images/icon/time.png",
                  color: Colors.white,
                  title: "Time and Attendance",
                  onTap: () {
                    Get.to(() => AttendanceScreen());
                  },
                ),
              ),
              Visibility(
                visible: userTypeIdNo == 3 ? true : false,
                child: ListDataWidget(
                  icon: "assets/images/icon/product.png",
                  color: Colors.white,
                  title: "My Products",
                  onTap: () {
                    Get.to(() => MyProductsScreen());
                  },
                ),
              ),
              // ListDataWidget(
              //   icon: 'assets/images/icon/settings.png',
              //   title: Strings.changePassword,
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => ChangePasswordScreen()));
              //   },
              // ),
              // ListDataWidget(
              //   icon: 'assets/images/icon/help.png',
              //   title: Strings.helpSupport,
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => MessagingScreen()));
              //   },
              // ),
              ListDataWidget(
                icon: 'assets/images/icon/logout.png',
                title: Strings.signOut,
                onTap: () {
                  signOut();
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            // _locationWidget(context),
            _menuWidget(context),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            _discountBannerWidget(context),
            SizedBox(
              height: Dimensions.heightSize * 3,
            ),

            Container(
              child: Text(
                "All Products",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            FutureBuilder<List<GetAllProductsModel>>(
              future: getProducts(),
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

                return Container(
                  padding: EdgeInsets.all(10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
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
                        productPhotoIdNo:
                            snapshot.data![index].productPhotoIdNo!,
                        productOnSale: snapshot.data![index].productOnSale!,
                        itemBackNo: snapshot.data![index].itemBatchNo!,
                        itemSerialNo: snapshot.data![index].itemSerialNumber!,
                        itemAvailableQty:
                            snapshot.data![index].itemAvailableQty!,
                        imageId: snapshot.data![index].images!
                            .map((e) => e.sId!)
                            .toList(),
                      );
                    },
                  ),
                );
              },
            ),

            // _bannerWidget(context),

            // _categoryWidget(context),
            // _todayGroceryDealsWidget(context),
            // SizedBox(
            //   height: Dimensions.heightSize,
            // ),
            // _bannerWidget(context),
            // SizedBox(
            //   height: Dimensions.heightSize,
            // ),
            // _groceryMemberDealsWidget(context)
          ],
        ),
      ),
    );
  }

  _menuWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
          top: Dimensions.heightSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Container(
              height: Dimensions.buttonHeight,
              width: Dimensions.buttonHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius),
                boxShadow: [
                  BoxShadow(
                    color: CustomColor.accentColor.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 0.5,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Icon(
                Icons.menu,
                color: CustomColor.accentColor,
              ),
            ),
            onTap: () {
              if (scaffoldKey.currentState!.isDrawerOpen) {
                return scaffoldKey.currentState!.openEndDrawer();
              } else {
                return scaffoldKey.currentState!.openDrawer();
              }
            },
          ),
          SizedBox(
            width: Dimensions.widthSize,
          ),
          Expanded(
            child: TextFormField(
              style: CustomStyle.textStyle,
              controller: searchController,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return Strings.pleaseFillOutTheField;
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: Strings.searchResult,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                labelStyle: CustomStyle.textStyle,
                filled: true,
                fillColor: Colors.white,
                hintStyle: CustomStyle.textStyle,
                focusedBorder: CustomStyle.searchBox,
                enabledBorder: CustomStyle.searchBox,
                focusedErrorBorder: CustomStyle.searchBox,
                errorBorder: CustomStyle.searchBox,
                prefixIcon: Icon(
                  Icons.search,
                  color: CustomColor.accentColor,
                ),
              ),
            ),
          ),
          SizedBox(
            width: Dimensions.widthSize,
          ),
          GestureDetector(
            child: Container(
              height: Dimensions.buttonHeight,
              width: Dimensions.buttonHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius),
                boxShadow: [
                  BoxShadow(
                    color: CustomColor.accentColor.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 0.5,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Icon(
                Icons.filter_alt_outlined,
                color: CustomColor.accentColor,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FilterScreen()));
            },
          )
        ],
      ),
    );
  }

  _discountBannerWidget(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: DiscountList.list().length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          Discount discount = DiscountList.list()[index];
          return Padding(
            padding: const EdgeInsets.only(left: Dimensions.marginSize),
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width - 100,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                    child: Image.asset(
                      discount.image!,
                      fit: BoxFit.cover,
                      height: 180,
                      width: MediaQuery.of(context).size.width - 100,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  Positioned(
                    bottom: Dimensions.heightSize,
                    left: Dimensions.marginSize,
                    child: Text(
                      'Get ${discount.discount}% off',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.extraLargeTextSize),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _categoryWidget(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        itemCount: CategoryList.list().length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Category category = CategoryList.list()[index];
          return Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.marginSize,
              right: Dimensions.marginSize,
            ),
            child: GestureDetector(
              child: Container(
                child: Column(
                  children: [
                    Image.asset(category.image!),
                    SizedBox(
                      height: Dimensions.heightSize,
                    ),
                    Text(
                      category.name!,
                      style: TextStyle(
                          color: CustomColor.accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.largeTextSize),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryDetailsScreen(
                      name: category.name,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  _todayGroceryDealsWidget(BuildContext context) {
    return FutureBuilder<List<GetAllProductsModel>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Something went wrong",
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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize,
                    right: Dimensions.marginSize,
                    bottom: Dimensions.heightSize),
                child: Text(
                  Strings.todayGroceryDeals,
                  style: TextStyle(
                      color: CustomColor.accentColor,
                      fontSize: Dimensions.extraLargeTextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
              StaggeredGridView.countBuilder(
                crossAxisCount: 3,
                itemCount: GroceryList.list().length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  Grocery grocery = GroceryList.list()[index];
                  return GestureDetector(
                    child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2))),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(grocery.image!),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                                Text(
                                  grocery.name!,
                                  style: TextStyle(
                                      color: CustomColor.accentColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '\$${grocery.oldPrice.toString()}',
                                            style: TextStyle(
                                                color: CustomColor.accentColor
                                                    .withOpacity(0.8),
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize:
                                                    Dimensions.smallTextSize),
                                          ),
                                          SizedBox(
                                            width: Dimensions.widthSize * 0.5,
                                          ),
                                          Text(
                                            '\$${grocery.newPrice.toString()}',
                                            style: TextStyle(
                                                color: CustomColor.accentColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    Dimensions.smallTextSize),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 15,
                                            color: Colors.orange,
                                          ),
                                          Text(
                                            '\$${grocery.rating.toString()}',
                                            style: TextStyle(
                                                color: CustomColor.accentColor
                                                    .withOpacity(0.8),
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize:
                                                    Dimensions.smallTextSize),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: Dimensions.marginSize * 0.5,
                              top: Dimensions.heightSize * 0.5,
                              child: Icon(
                                Icons.favorite_border,
                                size: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        )),
                    onTap: () {
                      int lengthOfImage = snapshot.data![index].images!.length;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GroceryDetailsScreen(
                            description: snapshot.data![index].description!,
                            images: snapshot.data![index]
                                .images![lengthOfImage - 1].imagePath!,
                            gtin: snapshot.data![index].gtin!,
                            id: snapshot.data![index].sId!,
                            itemAvailableQty:
                                snapshot.data![index].itemAvailableQty!,
                            itemBackNo: snapshot.data![index].itemBatchNo!,
                            itemSerialNo:
                                snapshot.data![index].itemSerialNumber!,
                            offerPrice: snapshot.data![index].offerPrice!,
                            productItemCode:
                                snapshot.data![index].productItemCode!,
                            productName: snapshot.data![index].productName!,
                            productOnSale: snapshot.data![index].productOnSale!,
                            productPhotoIdNo:
                                snapshot.data![index].productPhotoIdNo!,
                            retailPrice: snapshot.data![index].retailPrice!,
                            userId: snapshot.data![index].userId!,
                          ),
                        ),
                      );
                    },
                  );
                },
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
              ),
            ],
          );
        });
  }

  _bannerWidget(BuildContext context) {
    return Image.asset(
      'assets/images/banner.png',
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.fitWidth,
    );
  }

  _groceryMemberDealsWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.marginSize,
              right: Dimensions.marginSize,
              bottom: Dimensions.heightSize),
          child: Text(
            Strings.groceryMemberDeals,
            style: TextStyle(
                color: CustomColor.accentColor,
                fontSize: Dimensions.extraLargeTextSize,
                fontWeight: FontWeight.bold),
          ),
        ),
        StaggeredGridView.countBuilder(
          crossAxisCount: 3,
          itemCount: GroceryList.list().length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            Grocery grocery = GroceryList.list()[index];
            return Container(
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.withOpacity(0.2))),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(grocery.image!),
                        SizedBox(
                          height: Dimensions.heightSize * 0.5,
                        ),
                        Text(
                          grocery.name!,
                          style: TextStyle(
                              color: CustomColor.accentColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '\$${grocery.oldPrice.toString()}',
                                    style: TextStyle(
                                        color: CustomColor.accentColor
                                            .withOpacity(0.8),
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: Dimensions.smallTextSize),
                                  ),
                                  SizedBox(
                                    width: Dimensions.widthSize * 0.5,
                                  ),
                                  Text(
                                    '\$${grocery.newPrice.toString()}',
                                    style: TextStyle(
                                        color: CustomColor.accentColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.smallTextSize),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    '\$${grocery.rating.toString()}',
                                    style: TextStyle(
                                        color: CustomColor.accentColor
                                            .withOpacity(0.8),
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: Dimensions.smallTextSize),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: Dimensions.marginSize * 0.5,
                      top: Dimensions.heightSize * 0.5,
                      child: Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ));
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
        ),
      ],
    );
  }
}

class MyProductCardWidget extends StatelessWidget {
  final String productName;
  final String offerPrice;
  final String retailPrice;
  final String productImage;
  final String id;
  final String userId;
  final String productItemCode;
  final int gtin;
  final String description;
  final String productPhotoIdNo;
  final String productOnSale;
  final String itemBackNo;
  final String itemSerialNo;
  final String itemAvailableQty;
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

  Category category = Category();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => GroceryDetailsScreen(
              description: description,
              gtin: gtin,
              id: id,
              images: productImage,
              itemAvailableQty: itemAvailableQty,
              itemBackNo: itemBackNo,
              itemSerialNo: itemSerialNo,
              offerPrice: offerPrice,
              productItemCode: productItemCode,
              productOnSale: productOnSale,
              productPhotoIdNo: productPhotoIdNo,
              productName: productName,
              retailPrice: retailPrice,
              userId: userId,
            ));
      },
      child: Material(
        elevation: 10,
        child: Container(
          color: Colors.grey[100],
          child: GridTile(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Image.network(
                  "http://gs1ksa.org:4000/" +
                      "${productImage.replaceAll("\\", "/")}",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text(
                        "No Image",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            header: Container(
              decoration: BoxDecoration(
                color: Colors.black38,
              ),
              child: Center(
                child: FittedBox(
                  child: Text(
                    productName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
                        FittedBox(
                            child: Text(
                          "SAR " + retailPrice,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        )),
                        FittedBox(
                          child: Text(
                            "--------",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 5),
                    FittedBox(
                      child: Text(
                        offerPrice,
                        style: TextStyle(
                          fontSize: 12,
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
    );
  }
}

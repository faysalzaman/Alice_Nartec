import 'dart:io';

import 'package:get/get.dart';
import 'package:grosshop/data/card.dart';
import 'package:grosshop/screens/AssignedStutdents/calling_screen.dart';
import 'package:grosshop/screens/AssignedStutdents/scan_student_nfc.dart';
import 'package:grosshop/screens/dashboard_screen.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/widgets/back_widget.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../model/Get_All_Associate_By_UserId_Model.dart';
import '../../model/get_user_by_id_model.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final amountController = TextEditingController();

  static int lengthOfAssociate = 0;

  Future<List<GetAllAssociateByUserIdModel>> getAllAssociate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userId = prefs.getString('userLoginId');
    String? userEmail = prefs.getString('emailId');

    var url =
        Uri.parse("http://gs1ksa.org:4000/api/GetAllAssociateByUserId/$userId");

    final headers = <String, String>{
      'Content-Type': 'application/json',
      "Host": "gs1ksa.org",
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print("length of Associate: $lengthOfAssociate");
        print('status code 200');

        var json = jsonDecode(response.body) as List;

        lengthOfAssociate = json.length;

        return json
            .map((e) => GetAllAssociateByUserIdModel.fromJson(e))
            .toList();
      } else {
        print('status code ${response.statusCode}');
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load data!');
    }
  }

  String fullName = '';

  Future<GetUserByIdModel> getUserById() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lginId = prefs.getString('userLoginId')!;

    print('*******userId******: $lginId');

    final String url = "http://gs1ksa.org:4000/api/getUserById/$lginId";

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        print('response: ${response.body}');
        var data = GetUserByIdModel.fromJson(jsonDecode(response.body));

        setState(() {
          fullName = data.fullName!.toString();
        });

        return GetUserByIdModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

  Future<void> deleteAssociate(String associateId) async {
    print("*********associateId********* $associateId");

    final String url =
        "http://gs1ksa.org:4000/api/deleteAssociateByUserId/$associateId";
    final uri = Uri.parse(url);
    final headers = <String, String>{
      'Content-Type': 'application/json',
      "Host": "gs1ksa.org",
    };

    try {
      var response = await http.delete(uri, headers: headers);
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();

        print('response: ${response.body}');
        Get.snackbar(
          "Success",
          "Student Deleted Successfully",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).pop();

        print('status code ${response.statusCode}');
        Get.snackbar(
          "Error",
          "Something went wrong",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      print(e.toString());
      throw Exception('Failed to load data!');
    }
  }

  Future<void> _postQueue(
    String userId,
    List<String> userIdAssociateNo,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lginId = prefs.getString('userLoginId')!;

    print('*******userId******: $lginId');

    final String url = "http://gs1ksa.org:4000/api/postQueue";

    final headers = <String, String>{
      'Content-Type': 'application/json',
      "Host": "gs1ksa.org",
    };

    print("userId: $userId");
    print("userIdAssociateNo: ${jsonEncode(userIdAssociateNo)}");

    final body = {"userId": userId, "userIdAssociateNo": userIdAssociateNo};

    print("body: ${jsonEncode(body)}");

    try {
      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        print("status code 200");

        Get.to(
          () => CallingScreen(
            userId: userId,
            associateId: userIdAssociateNo,
          ),
        );

        Get.snackbar(
          "Calling...",
          "",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      } else {
        print('status code ${response.statusCode}');
        Get.snackbar(
          "Error",
          "Something went wrong",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load data!');
    }
  }

  List<bool> _isSelected = [];
  List<String> _selectedAssociate = [];

  @override
  void initState() {
    super.initState();
    getUserById();
    getAllAssociate().then((value) {
      _isSelected = List.generate(lengthOfAssociate, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => DashboardScreen());
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            BackWidget(
              title: "My Students",
            ),
            bodyWidget(context),
          ],
        ),
        // // floatingActionButton: Visibility(
        // //   visible: _isSelected.isEmpty ? false : true,
        // //   child: FloatingActionButton.extended(
        // //     backgroundColor: Colors.green,
        // //     onPressed: () {},
        // //     label: Text("Group Call"),
        // //     icon: Icon(Icons.call),
        // //   ),
        // ),
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
                Get.to(() => ScanStudentNFCScreen());
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
            Center(
              child: Text(
                fullName == "" ? "" : "Swipe Right to Call",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                fullName == "" ? "" : "Tap to Delete",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            FutureBuilder<List<GetAllAssociateByUserIdModel>>(
              future: getAllAssociate(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        "No data found",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Container(
                    child: Center(
                      child: Text(
                        'No Data Found',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                if (snapshot.data!.isEmpty) {
                  return Container(
                    child: Center(
                      child: Text(
                        'No Data Found',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    color: Colors.transparent,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ),
                  );
                }

                return Container(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          children: [
                            ElevatedButton.icon(
                              icon: Icon(Icons.call),
                              onPressed: () {
                                print(snapshot.data![index].associate!.userId!
                                    .toString());
                                print(jsonEncode(_selectedAssociate));
                                print(snapshot
                                    .data![index].associate!.userNameCaller!
                                    .toString());
                                print(snapshot.data![index].user!.fullName!
                                    .toString());

                                if (_selectedAssociate.isNotEmpty) {
                                  _postQueue(
                                    snapshot.data![index].associate!.userId!
                                        .toString(),
                                    _selectedAssociate,
                                  );
                                } else {
                                  Get.snackbar(
                                    "Error",
                                    "Please select at least one student to call",
                                    colorText: Colors.white,
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: Duration(seconds: 3),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              label: Text('Call'),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.dialog(
                                  AlertDialog(
                                    title: Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                      "Are you sure to delete this student?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          "No",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
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
                                                      child:
                                                          CircularProgressIndicator()));
                                            },
                                          );
                                          deleteAssociate(
                                            snapshot.data![index].user!
                                                .userLoginId!,
                                          );
                                        },
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                child: Card(
                                  color: _isSelected[index] == true
                                      ? Colors.grey[200]
                                      : Colors.white,
                                  elevation: _isSelected == true ? 5 : 10,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: CheckboxListTile(
                                      value: _isSelected[index],
                                      onChanged: (value) {
                                        setState(() {
                                          _isSelected[index] = value!;
                                          _isSelected[index] == true
                                              ? _selectedAssociate.add(snapshot
                                                  .data![index]
                                                  .associate!
                                                  .userIdAssociateNo!)
                                              : _selectedAssociate.remove(
                                                  snapshot
                                                      .data![index]
                                                      .associate!
                                                      .userIdAssociateNo!);
                                        });
                                        print(_selectedAssociate);
                                      },
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.all(10),
                                              width: 90,
                                              height: 80,
                                              child: Image.file(
                                                File(snapshot.data![index].user!
                                                    .userPicture!
                                                    .toString()),
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return CircleAvatar(
                                                    child: Icon(Icons.person),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              snapshot
                                                  .data![index].user!.fullName!
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text(
                                "Delete",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                "Are you sure to delete this student?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
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
                                                child:
                                                    CircularProgressIndicator()));
                                      },
                                    );
                                    deleteAssociate(
                                      snapshot.data![index].user!.userLoginId!,
                                    );
                                  },
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Dismissible(
                          key: Key('item'),
                          direction: DismissDirection.startToEnd,
                          confirmDismiss: (direction) async {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm"),
                                  content: const Text(
                                    "Are you want to delete this student?",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                color: Colors.transparent,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                          // _postQueue(
                                          //   snapshot
                                          //       .data![index].associate!.userId!
                                          //       .toString(),
                                          //   _selectedAssociate,
                                          //   snapshot.data![index].associate!
                                          //       .userNameCaller!
                                          //       .toString(),
                                          //   snapshot
                                          //       .data![index].user!.fullName!
                                          //       .toString(),
                                          // );
                                          deleteAssociate(
                                            snapshot.data![index].user!
                                                .userLoginId!,
                                          );
                                          setState(() {});
                                        },
                                        child: const Text("Yes")),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("No"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          movementDuration: Duration(seconds: 1),
                          behavior: HitTestBehavior.opaque,
                          background: Container(
                            color: Colors.red,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            padding: EdgeInsets.only(left: 20),
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
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: Card(
                              color: _isSelected[index] == true
                                  ? Colors.grey[200]
                                  : Colors.white,
                              elevation: _isSelected == true ? 5 : 10,
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                child: CheckboxListTile(
                                  value: _isSelected[index],
                                  onChanged: (value) {
                                    setState(() {
                                      _isSelected[index] = value!;
                                      _isSelected[index] == true
                                          ? _selectedAssociate.add(snapshot
                                              .data![index]
                                              .associate!
                                              .userIdAssociateNo!)
                                          : _selectedAssociate.remove(snapshot
                                              .data![index]
                                              .associate!
                                              .userIdAssociateNo!);
                                    });
                                    print(_selectedAssociate);
                                  },
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(10),
                                          width: 90,
                                          height: 80,
                                          child: Image.file(
                                            File(snapshot
                                                .data![index].user!.userPicture!
                                                .toString()),
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return CircleAvatar(
                                                child: Icon(Icons.person),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          snapshot.data![index].user!.fullName!
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            FutureBuilder<List<GetAllAssociateByUserIdModel>>(
                future: getAllAssociate(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(""),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Container(
                      child: Center(
                        child: Text(''),
                      ),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return Container(
                      child: Center(
                        child: Text(''),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(""),
                      ),
                    );
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Total",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          snapshot.data!.length.toString(),
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
        Get.to(() => ScanStudentNFCScreen());
      },
    );
  }

  // Future<void> _postQueue(
  //   String fllName,
  //   String associateId,
  //   String associateName,
  // ) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userLoginId = prefs.getString('userLoginId');
  //   print('userLoginId: $userLoginId');
  //   print('fullName: $fllName');
  //   print('associateId: $associateId');
  //   print('associateName: $associateName');

  //   final String url = 'http://gs1ksa.org:4000/api/PostQueue';
  //   final uri = Uri.parse(url);

  //   final headers = <String, String>{
  //     'Content-Type': 'application/json',
  //     'Host': 'gs1ksa.org',
  //   };

  //   final body = {
  //     "userId": userLoginId,
  //     "userIdAssociateNo": associateId,
  //     "userNameCaller": fullName,
  //     "userNameAssociate": associateName
  //   };

  //   final response =
  //       await http.post(uri, headers: headers, body: jsonEncode(body));

  //   if (response.statusCode == 200) {
  //     Navigator.pop(context);
  //     print("status code 200");
  //     Get.to(() => CallingScreen(
  //           name: associateName,
  //           userLoginId: associateId,
  //         ));
  //     Get.snackbar(
  //       "Calling ...",
  //       "$associateName",
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //       duration: Duration(seconds: 3),
  //     );
  //   } else {
  //     Navigator.pop(context);
  //     print("status code 400");
  //     Get.snackbar(
  //       "Error",
  //       "Something went wrong",
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       duration: Duration(seconds: 3),
  //     );
  //   }
  // }
}

import 'package:flutter/material.dart';
import 'package:grosshop/screens/AdminScreens/admin_home_screen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../../model/admin/get_all_newly_register_user.dart';

class NewlyRegisteredUsersScreen extends StatefulWidget {
  const NewlyRegisteredUsersScreen({super.key});

  @override
  State<NewlyRegisteredUsersScreen> createState() =>
      _NewlyRegisteredUsersScreenState();
}

class _NewlyRegisteredUsersScreenState
    extends State<NewlyRegisteredUsersScreen> {
  String msg = "";
  Future<GetAllNewlyRegisteredUsersModel> getAllNewlyRegisteredUsers() async {
    final String url = 'http://gs1ksa.org:4000/api/getAllInActiveUser';
    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        print('response is ${response.body}');
        return GetAllNewlyRegisteredUsersModel.fromJson(
            json.decode(response.body));
      } else if (response.statusCode == 400) {
        print('response is ${response.body}');

        setState(() {
          msg = "No User Found";
        });

        throw Exception('No User Found');
      } else {
        print('response is ${response.body}');
        throw Exception('No User Found');
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
        preferredSize: Size.fromHeight(100),
        child: AppBar(
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
                "New Users",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<GetAllNewlyRegisteredUsersModel>(
        future: getAllNewlyRegisteredUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                msg,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                shadowColor: Colors.green,
                margin: EdgeInsets.all(5),
                child: ListTile(
                  title: Text(
                    snapshot.data!.data![index].fullName!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email: " + snapshot.data!.data![index].emailId!,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              "Mobile: " +
                                  snapshot.data!.data![index].mobileNo!,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              snapshot.data!.data![index].userTypeIdNo! == "1"
                                  ? "User Type: Student"
                                  : snapshot.data!.data![index].userTypeIdNo! ==
                                          "2"
                                      ? "User Type: Staff"
                                      : snapshot.data!.data![index]
                                                  .userTypeIdNo! ==
                                              "3"
                                          ? "User Type: Reseller"
                                          : "User Type: Fetcher",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          title: Text(
                            "Approve User",
                            style: TextStyle(color: Colors.green),
                          ),
                          content: Text(
                              "Are you sure you want to approve this user?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                updateUserStatus(
                                    snapshot.data!.data![index].userId!);
                                Get.offAll(() => AdminHomeScreen());
                              },
                              child: Text("Yes"),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    child: Text(
                      "Approve",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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

  Future<void> updateUserStatus(String userId) async {
    final String url = "http://gs1ksa.org:4000/api/updateUserStatus";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    final body = {"userId": "$userId"};

    final response =
        await http.post(uri, headers: headers, body: jsonEncode(body));

    try {
      if (response.statusCode == 200) {
        print('response is ${response.body}');
        Get.snackbar(
          'Success',
          "User is approved",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          animationDuration: Duration(milliseconds: 500),
        );
      } else {
        print('response is ${response.body}');
        Get.snackbar(
          'Error',
          response.body,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

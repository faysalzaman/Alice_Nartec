import 'package:flutter/material.dart';
import 'package:grosshop/model/admin/get_all_registered_user_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class RegisteredUsersScreen extends StatefulWidget {
  const RegisteredUsersScreen({super.key});

  @override
  State<RegisteredUsersScreen> createState() => _RegisteredUsersScreenState();
}

class _RegisteredUsersScreenState extends State<RegisteredUsersScreen> {
  Future<List<GetAllRegisteredUserModel>> getAllRegisteredUser() async {
    final String url = "http://gs1ksa.org:4000/api/getAllUser";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        print('response is ${response.body}');

        var data = json.decode(response.body) as List;

        List<GetAllRegisteredUserModel> list =
            data.map((e) => GetAllRegisteredUserModel.fromJson(e)).toList();

        return list;
      } else {
        print('response is ${response.body}');
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          automaticallyImplyLeading: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.greenAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  "Registered Users",
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
      ),
      body: FutureBuilder<List<GetAllRegisteredUserModel>>(
        future: getAllRegisteredUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'something went wrong',
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

          return Card(
            elevation: 10,
            shadowColor: Colors.green,
            margin: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data![index].fullName!,
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
                      FittedBox(
                        child: Text(
                          "Email: " + snapshot.data![index].emailId!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          "Mobile: " + snapshot.data![index].mobileNo!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          snapshot.data![index].userTypeIdNo! == "1"
                              ? "User Type: Student"
                              : snapshot.data![index].userTypeIdNo! == "2"
                                  ? "User Type: Staff"
                                  : snapshot.data![index].userTypeIdNo! == "3"
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
                  trailing: FittedBox(
                    child: FittedBox(
                      child: Text(
                        "Id: " + snapshot.data![index].userLoginId!,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
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
    );
  }
}

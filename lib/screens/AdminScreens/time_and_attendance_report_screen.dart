import 'package:flutter/material.dart';

import '../../model/admin/gete_all_attendance_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class TimeAndAttendanceReportScreen extends StatefulWidget {
  const TimeAndAttendanceReportScreen({super.key});

  @override
  State<TimeAndAttendanceReportScreen> createState() =>
      _TimeAndAttendanceReportScreenState();
}

class _TimeAndAttendanceReportScreenState
    extends State<TimeAndAttendanceReportScreen> {
  Future<GetAllAttendanceModel> getAllAttendance() async {
    final String url = "  ";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Host": "gs1ksa.org",
      "Content-Type": "application/json",
    };

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        GetAllAttendanceModel attendance =
            GetAllAttendanceModel.fromJson(jsonData);

        return attendance;
      } else {
        throw Exception("No Data Found");
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to load data");
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
                  "Time And Attendance Report",
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
      ),
      body: FutureBuilder<GetAllAttendanceModel>(
        future: getAllAttendance(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
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
                "No data found",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return Card(
            elevation: 10,
            margin: EdgeInsets.all(10),
            shadowColor: Colors.green,
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "User Id: " + snapshot.data!.data![index].sId!,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Date and Time:\n" + snapshot.data!.data![index].dateTime!,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "Check " + snapshot.data!.data![index].typeofEntry!,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
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

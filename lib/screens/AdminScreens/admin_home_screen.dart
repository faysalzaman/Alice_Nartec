import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grosshop/screens/AdminScreens/products_approval_screen.dart';
import 'package:grosshop/screens/AdminScreens/registered_users_screen.dart';
import 'package:grosshop/screens/AdminScreens/time_and_attendance_report_screen.dart';
import 'package:grosshop/screens/AdminScreens/topup_payment_request_screen.dart';
import 'package:grosshop/screens/auth/sign_in_screen.dart';

import 'newly_registered_users_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(
                  "assets/images/icon/bgr-logo.png",
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                // Products Approval
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.amber,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ProductsApprovalScreen());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Products Approval",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Top Up Approval Screen
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.money,
                      size: 50,
                      color: Colors.cyan,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(() => TopUpPaymentRequestScreen());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                "Top Up Amount Approval",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Newly registered users
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.person_add,
                      size: 50,
                      color: Colors.green,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(() => NewlyRegisteredUsersScreen());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Newly Registered Users",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 10),
                // // Notifications Screen
                // Row(
                //   children: <Widget>[
                //     Icon(
                //       Icons.notifications,
                //       size: 50,
                //       color: Colors.red,
                //     ),
                //     Expanded(
                //       child: InkWell(
                //         onTap: () {},
                //         child: Container(
                //           height: 50,
                //           decoration: BoxDecoration(
                //             color: Colors.red,
                //             border: Border.all(
                //               color: Colors.black,
                //               width: 1,
                //             ),
                //             borderRadius: BorderRadius.only(
                //               topRight: Radius.circular(30),
                //               bottomRight: Radius.circular(30),
                //             ),
                //           ),
                //           child: Center(
                //             child: Text(
                //               "Notifications",
                //               style: TextStyle(
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.white,
                //               ),
                //               textAlign: TextAlign.center,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 10),
                // Registered Users
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.note,
                      size: 50,
                      color: Colors.blue,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(() => RegisteredUsersScreen());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Registered Users",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Time and Attendance Report Logs
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      size: 50,
                      color: Colors.purple,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(() => TimeAndAttendanceReportScreen());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                "  Time and Attendance Report Logs  ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Time and Attendance Report Logs
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.logout,
                      size: 50,
                      color: Colors.deepOrange,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.offAll(() => SignInScreen());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            padding: EdgeInsets.only(bottom: 5),
                            child: Center(
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
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
    );
  }
}

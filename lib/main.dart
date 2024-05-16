// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:get/get.dart';
import 'package:grosshop/screens/splash_screen.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();

  await Hive.openBox<bool>("stayLoggedIn");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: CustomColor.primaryColor,
        fontFamily: 'Poppins',
      ),
      home: SplashScreen(),
    );
  }
}

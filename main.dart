import 'dart:async';

import 'package:firebase_demo/view_page/Home_page.dart';
import 'package:firebase_demo/view_page/firstordatabase/Note_scrren.dart';
import 'package:firebase_demo/view_page/login_page.dart';
import 'package:firebase_demo/view_page/mobile_number/mobile_otpscreen.dart';
import 'package:firebase_demo/view_page/mobile_number/otp_scrren.dart';
import 'package:firebase_demo/view_page/signup_page.dart';
import 'package:firebase_demo/view_page/splsh_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.teal));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splsh_page(),
    );
  }
}

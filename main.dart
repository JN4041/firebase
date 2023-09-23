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

 //account
 //fileche
 // cupertino_icons: ^1.0.2
 //  sizer: ^2.0.15
 //  firebase_core: ^2.4.1
 //  firebase_auth: ^4.2.5
 //  pdf: ^3.10.1
 //  shared_preferences: ^2.0.17
 //  google_sign_in: ^5.4.3
 //  printing:
 //  flutter_otp_text_field: ^1.1.1
 //  cloud_firestore: ^4.3.1
 //  firebase_storage: ^11.0.10
 //  image_picker: ^0.8.6+1
 //  provider: ^6.0.5
 //  get: ^4.6.5

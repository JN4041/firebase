import 'dart:async';

import 'package:firebase_demo/view_page/Home_page.dart';
import 'package:firebase_demo/view_page/firstordatabase/Note_scrren.dart';
import 'package:firebase_demo/view_page/login_page.dart';
import 'package:firebase_demo/view_page/mobile_number/mobile_otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splsh_page extends StatefulWidget {
  const Splsh_page({Key? key}) : super(key: key);

  @override
  State<Splsh_page> createState() => _Splsh_pageState();
}

class _Splsh_pageState extends State<Splsh_page> {
  // String? _shar;
  String? _mob;
  Future getster() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final stor = sharedPreferences.getString('email');
    //final stor1 = sharedPreferences.getString('mobile');
    setState(() {
      // _shar = stor;
      _mob = stor;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // getster().whenComplete(() => Timer(
    //     Duration(seconds: 2),
    //     () => Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => _shar == null ? Login_page() : Home_page(),
    //         ))));
    getster().whenComplete(() => Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => _mob == null ? Login_page() : Note_page(),
            ))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.indigo.shade400,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Hello word",
            style: TextStyle(
                fontSize: width * 0.09,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}

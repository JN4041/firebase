import 'package:firebase_demo/firbase_servies/email_autho_servies.dart';
import 'package:firebase_demo/firbase_servies/google_singine_auth.dart';
import 'package:firebase_demo/view_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu_outlined),
        actions: [
          InkWell(
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove('mobile');
              // pref.remove('email');
              Emailauthogications.Logoutservies()
                  .then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login_page(),
                      )));
              Googleauth.Sigoutcat();
            },
            child: Icon(Icons.logout),
          )
        ],
        backgroundColor: Colors.blueGrey,
        title: Text("Frebase in"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Hello",
            style: TextStyle(
                fontSize: width * 0.1,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: heigth * 0.03,
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/view_page/Home_page.dart';
import 'package:firebase_demo/view_page/firstordatabase/Note_scrren.dart';
import 'package:firebase_demo/view_page/mobile_number/mobile_otpscreen.dart';
import 'package:firebase_demo/view_page/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Comman_tax_fild.dart';
import '../firbase_servies/email_autho_servies.dart';
import '../firbase_servies/google_singine_auth.dart';

class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  final globalekey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool select = true;
  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: globalekey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                "Login page",
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: width * 0.07,
                ),
              )),
              SizedBox(
                height: heigth * 0.05,
              ),
              Comman_tax(
                obscur: false,
                contro: email,
                hint: "Enter Email",
                perfix: Icon(Icons.email),
                onchage: (value) {
                  globalekey.currentState!.validate();
                },
                validator: (value) {
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!);
                  if (emailValid) {
                    return null;
                  } else {
                    return "plese valide email enter";
                  }
                },
                ontap: () {},
              ),
              SizedBox(
                height: heigth * 0.02,
              ),
              Comman_tax(
                obscur: select,
                hint: "Enter Password",
                sufix: InkWell(
                  onTap: () {
                    setState(() {
                      select = !select;
                    });
                  },
                  child: select == false
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                ),
                perfix: Icon(Icons.safety_check_sharp),
                contro: password,
                onchage: (value) {
                  globalekey.currentState!.validate();
                },
                validator: (value) {
                  final bool passwordvalid = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      .hasMatch(value!);

                  if (passwordvalid) {
                    return null;
                  } else {
                    return "password plese not valide";
                  }
                },
                ontap: () {},
              ),
              SizedBox(
                height: heigth * 0.05,
              ),
              MaterialButton(
                onPressed: () async {
                  if (globalekey.currentState!.validate()) {
                    final select = await Emailauthogications.Siginservies(
                        email: email.text, password: password.text);
                    if (select != null) {
                      SharedPreferences share =
                          await SharedPreferences.getInstance();
                      share
                          .setString('email', email.text)
                          .then((value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Note_page(),
                              )));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("email and password not regiter")));
                    }
                  }
                },
                color: Colors.indigo.shade300,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minWidth: width * 0.85,
                height: heigth * 0.065,
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.05),
                ),
              ),
              SizedBox(
                height: heigth * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: MaterialButton(
                  onPressed: () {
                    Googleauth.signInWithGoogle().then((value) async {
                      if (value != null) {
                        SharedPreferences shar =
                            await SharedPreferences.getInstance();
                        shar
                            .setString('email', email.text)
                            .then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Note_page(),
                                )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("User emaile account aledi")));
                      }
                    });
                  },
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: width * 0.85,
                  height: heigth * 0.065,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.g_mobiledata,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Text(
                        "Google with sigup",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.05),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: heigth * 0.02,
              ),
              //note:- notes app mate onli coment che..
              // MaterialButton(
              //   onPressed: () {
              //     Navigator.pushReplacement(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => Mobile_Scrren(),
              //         ));
              //   },
              //   color: Colors.teal.shade300,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10)),
              //   minWidth: width * 0.85,
              //   height: heigth * 0.065,
              //   child: Text(
              //     "Mobile number",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold,
              //         fontSize: width * 0.05),
              //   ),
              // ),
              // SizedBox(
              //   height: heigth * 0.02,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?"),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Regitations_page(),
                          ));
                    },
                    child: Text(
                      "Sigup",
                      style: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

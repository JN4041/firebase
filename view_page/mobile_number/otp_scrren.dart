import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/view_page/Home_page.dart';
import 'package:firebase_demo/view_page/mobile_number/mobile_otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Otp_scrren extends StatefulWidget {
  const Otp_scrren({
    Key? key,
  }) : super(key: key);

  @override
  State<Otp_scrren> createState() => _Otp_scrrenState();
}

class _Otp_scrrenState extends State<Otp_scrren> {
  String? otp;
  Future verifiedotp() async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: Verifiedotp!, smsCode: otp.toString());
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home_page(),
          ));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invelid otp")));
      // TODO
    }
  }

  String code = "i am agre with code";

  int start = 30;
  bool wati = false;
  String name = "Resend";
  void onchage() {
    const _onchag = Duration(seconds: 1);
    Timer _timer = Timer.periodic(_onchag, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wati = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    onchage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: wati
                      ? null
                      : () {
                          onchage();
                          setState(() {
                            start = 30;
                            wati = true;
                            name = "Resent";
                          });
                        },
                  child: Text(
                    name,
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: heigth * 0.04,
          ),
          Center(
              child: Text(
            "OTP page",
            style: TextStyle(
              color: Colors.indigo,
              fontSize: width * 0.07,
            ),
          )),
          SizedBox(
            height: heigth * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: OtpTextField(
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              onCodeChanged: (code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                setState(() {
                  otp = verificationCode;
                });
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    });
              }, // end onSubmit
            ),
          ),
          SizedBox(
            height: heigth * 0.06,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "send otp agine ",
                style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold)),
            TextSpan(
                text: "00:$start",
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.bold)),
            TextSpan(
                text: "secon ",
                style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold)),
          ])),
          SizedBox(
            height: heigth * 0.02,
          ),
          MaterialButton(
            onPressed: () {
              verifiedotp();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home_page(),
                  ));
            },
            color: Colors.indigo.shade300,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minWidth: width * 0.85,
            height: heigth * 0.065,
            child: Text(
              "Submit",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.05),
            ),
          )
        ],
      ),
    );
  }
}

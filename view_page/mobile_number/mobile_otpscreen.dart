import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/view_page/Home_page.dart';
import 'package:firebase_demo/view_page/mobile_number/otp_scrren.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Comman_tax_fild.dart';

String? Verifiedotp;

class Mobile_Scrren extends StatefulWidget {
  const Mobile_Scrren({Key? key}) : super(key: key);

  @override
  State<Mobile_Scrren> createState() => _Mobile_ScrrenState();
}

class _Mobile_ScrrenState extends State<Mobile_Scrren> {
  Future sendotp() async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${moblie.text}",
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message.toString())));
      },
      codeSent: (verificationId, forceResendingToken) {
        setState(() {
          Verifiedotp = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  final global = GlobalKey<FormState>();
  TextEditingController moblie = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: global,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                "Mobile page",
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: width * 0.07,
                ),
              )),
              SizedBox(
                height: heigth * 0.04,
              ),
              Comman_tax(
                contro: moblie,
                ontap: () {},
                obscur: false,
                leg: 10,
                taxinput: TextInputType.number,
                hint: "Enter Mobile number",
                onchage: (value) {
                  global.currentState!.validate();
                },
                validator: (value) {
                  if (value!.length < 10) {
                    return "Enter 10 digites";
                  }
                },
              ),
              SizedBox(
                height: heigth * 0.03,
              ),
              MaterialButton(
                onPressed: () async {
                  if (global.currentState!.validate()) {
                    SharedPreferences shar =
                        await SharedPreferences.getInstance();
                    shar.setString('mobile', moblie.text);
                    sendotp().then((value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Otp_scrren(),
                        )));
                  }
                },
                color: Colors.indigo.shade300,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minWidth: width * 0.85,
                height: heigth * 0.065,
                child: Text(
                  "Send OTP",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.05),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

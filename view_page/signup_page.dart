import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/view_page/Home_page.dart';
import 'package:firebase_demo/view_page/login_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Comman_tax_fild.dart';
import '../firbase_servies/email_autho_servies.dart';
import '../firbase_servies/google_singine_auth.dart';
import 'firstordatabase/Note_scrren.dart';

class Regitations_page extends StatefulWidget {
  const Regitations_page({Key? key}) : super(key: key);

  @override
  State<Regitations_page> createState() => _Regitations_pageState();
}

class _Regitations_pageState extends State<Regitations_page> {
  final globalekey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool select = true;
  File? image;
  ImagePicker imagePicker = ImagePicker();
  void imagepick(ImageSource imageSource) async {
    final file = await imagePicker.pickImage(source: imageSource);
    if (file != null) {
      setState(() {
        image = File(file.path);
      });
    }
  }

  Future<String?> uplodaimage() async {
    try {
      await FirebaseStorage.instance.ref("${email.text}").putFile(image!);
      final url =
          await FirebaseStorage.instance.ref("${email.text}").getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      print("firbase====>${e.message}");
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: globalekey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    "Signup page",
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: width * 0.07,
                    ),
                  )),
                  SizedBox(
                    height: heigth * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Upload image"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                imagepick(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              child: Text("camera"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                imagepick(ImageSource.gallery);
                              },
                              child: Text("Gallry"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      height: heigth * 0.23,
                      width: width * 0.5,
                      child: ClipOval(
                        child: image == null
                            ? Icon(Icons.camera)
                            : Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: heigth * 0.02,
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
                        final share1 = Emailauthogications.Sigupservies(
                                email: email.text, password: password.text)
                            .then((value) async {
                          if (value != null) {
                            final imageurl = await uplodaimage();
                            FirebaseFirestore.instance
                                .collection("user")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              "email": email.text,
                              "imageurl": imageurl
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Note_page(),
                                ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("User emaile account aledi")));
                          }
                        });
                      }
                    },
                    color: Colors.indigo.shade300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minWidth: width * 0.85,
                    height: heigth * 0.065,
                    child: Text(
                      "Signup",
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
                        Googleauth.signInWithGoogle().then((
                            value) async {
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
                                content:
                                    Text("User email account alredy.......")));
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Aready have an account ?"),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login_page(),
                              ));
                        },
                        child: Text(
                          "Singin ",
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

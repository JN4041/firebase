import 'package:firebase_auth/firebase_auth.dart';

class Emailauthogications {
  static Future<UserCredential?> Sigupservies(
      {String? email, String? password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Sigup erro>>${e.message}");

      // TODOpSeHIVfe80YkvmU9yyEP8JHzEt03
    }
  }

  static Future<UserCredential?> Siginservies(
      {String? email, String? password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Sigup erro>>${e.message}");

      // TODO
    }
  }

  static Future Logoutservies() async {
    try {
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print("Logout>>${e.message}");
      // TODO
    }
  }
}

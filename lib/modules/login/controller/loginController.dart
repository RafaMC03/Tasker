import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  login(String email, String senha, VoidCallback sucesso,
      Function(String err) erro) async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);
      sucesso();
    } catch (e) {
      erro(e.toString());
      print(e);
    }
  }
}

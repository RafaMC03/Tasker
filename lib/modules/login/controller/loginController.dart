import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  final email = TextEditingController();
  final senha = TextEditingController();

  login(VoidCallback sucesso,
      Function(String err) erro) async {
    try {
      if (email.text.isEmpty || senha.text.isEmpty) {
        throw Exception('Campos obrigatórios não informados!');
      }

      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text.trim(), password: senha.text);
      sucesso();
    } catch (e) {
      String erroMessage = e.toString();
      if (e.toString().contains('Exception:')) {
        erroMessage = e.toString().substring(11);
      }
      erro(erroMessage);
      return e;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CadastroController extends ChangeNotifier {
  criarConta(String email, String senha, String nome, VoidCallback sucesso,
      Function(String e) erro) async {
    try {
      var result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: senha);

      if (result.user != null) {
        await result.user!.updateDisplayName(nome).then((value) => sucesso());
      }
    } catch (e) {
      print(e);
      erro(e.toString());
      return e;
    }
  }
}

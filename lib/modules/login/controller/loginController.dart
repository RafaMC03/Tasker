import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  final email = TextEditingController();
  final senha = TextEditingController();

  login(VoidCallback sucesso, Function(String err) erro) async {
    try {
      if (email.text.isEmpty || senha.text.isEmpty) {
        throw Exception('Campos obrigatórios não informados!');
      }

      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: senha.text);
      sucesso();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "invalid-email":
          erro("Email inválido");
          break;
        case "wrong-password":
          erro("Senha inválida");
          break;
        case "user-not-found":
          erro("Usuário não encontrado");
          break;
        case "user-disabled":
          erro("Usuário desabilitado");
          break;
      }
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

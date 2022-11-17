import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasker/modules/cadastro/models/usuario_model.dart';

class CadastroController extends ChangeNotifier {
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();

  criarConta(VoidCallback sucesso, Function(String e) erro) async {
    try {
      var usuario = Usuario(nome: nome.text.trim(), email: email.text.trim());
      usuario.isValid();

      if (senha.text.isEmpty) {
        throw Exception('Campos obrigatórios não informados!');
      }

      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: senha.text);

      if (result.user != null) {
        await result.user!
            .updateDisplayName(nome.text)
            .then((value) => sucesso());
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "invalid-email":
          erro("Email inválido");
          break;
        case "weak-password":
          erro("Senha inválida/insegura");
          break;
        case "email-already-in-use":
          erro("Esse email já está em uso");
          break;
      }
    } catch (e) {
      print(e);
      String erroMessage = e.toString();
      if (e.toString().contains('Exception:')) {
        erroMessage = e.toString().substring(11);
      }
      erro(erroMessage);
      return e;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CadastroTarefasController extends ChangeNotifier {
  final titulo = TextEditingController();
  final descricao = TextEditingController();
  final data = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? dataTime;
  final FirebaseFirestore _banco = FirebaseFirestore.instance;

  set setData(DateTime data) {
    dataTime = data;
    notifyListeners();
  }

  Future<void> criarTarefa() async {
    try {
      await _banco
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("tarefas")
          .doc()
          .set({
        "titulo": titulo.text,
        "descricao": descricao.text,
        "data": Timestamp.fromDate(dataTime!)
      });
      titulo.text = "";
      data.text = "";
      dataTime = null;
      descricao.text = "";
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}

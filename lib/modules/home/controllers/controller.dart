import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasker/modules/home/models/tarefa_model.dart';

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

  Future<bool?> criarTarefa() async {
    if (formKey.currentState!.validate()) {
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
        return true;
      } on Exception catch (e) {
        debugPrint(e.toString());
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> excluirTarefa(TarefaAgendada tarefa) async {
    try {
      await _banco
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("tarefas")
          .doc(tarefa.id)
          .delete();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> alterarTarefa(TarefaAgendada tarefa) async {
    try {
      await _banco
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("tarefas")
          .doc(tarefa.id)
          .update({
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

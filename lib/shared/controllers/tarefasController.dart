import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasker/modules/home/models/tarefa_model.dart';
import 'package:intl/intl.dart';

class TarefasController extends ChangeNotifier {
  List<TarefaAgendada> tarefas = [];
  Map<String, List<TarefaAgendada>> tarefasGroup = {};
  Future<List<TarefaAgendada>> getTarefasFut = Future.value([]);
  final FirebaseFirestore _banco = FirebaseFirestore.instance;

  getTarefas() {
    getTarefasFut = _getTarefas();
  }

  Future<List<TarefaAgendada>> _getTarefas() async {
    var resposta = await _banco
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("tarefas")
        .get();
    tarefas.clear();
    tarefasGroup.clear();
    for (var tarefa in resposta.docs) {
      var tarefaData = tarefa.data();
      tarefaData["id"] = tarefa.id;
      TarefaAgendada tarefaAg = TarefaAgendada.fromMap(tarefaData);
      tarefas.add(tarefaAg);

      String format = DateFormat('dd/MM/yyyy').format(tarefaAg.data);
      var list = tarefasGroup[format]?.toList() ?? [];
      list.add(tarefaAg);
      tarefasGroup[format] = list;
    }
    debugPrint(tarefas.toString());

    notifyListeners();
    return tarefas;
  }
}

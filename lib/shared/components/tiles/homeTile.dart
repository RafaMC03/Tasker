import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tasker/modules/home/controllers/controller.dart';
import 'package:tasker/modules/home/models/tarefa_model.dart';
import 'package:intl/intl.dart';
import 'package:tasker/modules/home/pages/alterarTarefas.dart';
import 'package:tasker/modules/home/pages/home.dart';
import 'package:tasker/shared/controllers/tarefasController.dart';

class HomeTileTarefa extends StatefulWidget {
  HomeTileTarefa(this.tarefa, {Key? key}) : super(key: key);
  TarefaAgendada tarefa;
  @override
  State<HomeTileTarefa> createState() => _HomeTileTarefaState();
}

class _HomeTileTarefaState extends State<HomeTileTarefa> {
  int _tamanhoLinha = 1;
  bool _expandido = false;
  DateFormat diaFormat = DateFormat("dd MMM");
  String diaFormatado = "";
  final _controller = CadastroTarefasController();

  @override
  void initState() {
    super.initState();
    var mesStr = "";
    var dataSplit = diaFormat.format(widget.tarefa.data).split(" ");
    switch (widget.tarefa.data.month) {
      case 1:
        mesStr = "Jan";
        break;
      case 2:
        mesStr = "Fev";
        break;
      case 3:
        mesStr = "Mar";
        break;
      case 4:
        mesStr = "Abr";
        break;
      case 5:
        mesStr = "Mai";
        break;
      case 6:
        mesStr = "Jun";
        break;
      case 7:
        mesStr = "Jul";
        break;
      case 8:
        mesStr = "Ago";
        break;
      case 9:
        mesStr = "Set";
        break;
      case 10:
        mesStr = "Out";
        break;
      case 11:
        mesStr = "Nov";
        break;
      case 12:
        mesStr = "Dez";
        break;
    }
    dataSplit[1] = mesStr;
    diaFormatado = dataSplit.join(" ");
  }

  @override
  Widget build(BuildContext context) {
    var tarefas = Provider.of<TarefasController>(context);

    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.027),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.92,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: const Color.fromARGB(255, 12, 175, 158), width: 2)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ExpansionTile(
            backgroundColor: Colors.white,
            onExpansionChanged: (expandido) {
              setState(() {
                _expandido = expandido;
                if (_tamanhoLinha < 20) {
                  _tamanhoLinha = 20;
                } else {
                  _tamanhoLinha = 1;
                }
              });
            },
            trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    diaFormatado,
                    //'30 nov',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 12, 175, 158)),
                  ),
                  Text(
                    'Expandir',
                    style: TextStyle(
                        color: _expandido == false
                            ? const Color.fromARGB(255, 12, 175, 158)
                            : const Color.fromARGB(0, 0, 0, 0)),
                  ),
                ]),
            subtitle: Text(
              widget.tarefa.descricao,
              //'Terminar home page',
              maxLines: _tamanhoLinha, overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color.fromARGB(255, 133, 129, 129)),
            ),
            title: Text(
              widget.tarefa.titulo,
              //'Sprint 3 - PSI',
              style: const TextStyle(
                  color: Color.fromARGB(255, 12, 175, 158),
                  fontWeight: FontWeight.bold),
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, MediaQuery.of(context).size.width * 0.04, 0),
                      child: TextButton(
                          child: const Text("Alterar",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 12, 175, 158))),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: altTarefas(widget.tarefa),
                                  duration: const Duration(milliseconds: 300)),
                            );
                          })),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, MediaQuery.of(context).size.width * 0.04, 0),
                      child: TextButton(
                          child: const Text("Excluir",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 12, 175, 158))),
                          onPressed: () async {
                            var loading = BotToast.showLoading();
                            await _controller.excluirTarefa(widget.tarefa);
                            tarefas.getTarefas();
                            loading();
                          }))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tasker/shared/components/botoes/botao_componente.dart';
import 'package:tasker/shared/components/campo_form/campo_form_componente.dart';

final controllerTitulo = TextEditingController();

class cadTarefas extends StatefulWidget {
  const cadTarefas({super.key});

  @override
  State<cadTarefas> createState() => _cadTarefasState();
}

class _cadTarefasState extends State<cadTarefas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova tarefa'),
        backgroundColor: Color.fromARGB(255, 12, 175, 158),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.local_offer_outlined,
                    color: Color.fromARGB(255, 133, 129, 129),
                  )),
              Expanded(
                flex: 10,
                child: TextFormField(
                  decoration: InputDecoration(
                      label: Text(
                    'Título',
                    style: TextStyle(color: Color.fromARGB(255, 133, 129, 129)),
                  )),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.text_snippet_outlined,
                    color: Color.fromARGB(255, 133, 129, 129),
                  )),
              Expanded(
                flex: 10,
                child: TextFormField(
                  decoration: InputDecoration(
                      label: Text(
                    'Descrição',
                    style: TextStyle(color: Color.fromARGB(255, 133, 129, 129)),
                  )),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.calendar_today_outlined,
                    color: Color.fromARGB(255, 133, 129, 129),
                  )),
              Expanded(
                flex: 10,
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text(
                      'Data de prazo',
                      style:
                          TextStyle(color: Color.fromARGB(255, 133, 129, 129)),
                    ),
                    suffixIcon: Container(
                        margin: EdgeInsets.only(left: 4),
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color:
                                        Color.fromARGB(255, 133, 129, 129)))),
                        child: IconButton(
                            onPressed: (() {

                            }),
                            icon: Icon(Icons.calendar_today_outlined))),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: BotaoComponente(
                  texto: 'Cadastrar tarefa', 
                  corFundo: Color.fromARGB(255, 12, 175, 158), 
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  corTexto: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}

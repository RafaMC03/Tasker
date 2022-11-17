import 'package:flutter/material.dart';
import 'package:tasker/modules/home/controllers/controller.dart';
import 'package:tasker/shared/components/botoes/botao_componente.dart';
import 'package:tasker/shared/components/campo_form/campo_form_tarefas.dart';

final controllerTitulo = TextEditingController();

class cadTarefas extends StatefulWidget {
  const cadTarefas({super.key});

  @override
  State<cadTarefas> createState() => _cadTarefasState();
}

class _cadTarefasState extends State<cadTarefas> {
  final _controller = CadastroTarefasController();
  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova tarefa'),
          backgroundColor: const Color.fromARGB(255, 12, 175, 158),
        ),
        body: ListView(
          children: [
            Theme(
              data: Theme.of(context).copyWith(),
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Form(
                  child: Column(
                    children: [
                      CampoFormTarefas(
                        label: 'Título',
                        icone: Icons.local_offer_outlined,
                        node: _focusNodes[0],
                        isData: false,
                        controller: _controller.titulo,
                      ),
                      CampoFormTarefas(
                        label: 'Descrição',
                        icone: Icons.text_snippet_outlined,
                        node: _focusNodes[1],
                        isData: false,
                        controller: _controller.descricao,
                      ),
                      CampoFormTarefas(
                        label: 'Data de Prazo',
                        icone: Icons.calendar_today_outlined,
                        node: _focusNodes[2],
                        isData: true,
                        controller: _controller.data,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: BotaoComponente(
                      texto: 'Cadastrar tarefa',
                      corFundo: const Color.fromARGB(255, 12, 175, 158),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      corTexto: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

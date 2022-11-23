import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
    Provider.of<CadastroTarefasController>(context, listen: false)
        .titulo
        .clear();
    Provider.of<CadastroTarefasController>(context, listen: false).data.clear();
    Provider.of<CadastroTarefasController>(context, listen: false).dataTime =
        null;
    Provider.of<CadastroTarefasController>(context, listen: false)
        .descricao
        .clear();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CadastroTarefasController>(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova tarefa'),
          backgroundColor: const Color.fromARGB(255, 12, 175, 158),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
        body: ListView(
          children: [
            Theme(
              data: Theme.of(context).copyWith(),
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      CampoFormTarefas(
                        label: 'Título',
                        icone: Icons.local_offer_outlined,
                        node: _focusNodes[0],
                        isData: false,
                        controller: controller.titulo,
                      ),
                      CampoFormTarefas(
                        label: 'Descrição',
                        icone: Icons.text_snippet_outlined,
                        node: _focusNodes[1],
                        isData: false,
                        controller: controller.descricao,
                      ),
                      CampoFormTarefas(
                        label: 'Data de Prazo',
                        icone: Icons.calendar_today_outlined,
                        node: _focusNodes[2],
                        isData: true,
                        controller: controller.data,
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
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          var loading = BotToast.showLoading();
                          var response = await controller.criarTarefa();
                          loading();
                          if (response ?? false) {
                            Navigator.pop(context, true);
                          }
                        }
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

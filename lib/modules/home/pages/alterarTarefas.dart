import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/modules/home/controllers/controller.dart';
import 'package:tasker/modules/home/models/tarefa_model.dart';
import 'package:tasker/shared/components/botoes/botao_componente.dart';
import 'package:tasker/shared/components/campo_form/campo_form_tarefas.dart';
import 'package:intl/intl.dart';

final controllerTitulo = TextEditingController();

class altTarefas extends StatefulWidget {
  altTarefas(this.tarefa, {super.key});
  TarefaAgendada tarefa;

  @override
  State<altTarefas> createState() => _altTarefasState();
}

class _altTarefasState extends State<altTarefas> {
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<CadastroTarefasController>(context, listen: false).titulo.text =
        widget.tarefa.titulo;
    Provider.of<CadastroTarefasController>(context, listen: false).data.text =
        DateFormat('dd/MM/yyyy').format(widget.tarefa.data);
    Provider.of<CadastroTarefasController>(context, listen: false).dataTime =
        widget.tarefa.data;
    Provider.of<CadastroTarefasController>(context, listen: false)
        .descricao
        .text = widget.tarefa.descricao;

    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CadastroTarefasController>(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Alterar tarefa'),
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
                        label: 'T??tulo',
                        icone: Icons.local_offer_outlined,
                        node: _focusNodes[0],
                        isData: false,
                        controller: controller.titulo,
                      ),
                      CampoFormTarefas(
                        label: 'Descri????o',
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
                      texto: 'Alterar tarefa',
                      corFundo: const Color.fromARGB(255, 12, 175, 158),
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          var loading = BotToast.showLoading();
                          var response = await controller.alterarTarefa(widget.tarefa);
                          loading();
                          if (response ?? false) {
                            Navigator.pop(context, true);
                          }
                        }
                        if (!mounted) return;                        
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

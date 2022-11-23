import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tasker/modules/home/controllers/controller.dart';

class CampoFormTarefas extends StatefulWidget {
  final String label;
  final IconData icone;
  final FocusNode node;
  final bool isData;
  final TextEditingController controller;

  const CampoFormTarefas(
      {super.key,
      required this.label,
      required this.icone,
      required this.node,
      required this.isData,
      required this.controller});

  @override
  State<CampoFormTarefas> createState() => _CampoFormTarefasState();
}

class _CampoFormTarefasState extends State<CampoFormTarefas> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Icon(
                  widget.icone,
                  color: widget.node.hasFocus
                      ? const Color.fromARGB(255, 12, 175, 158)
                      : const Color.fromARGB(255, 133, 129, 129),
                ),
              )),
          Expanded(
            flex: 10,
            child: TextFormField(
                onTap: widget.isData
                    ? (() async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          locale: const Locale('pt', 'BR'),
                          initialDate:
                              DateTime.parse(widget.controller.text != ''
                                  ? '${widget.controller.text.split('/')[2]}'
                                      '-'
                                      '${widget.controller.text.split('/')[1]}'
                                      '-'
                                      '${widget.controller.text.split('/')[0]}'
                                  : DateTime.now().toString()),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                          builder: ((context, child) {
                            return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor:
                                      const Color.fromARGB(255, 12, 175, 158),
                                  colorScheme: const ColorScheme.light(
                                      onPrimary: Colors.black,
                                      primary:
                                          Color.fromARGB(255, 12, 175, 158)),
                                  buttonTheme: const ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                ),
                                child: child!);
                          }),
                        );
                        setState(() {
                          Provider.of<CadastroTarefasController>(context,
                                  listen: false)
                              .setData = pickedDate ?? DateTime.now();
                          widget.controller.text = DateFormat('dd/MM/yyyy')
                              .format(pickedDate ?? DateTime.now());
                        });
                      })
                    : null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Preencha os dados";
                  }
                  return null;
                },
                readOnly: widget.isData,
                controller: widget.controller,
                focusNode: widget.node,
                cursorColor: const Color.fromARGB(255, 12, 175, 158),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 133, 129, 129)),
                  floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                      (Set<MaterialState> states) {
                    final Color color = states.contains(MaterialState.error)
                        ? Theme.of(context).errorColor
                        : const Color.fromARGB(255, 12, 175, 158);
                    return TextStyle(color: color);
                  }),
                  alignLabelWithHint: true,
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 12, 175, 158), width: 2)),
                  label: Text(
                    widget.label,
                  ),
                  suffixIcon: widget.isData
                      ? Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              VerticalDivider(
                                thickness: 1,
                                endIndent: 15,
                                indent: 15,
                                color: widget.node.hasFocus
                                    ? const Color.fromARGB(255, 12, 175, 158)
                                    : const Color.fromARGB(255, 133, 129, 129),
                              ),
                              IconButton(
                                  onPressed: (() async {
                                    final DateTime? pickedDate =
                                        await showDatePicker(
                                      context: context,
                                      locale: const Locale('pt', 'BR'),
                                      initialDate: DateTime.parse(widget
                                                  .controller.text !=
                                              ''
                                          ? '${widget.controller.text.split('/')[2]}'
                                              '-'
                                              '${widget.controller.text.split('/')[1]}'
                                              '-'
                                              '${widget.controller.text.split('/')[0]}'
                                          : DateTime.now().toString()),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 365)),
                                      builder: ((context, child) {
                                        return Theme(
                                            data: ThemeData.light().copyWith(
                                              primaryColor:
                                                  const Color.fromARGB(
                                                      255, 12, 175, 158),
                                              colorScheme:
                                                  const ColorScheme.light(
                                                      onPrimary: Colors.black,
                                                      primary: Color.fromARGB(
                                                          255, 12, 175, 158)),
                                              buttonTheme:
                                                  const ButtonThemeData(
                                                      textTheme: ButtonTextTheme
                                                          .primary),
                                            ),
                                            child: child!);
                                      }),
                                    );
                                    setState(() {
                                      Provider.of<CadastroTarefasController>(
                                                  context,
                                                  listen: false)
                                              .setData =
                                          pickedDate ?? DateTime.now();
                                      widget.controller.text =
                                          DateFormat('dd/MM/yyyy').format(
                                              pickedDate ?? DateTime.now());
                                    });
                                  }),
                                  icon: Icon(
                                    Icons.calendar_today_outlined,
                                    color: widget.node.hasFocus
                                        ? const Color.fromARGB(
                                            255, 12, 175, 158)
                                        : const Color.fromARGB(
                                            255, 133, 129, 129),
                                  ))
                            ],
                          ),
                        )
                      : null,
                )),
          ),
        ],
      ),
    );
  }
}

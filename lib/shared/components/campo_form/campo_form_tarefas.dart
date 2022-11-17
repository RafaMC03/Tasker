import 'package:flutter/material.dart';

class CampoFormTarefas extends StatefulWidget {
  final String label;
  final IconData icone;
  final FocusNode node;
  final bool isData;
  final TextEditingController controller;

  CampoFormTarefas(
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
    return Container(
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
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              VerticalDivider(
                                thickness: 1,
                                endIndent: 15,
                                indent: 15,
                                color: widget.node.hasFocus
                                        ? const Color.fromARGB(255, 12, 175, 158)
                                        : const Color.fromARGB(
                                            255, 133, 129, 129),
                              ),
                              IconButton(
                                  onPressed: (() {
                                    showDatePicker(
                                        context: context,
                                        locale: const Locale('pt', 'BR'),
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 30)),
                                        builder: ((context, child) {
                                          return Theme(
                                              data: ThemeData.light().copyWith(
                                                primaryColor:
                                                    const Color.fromARGB(
                                                        255, 12, 175, 158),
                                                colorScheme: const ColorScheme.light(
                                                    onPrimary: Colors.black,
                                                    primary: Color.fromARGB(
                                                        255, 12, 175, 158)),
                                                buttonTheme: const ButtonThemeData(
                                                    textTheme:
                                                        ButtonTextTheme.primary),
                                              ),
                                              child: child!);
                                        }));
                                  }),
                                  icon: Icon(
                                    Icons.calendar_today_outlined,
                                    color: widget.node.hasFocus
                                        ? const Color.fromARGB(255, 12, 175, 158)
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

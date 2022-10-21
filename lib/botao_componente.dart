import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class botaocomponente extends StatefulWidget {
  final String texto;
  final Color corfundo;
  final Color? corborda;
  final Function() onpressed;
  final Color cortexto;

  const botaocomponente(
      {Key? key,
      required this.texto,
      required this.corfundo,
      this.corborda,
      required this.onpressed,
      required this.cortexto})
      : super(key: key);

  @override
  State<botaocomponente> createState() => _botaocomponenteState();
}

class _botaocomponenteState extends State<botaocomponente> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: 300,
        child: ElevatedButton(
          onPressed: widget.onpressed,
          child: Text(
            widget.texto,
            style: TextStyle(
              color: widget.cortexto,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: widget.corfundo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: widget.corborda ?? widget.corfundo),
            ),
          ),
        ));
  }
}

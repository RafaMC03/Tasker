import 'package:flutter/material.dart';

class BotaoComponente extends StatefulWidget {
  final String texto;
  final Color corFundo;
  final Color? corBorda;
  final Function() onPressed;
  final Color corTexto;
  final Color? corSplash;

  const BotaoComponente(
      {Key? key,
      required this.texto,
      required this.corFundo,
      this.corBorda,
      required this.onPressed,
      required this.corTexto, 
      this.corSplash})
      : super(key: key);

  @override
  State<BotaoComponente> createState() => _BotaoComponenteState();
}

class _BotaoComponenteState extends State<BotaoComponente> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.055,
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            onPrimary: widget.corSplash,
            elevation: 15,
            shadowColor: Colors.black,
            primary: widget.corFundo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: widget.corBorda ?? widget.corFundo),
            ),
          ),
          child: Text(
            widget.texto,
            style: TextStyle(
              color: widget.corTexto,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ));
  }
}

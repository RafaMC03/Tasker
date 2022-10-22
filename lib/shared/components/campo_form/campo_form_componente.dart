import 'package:flutter/material.dart';

class CampoForm extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icone;
  final bool senha;

  const CampoForm({Key? key, required this.controller, required this.label, required this.icone, required this.senha}) : super(key: key);

  @override
  State<CampoForm> createState() => _CampoFormState();
}

class _CampoFormState extends State<CampoForm> {
  bool password = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey,
        primarySwatch: Colors.grey
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(widget.label, style: const TextStyle(color: Colors.grey),)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.senha == true ?password :false,
              obscuringCharacter: '●',
              style: widget.senha ? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold) : null,
              decoration: InputDecoration(
                suffixIcon: 
                widget.senha == true
                ? Align(
                  alignment: Alignment.bottomRight,
                   widthFactor: 1,
                  heightFactor: 1,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        password = !password;
                      });
                    },
                    icon: password == true
                        ? const Icon(Icons.visibility_off, color: const Color.fromARGB(255, 12, 175, 158), size: 24,)
                        : const Icon(Icons.visibility, color: const Color.fromARGB(255, 12, 175, 158), size: 24,),),
                )
                      : Align(
                   alignment: Alignment.bottomRight,
                   widthFactor: 1,
                  heightFactor: 1,
                  child: Icon(widget.icone, color: const Color.fromARGB(255, 12, 175, 158), size: 24,)),
                isDense: true,
                contentPadding: const EdgeInsets.fromLTRB(0, 4, 0,0),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   widthFactor: 1,
                //   heightFactor: 1,
                //   child: Icon(widget.icone, color: const Color.fromARGB(255, 12, 175, 158), size: 28,))
              ),
            ),
          ),
        ],
      ),
    );
  }
}
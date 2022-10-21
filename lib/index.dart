import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasker/botao_componente.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
              0.1,
              1
            ],
                colors: [
              Color.fromARGB(255, 12, 175, 158),
              Color.fromARGB(255, 22, 122, 154),
            ])),
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'TASKER',
                    style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 0.4),
                  ),
                  Text(
                    'Registro de tarefas',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
              botaocomponente(
                    texto: 'Entrar', 
                    corfundo: Colors.white, 
                    onpressed: () {}, 
                    cortexto: Color.fromARGB(255, 22, 122, 154),
                    ),
                  Text('Não tem uma conta?',
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),
                  botaocomponente(
                    texto: 'Cadastrar', 
                    corfundo: Color.fromARGB(255, 22, 122, 154), 
                    onpressed: () {}, 
                    cortexto: Colors.white,
                    corborda: Colors.white,
                    )
            ],
          ),
        ),
      ),
    );
  }
}

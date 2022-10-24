import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tasker/modules/cadastro/pages/cadastro.dart';
import 'package:tasker/modules/login/pages/login.dart';
import 'package:tasker/shared/components/botoes/botao_componente.dart';

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
        decoration: const BoxDecoration(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'TASKER',
                      style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 0.4),
                    ),
                    Text(
                      'Registro de Tarefas',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BotaoComponente(
                        texto: 'Entrar',
                        corFundo: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: LoginPage(),
                                duration: Duration(milliseconds: 600)
                              ),
                          );
                        },
                        corTexto: const Color.fromARGB(255, 22, 122, 154),
                        corSplash: const Color.fromARGB(255, 22, 122, 154),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 13.0),
                        child: Text(
                          'Não tem uma conta?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      BotaoComponente(
                        texto: 'Cadastrar',
                        corFundo: const Color.fromARGB(255, 22, 122, 154),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: CadastroPage(),
                                duration: Duration(milliseconds: 600)
                              ),
                          );
                        },
                        corTexto: Colors.white,
                        corBorda: Colors.white,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tasker/shared/components/botoes/botao_componente.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                          onPressed: () {}, 
                          corTexto: const Color.fromARGB(255, 22, 122, 154),
                          corSplash: const Color.fromARGB(255, 22, 122, 154),
                          ),
                        const Padding(
                          padding: EdgeInsets.only(top: 13.0),
                          child: Text('Não tem uma conta?',
                          style: TextStyle(
                            color: Colors.white
                          ),
                          ),
                        ),
                        BotaoComponente(
                          texto: 'Cadastrar', 
                          corFundo: const Color.fromARGB(255, 22, 122, 154), 
                          onPressed: () {}, 
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
    );
  }
}
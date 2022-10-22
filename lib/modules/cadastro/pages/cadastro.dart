import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tasker/shared/components/botoes/botao_componente.dart';
import 'package:tasker/shared/components/campo_form/campo_form_componente.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 241, 241, 241)),
        child: Center(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 150.0),
                    child: Text(
                      'TASKER',
                      style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 12, 175, 158),
                          height: 0.4),
                    ),
                  ),
                  Text(
                    'Registro de Tarefas',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 12, 175, 158)),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
                    child: Form(
                      child: Column(
                        children: [
                          const FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              "Crie uma conta",
                              style: TextStyle(
                                  wordSpacing: 4,
                                  letterSpacing: 2,
                                  fontSize: 24,
                                  color: Color.fromARGB(255, 12, 175, 158),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(10)),
                          CampoForm(
                            label: 'Nome de Usuário',
                            controller: _controller1,
                            isSenha: false,
                            icone: Icons.person,
                          ),
                          const Padding(padding: EdgeInsets.all(10)),
                          CampoForm(
                            label: 'Email',
                            controller: _controller2,
                            isSenha: false,
                            icone: Icons.email,
                          ),
                          const Padding(padding: EdgeInsets.all(10)),
                          CampoForm(
                            label: 'Senha',
                            controller: _controller3,
                            isSenha: true,
                            icone: Icons.visibility_off,
                          ),
                          const Padding(padding: EdgeInsets.all(15)),
                          BotaoComponente(
                            texto: 'Cadastrar',
                            corFundo: const Color.fromARGB(255, 12, 175, 158),
                            onPressed: () {},
                            corTexto: Colors.white,
                            corSplash: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text.rich(TextSpan(
                    text: 'Já tem uma conta? ',
                    children: <InlineSpan>[
                      TextSpan(
                          text: 'Entre agora',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 12, 175, 158),
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()..onTap = () => Navigator.pop(context),
                      )
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
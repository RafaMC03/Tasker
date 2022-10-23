import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tasker/modules/cadastro/pages/cadastro.dart';
import 'package:tasker/modules/login/controller/loginController.dart';
import 'package:tasker/shared/components/botoes/botao_componente.dart';
import 'package:tasker/shared/components/campo_form/campo_form_componente.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
                            fontSize: 18,
                            color: Color.fromARGB(255, 12, 175, 158)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.48,
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
                                  "Entre na sua conta",
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
                                label: 'Email',
                                controller: _controller.email,
                                icone: Icons.email,
                                isSenha: false,
                              ),
                              const Padding(padding: EdgeInsets.all(20)),
                              CampoForm(
                                label: 'Senha',
                                controller: _controller.senha,
                                icone: Icons.visibility_off,
                                isSenha: true,
                              ),
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Esqueceu a senha?',
                                    style: TextStyle(color: Colors.grey),
                                  )),
                              const Padding(padding: EdgeInsets.all(20)),
                              BotaoComponente(
                                texto: 'Entrar',
                                corFundo: const Color.fromARGB(255, 12, 175, 158),
                                onPressed: () {
                                  _controller
                                      .login(
                                          //TODO: Fazer rota
                                          () {
                                    print("LOGADO");
                                  },
                                          (err) => showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                    child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text("Erro: $err"),
                                                  ],
                                                )),
                                              ));
                                },
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
                        text: 'Não tem uma conta? ',
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Cadastre-se agora',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 12, 175, 158),
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const CadastroPage()))),
                          )
                        ])),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

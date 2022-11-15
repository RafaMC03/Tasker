import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tasker/modules/home/pages/cadastroTarefas.dart';
import 'package:tasker/modules/home/pages/calendario.dart';

class HomeIndexPage extends StatefulWidget {
  const HomeIndexPage({Key? key}) : super(key: key);

  @override
  State<HomeIndexPage> createState() => _HomeIndexPageState();
}

class _HomeIndexPageState extends State<HomeIndexPage> {
  final pageViewController = PageController();
  @override
  Widget build(BuildContext conNtext) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const cadTarefas(),
                duration: const Duration(milliseconds: 300)),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 12, 175, 158),
      ),
      appBar: AppBar(
        title: Text('Tarefas'),
        backgroundColor: Color.fromARGB(255, 12, 175, 158),
      ),
      body: PageView(
        controller: pageViewController,
        children: [
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Sem tarefas cadastradas"),
                  TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      child: const Text("Logout"))
                ],
              ),
            ),
          ),
          Calendario()
        ],
      ),
      bottomNavigationBar: AnimatedBuilder(
          animation: pageViewController,
          builder: (context, snapshot) {
            return BottomNavigationBar(
              fixedColor: Color.fromARGB(255, 12, 175, 158),
              currentIndex: pageViewController.page?.round() ?? 0,
              onTap: (index) {
                pageViewController.jumpToPage(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  label: 'Registros',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month), label: 'Calandário'),
              ],
            );
          }),
    );
  }
}

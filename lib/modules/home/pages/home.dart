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
  int _selectedIndex = 0;
  int _tamanhoLinha = 2;
  bool _expandido = false;

  @override
  Widget build(BuildContext conNtext) {
    return Scaffold(
      backgroundColor: _expandido == false ? const Color.fromARGB(255, 241, 241, 241) : Color.fromARGB(120, 241, 241, 241),
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
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 12, 175, 158),
      ),
      appBar: AppBar(
        title: const Text('Tarefas'),
        backgroundColor: const Color.fromARGB(255, 12, 175, 158),
        actions: [
          TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.white),
              icon: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              label: const Text(
                "Logout",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
            _expandido = false;
          });
        },
        controller: pageViewController,
        children: [
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  //modelo das tarefas
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.027),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.92,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color.fromARGB(255, 12, 175, 158),
                              width: 2)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ExpansionTile(
                          backgroundColor: Colors.white,
                          onExpansionChanged: (expandido){
                            setState(() {
                              _expandido = expandido;
                              if(_tamanhoLinha < 20){
                                _tamanhoLinha = 20;
                              }
                              else{
                                _tamanhoLinha = 2;
                              }
                            });
                          },
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [ 
                              const Text('30 nov', style: TextStyle(color: Color.fromARGB(255, 12, 175, 158)),),
                              Text('Expandir', style: TextStyle(color: _expandido == false ? const Color.fromARGB(255, 12, 175, 158) : const Color.fromARGB(0, 0, 0, 0)),),
                            ]
                          ),                        
                          subtitle: Text(
                              'Terminar home page', maxLines: _tamanhoLinha, style: const TextStyle(color:Color.fromARGB(255, 133, 129, 129)),),
                          title: const Text(
                            'Sprint 3 - PSI',
                            style: TextStyle(
                                color: Color.fromARGB(255, 12, 175, 158),
                                fontWeight: FontWeight.bold),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0,0,MediaQuery.of(context).size.width * 0.04,MediaQuery.of(context).size.width * 0.014),
                                  child: TextButton(
                                    child: const Text("Excluir", style: TextStyle(color: Color.fromARGB(255, 12, 175, 158))),
                                    onPressed: () {
                                      //função excluir
                                    }
                                  )
                                )
                              ],)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Calendario()
        ],
      ),
      bottomNavigationBar: AnimatedBuilder(
          animation: pageViewController,
          builder: (context, snapshot) {
            return Container(
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(80, 133, 129, 129), width: 2.5)),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                        pageViewController.jumpToPage(_selectedIndex);
                      });
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.list,
                              color: _selectedIndex == 0
                                  ? Color.fromARGB(255, 12, 175, 158)
                                  : Color.fromARGB(140, 22, 20, 20)),
                          Text(
                            "Registros",
                            style: TextStyle(
                                color: _selectedIndex == 0
                                    ? Color.fromARGB(255, 12, 175, 158)
                                    : Color.fromARGB(140, 22, 20, 20)),
                          )
                        ],
                      ),
                    ),
                  )),
                  const VerticalDivider(
                    thickness: 3,
                    indent: 10,
                    endIndent: 10,
                    color: Color.fromARGB(80, 133, 129, 129),
                  ),
                  Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                        pageViewController.jumpToPage(_selectedIndex);
                      });
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.calendar_month,
                              color: _selectedIndex == 1
                                  ? Color.fromARGB(255, 12, 175, 158)
                                  : Color.fromARGB(140, 22, 20, 20)),
                          Text(
                            "Calendários",
                            style: TextStyle(
                                color: _selectedIndex == 1
                                    ? Color.fromARGB(255, 12, 175, 158)
                                    : Color.fromARGB(140, 22, 20, 20)),
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
              // child: BottomNavigationBar(
              //   fixedColor: const Color.fromARGB(255, 12, 175, 158),
              //   currentIndex: pageViewController.page?.round() ?? 0,
              //   onTap: (index) {
              //     pageViewController.jumpToPage(index);
              //   },
              //   items: const [
              //     BottomNavigationBarItem(
              //       tooltip: 'Todas as Tarefas',
              //       icon: Icon(
              //         Icons.list,
              //       ),
              //       label: 'Registros',
              //     ),
              //     BottomNavigationBarItem(
              //         tooltip: 'Calendário de Tarefas',
              //         icon: Icon(Icons.calendar_month),
              //         label: 'Calandário'),
              //   ],
              // )
            );
          }),
    );
  }
}

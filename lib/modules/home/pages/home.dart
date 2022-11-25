import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tasker/modules/home/models/tarefa_model.dart';
import 'package:tasker/modules/home/pages/cadastroTarefas.dart';
import 'package:tasker/modules/home/pages/calendario.dart';
import 'package:tasker/shared/components/tiles/homeTile.dart';
import 'package:tasker/shared/controllers/tarefasController.dart';

class HomeIndexPage extends StatefulWidget {
  const HomeIndexPage({Key? key}) : super(key: key);

  @override
  State<HomeIndexPage> createState() => _HomeIndexPageState();
}

class _HomeIndexPageState extends State<HomeIndexPage> {
  final pageViewController = PageController();
  int _selectedIndex = 0;
  final int _tamanhoLinha = 2;
  bool _expandido = false;

  @override
  void initState() {
    super.initState();
    Provider.of<TarefasController>(context, listen: false).getTarefas();
  }

  @override
  Widget build(BuildContext context) {
    var tarefas = Provider.of<TarefasController>(context);
    return Scaffold(
      backgroundColor: _expandido == false
          ? const Color.fromARGB(255, 241, 241, 241)
          : const Color.fromARGB(120, 241, 241, 241),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool volta = await Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const cadTarefas(),
                duration: const Duration(milliseconds: 300)),
          );
          volta ? _selectedIndex = 0 : _selectedIndex = 1;
          tarefas.getTarefas();
        },
        backgroundColor: const Color.fromARGB(255, 12, 175, 158),
        child: const Icon(Icons.add),
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
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 12, 175, 158),
                                width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              "Certeza que deseja sair?",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 133, 129, 129)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    child: const Text("Cancelar",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 12, 175, 158))),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    }),
                                TextButton(
                                    child: const Text("Sair",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 12, 175, 158))),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await FirebaseAuth.instance.signOut();
                                    }),
                              ],
                            )
                          ],
                        ),
                      )),
                );
              },
              label: const Text(
                "Logout",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: FutureBuilder<List<TarefaAgendada>>(
          future: tarefas.getTarefasFut,
          builder: (context, snap) {
            debugPrint(snap.data.toString());
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return PageView(
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                  _expandido = false;
                });
              },
              controller: pageViewController,
              children: [
                SafeArea(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: MediaQuery.of(context).size.width,
                      child: snap.data!.isNotEmpty
                          ? ListView.builder(
                              itemCount: snap.data!.length,
                              itemBuilder: (context, i) =>
                                  HomeTileTarefa(snap.data![i]))
                          : const Center(
                              child: Text(
                              "Sem tarefas cadastradas",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(130, 0, 0, 0)),
                            ))),
                ),
                const Calendario()
              ],
            );
          }),
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
                                  ? const Color.fromARGB(255, 12, 175, 158)
                                  : const Color.fromARGB(140, 22, 20, 20)),
                          Text(
                            "Registros",
                            style: TextStyle(
                                color: _selectedIndex == 0
                                    ? const Color.fromARGB(255, 12, 175, 158)
                                    : const Color.fromARGB(140, 22, 20, 20)),
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
                                  ? const Color.fromARGB(255, 12, 175, 158)
                                  : const Color.fromARGB(140, 22, 20, 20)),
                          Text(
                            "Calendários",
                            style: TextStyle(
                                color: _selectedIndex == 1
                                    ? const Color.fromARGB(255, 12, 175, 158)
                                    : const Color.fromARGB(140, 22, 20, 20)),
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tasker/modules/home/models/tarefa_model.dart';
import 'package:intl/intl.dart';
import 'package:tasker/shared/controllers/tarefasController.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<String, List<TarefaAgendada>>? selectedTarefas = {
    '17/11/2022': [
      TarefaAgendada(
          titulo: "Oi eu sou a tarefa 1",
          descricao: "Eu sou a descrição da tarefa 1",
          data: DateTime(2022, 11, 17),
          id: "1"),
      TarefaAgendada(
          titulo: "Oi eu sou a tarefa 2",
          descricao: "Eu sou a descrição da tarefa 2",
          data: DateTime(2022, 11, 17),
          id: "2"),
      TarefaAgendada(
          titulo: "Oi eu sou a tarefa 3",
          descricao: "Eu sou a descrição da tarefa 3",
          data: DateTime(2022, 11, 17),
          id: "3"),
      TarefaAgendada(
          titulo: "Oi eu sou a tarefa 4",
          descricao: "Eu sou a descrição da tarefa 4",
          data: DateTime(2022, 11, 17),
          id: "4"),
    ]
  };
  List<TarefaAgendada>? tarefasTemp = [];
  List<TarefaAgendada> _getEventsfromDay(DateTime data) {
    return selectedTarefas?[DateFormat('dd/MM/yyyy').format(data)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    var tarefas = Provider.of<TarefasController>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: FutureBuilder(
          future: tarefas.getTarefasFut,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            selectedTarefas = tarefas.tarefasGroup;
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.028,
                      top: MediaQuery.of(context).size.height * 0.028,
                      left: MediaQuery.of(context).size.width * 0.04,
                      right: MediaQuery.of(context).size.width * 0.04),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(80, 133, 129, 129),
                                width: 2))),
                    child: Center(
                        child: TableCalendar(
                      calendarBuilders: CalendarBuilders(
                        singleMarkerBuilder: (context, date, _) {
                          return Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 61, 109, 124)),
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 0.5),
                          );
                        },
                      ),
                      eventLoader: _getEventsfromDay,
                      headerStyle: const HeaderStyle(
                          titleCentered: true,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 12, 175, 158),
                          )),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      selectedDayPredicate: (day) =>
                          isSameDay(day, _selectedDay),
                      calendarFormat: CalendarFormat.month,
                      locale: "pt_BR",
                      focusedDay: _focusedDay,
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Mês'
                      },
                      calendarStyle: const CalendarStyle(
                        tablePadding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        selectedDecoration: BoxDecoration(
                          color: Color.fromARGB(255, 12, 175, 158),
                          shape: BoxShape.circle,
                        ),
                        todayTextStyle: TextStyle(color: Colors.black),
                        todayDecoration: BoxDecoration(
                            color: Color.fromARGB(0, 12, 175, 158),
                            shape: BoxShape.circle),
                      ),
                    )),
                  ),
                ),
                ..._getEventsfromDay(_selectedDay).map(
                  (TarefaAgendada tarefaAgendada) => Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.022,
                          0,
                          MediaQuery.of(context).size.height * 0.022,
                          MediaQuery.of(context).size.width * 0.02),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  _selectedDay.day.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                    DateFormat('EEE', 'pt_Br')
                                        .format(_selectedDay)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 15, height: 1))
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 12, 175, 158),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                margin:
                                    const EdgeInsetsDirectional.only(start: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ListTile(
                                  title: Text(
                                    tarefaAgendada.titulo,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(tarefaAgendada.descricao),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.018))
              ], // falta fazer o estilo do evento e comparar a data com a selecionada
            );
          }),
    );
  }
}

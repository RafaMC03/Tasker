import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tasker/modules/home/models/tarefa_model.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<String, List<TarefaAgendada>>? selectedTarefas = {};
  List<TarefaAgendada>? tarefasTemp = [];
  List<TarefaAgendada> _getEventsfromDay(DateTime data) {
    return selectedTarefas?[data] ?? [TarefaAgendada(titulo: "Oi eu sou a tarefa", descricao: "eu sou a descrição da tarefa", data: "10/10/2010", id: "1")];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white
              ),
              child: Center(                  
                  child: TableCalendar(      
                    eventLoader: _getEventsfromDay,                           
                    headerStyle: const HeaderStyle(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 12, 175, 158),
                      )
                    ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                calendarFormat: CalendarFormat.month,
                locale: "pt_BR",
                focusedDay: DateTime.now(),
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 30)),
                availableCalendarFormats: const {CalendarFormat.month: 'Mês'},
                onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                },
                calendarStyle: CalendarStyle(                
                  selectedDecoration: BoxDecoration(
                      color: const Color.fromARGB(255, 12, 175, 158),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color.fromARGB(255, 12, 175, 158),
                          width: 1.5)),
                  todayTextStyle: const TextStyle(color: Colors.black),
                  todayDecoration: const BoxDecoration(
                      color: Color.fromARGB(0, 12, 175, 158),
                      shape: BoxShape.circle),
                ),)              
              ),              
            ),            
          ),
          ..._getEventsfromDay(_selectedDay).map((TarefaAgendada tarefaAgendada) => Padding(padding: const EdgeInsets.all(8), child: Text(tarefaAgendada.titulo),),),
        ],// falta fazer o estilo do evento e comparar a data com a selecionada
      ),
    );
  }
}

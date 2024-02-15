import 'package:flutter/material.dart';
import 'scheduleCard.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> daysOfWeek = [
    "Segunda",
    "Terça",
    "Quarta",
    "Quinta",
    "Sexta"
  ];

  @override
  void initState() {
    super.initState();
    // Encontrar o índice correspondente ao dia atual da semana
    int currentDayIndex = DateTime.now().weekday - 1;

    // Se o índice estiver fora dos limites da lista, definir como segunda-feira
    if (currentDayIndex < 0 || currentDayIndex >= daysOfWeek.length) {
      currentDayIndex = 0; // Segunda-feira
    }

    // Inicializar o TabController com o índice atual
    _tabController = TabController(
      length: daysOfWeek.length,
      vsync: this,
      initialIndex: currentDayIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.green, Colors.white],
          stops: [0.1, 0.1],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Horário de aula"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  // Adicione sua ação aqui
                },
                icon: Icon(Icons.help_outline),
              )
            ],
            backgroundColor: Colors.green,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(75.0),
              child: Container(
                margin: EdgeInsets.only(top: 8.0),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.greenAccent[100],
                  indicatorColor: Colors.white,
                  tabs: daysOfWeek.map((day) => Tab(text: day)).toList(),
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: daysOfWeek.map((day) => _buildDaySchedule(context)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDaySchedule(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScheduleCard(
            begin: "19:00",
            end: "20:45",
            classroom: "311",
            discipline: "Sistemas Distribuidos",
            teacher: "Leandro Freitas",
          ),
          const ScheduleCard(
            begin: "20:45",
            end: "22:30",
            classroom: "311",
            discipline: "Prática Fábrica de Software",
            teacher: "Elymar Cabral",
          ),
          // Adicione mais widgets conforme necessário
        ],
      ),
    );
  }
}
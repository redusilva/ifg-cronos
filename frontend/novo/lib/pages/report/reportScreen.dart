import 'package:flutter/material.dart';
import 'reportCard.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
  final List<String> yearsOfReport = [
    "2024/1",
    "2023/2",
    "2023/1",
    "2022/2",
    "2022/1"
  ];
}

class _ReportScreenState extends State<ReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    // Inicializar o TabController com o índice atual
    _tabController = TabController(
      length: widget.yearsOfReport.length,
      vsync: this,
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
          stops: [0.2, 0.2],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Boletim"),
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
                  tabs: widget.yearsOfReport
                      .map((day) => Tab(text: day))
                      .toList(),
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: widget.yearsOfReport
                .map((year) => _buildDaySchedule(context, year))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDaySchedule(BuildContext context, String year) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
            ],
          ),

          ReportCard(
            frequence: 77,
            maxAbsences: 18,
            situation: "Aprovado",
            absences: 2,
            grade: 7.0,
            teacher: "Leandro Freitas",
            discipline: "Sistema distribuidos",
          ),

          ReportCard(
            frequence: 92,
            maxAbsences: 18,
            situation: "Reprovado",
            absences: 20,
            grade: 8.5,
            teacher: "Elymar Cabral",
            discipline: "Prática Fábrica de Software",
          ),
          ReportCard(
            frequence: 66,
            maxAbsences: 18,
            situation: "Cursando",
            absences: 13,
            grade: 5.7,
            teacher: "Cleiton José",
            discipline: "Governança Corporativa",
          ),

          // Adicione mais widgets conforme necessário
        ],
      ),
    );
  }
}

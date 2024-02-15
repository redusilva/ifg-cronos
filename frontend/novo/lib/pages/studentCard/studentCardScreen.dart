import 'package:flutter/material.dart';
import 'frontCard.dart';
import 'backCard.dart';

class studentCardScreen extends StatefulWidget {
  studentCardScreen({Key? key}) : super(key: key);

  @override
  _studentCardScreenState createState() => _studentCardScreenState();
  final List<String> sides = [
    "Frente",
    "Verso",
  ];
}

class _studentCardScreenState extends State<studentCardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: widget.sides.length,
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
          stops: [0.1, 0.1],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Carteira Estudantil"),
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
                  tabs: widget.sides.map((day) => Tab(text: day)).toList(),
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: widget.sides
                .map((side) => _buildDaySchedule(context, side))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDaySchedule(BuildContext context, String side) {
    return side == "Frente"
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FrontCard(
                  frequence: 77,
                  maxAbsences: 18,
                  situation: "Aprovado",
                  absences: 2,
                  grade: 7.0,
                  teacher: "Leandro Freitas",
                  discipline: "Sistema distribuidos",
                ),

                // Adicione mais widgets conforme necessário
              ],
            ),
          )
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackCard(
                  frequence: 77,
                  maxAbsences: 18,
                  situation: "Aprovado",
                  absences: 2,
                  grade: 7.0,
                  teacher: "Leandro Freitas",
                  discipline: "Sistema distribuidos",
                )

                // Adicione mais widgets conforme necessário
              ],
            ),
          );
  }
}

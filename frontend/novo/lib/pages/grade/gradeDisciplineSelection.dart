import 'package:flutter/material.dart';
import 'gradeDiary/gradeDiaryScreen.dart';

class GradeDisciplineScreen extends StatefulWidget {
  GradeDisciplineScreen({Key? key}) : super(key: key);

  @override
  _GradeDisciplineScreenState createState() => _GradeDisciplineScreenState();
  final List<String> yearsOfReport = [
    "2024/1",
    "2023/2",
    "2023/1",
    "2022/2",
    "2022/1"
  ];
}

class _GradeDisciplineScreenState extends State<GradeDisciplineScreen>
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
          stops: [0.1, 0.1],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Minhas notas"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
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
                .map((day) => _buildDaySchedule(context))
                .toList(),
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
          SizedBox(
            width: 20,
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Selecione a disciplina",
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ],
          ),
          SizedBox(
            height: 5,
            width: 5,
          ),
          Divider(
            thickness: 1.5,
            height: 10,
          ),
          SizedBox(
            height: 20,
            width: 20,
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Stack(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GradeDiaryScreen(
                                disciplineName: "Sistemas Distribuidos",
                              )),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: Colors.blueGrey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.green[600]!,
                          width: 2.0,
                        ),
                      ),
                      primary: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sistemas Distribuídos',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                          Icon(Icons.arrow_forward,
                              color:
                                  Colors.green), // Ícone de seta para a direita
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
            width: 20,
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Stack(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GradeDiaryScreen(
                                disciplineName: "Sistemas Distribuidos",
                              )),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: Colors.blueGrey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.green[600]!,
                          width: 2.0,
                        ),
                      ),
                      primary: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Prática fábrica de software',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.green[400], fontSize: 16),
                          ),
                          Icon(Icons.arrow_forward,
                              color:
                                  Colors.green[400]), // Ícone de seta para a direita
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Adicione mais widgets conforme necessário
        ],
      ),
    );
  }
}

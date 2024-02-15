import 'package:flutter/material.dart';
import 'gradeActivityCard.dart';

class GradeDiaryScreen extends StatefulWidget {
  final String disciplineName;
  GradeDiaryScreen({required this.disciplineName, Key? key}) : super(key: key);

  @override
  _GradeDiaryScreen createState() => _GradeDiaryScreen();
  final List<String> stages = [
    "1B",
    "2B",
    "3B",
    "4B",
  ];
}

class _GradeDiaryScreen extends State<GradeDiaryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    // Inicializar o TabController com o índice atual
    _tabController = TabController(
      length: widget.stages.length,
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
            title: Text("Minhas Notas"),
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
                  tabs: widget.stages.map((day) => Tab(text: day)).toList(),
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children:
                widget.stages.map((day) => _buildDaySchedule(context)).toList(),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Card(
                  color: Colors.white, // Cor de fundo cinza
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                        color: Colors.green, width: 5.5), // Borda verde
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    width: 355, // Largura do card
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sitemas Distribuidos",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.green),
                                    ),
                                    Text("Prof. Leandro Alexandre",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black)),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 35,
                              width: 35,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.stairs,
                                            color: Colors.green[800]),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Etapa",
                                          style: TextStyle(
                                            color: Colors.green[800],
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                      width: 5,
                                    ),
                                    Text("1° Bimestre",
                                        style: TextStyle(
                                          color: Colors.greenAccent[700],
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.emoji_events,
                                            color: Colors.green[800]),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Nota",
                                          style: TextStyle(
                                            color: Colors.green[800],
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                      width: 5,
                                    ),
                                    Text("8.5",
                                        style: TextStyle(
                                          color: Colors.greenAccent[700],
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 60,
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.flag, color: Colors.green[800]),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Situação",
                                      style: TextStyle(
                                        color: Colors.green[800],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                  width: 5,
                                ),
                                Text("Em andamento",
                                    style: TextStyle(
                                      color: Colors.greenAccent[700],
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // Adicione mais widgets conforme necessário
            ],
          ),
          SizedBox(
            width: 25,
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Atividades",
                style: TextStyle(fontSize: 20, color: Colors.green[800]),
              ),
            ],
          ),

          GradeActivityCard(
            activityName: "Prova prática",
            activityMaxGrade: 10,
            activityType: "Avaliação aplicada pelo professor",
            activtyDate: "03/01/2023",
            myGrade: 8.5,
            
          ),

          GradeActivityCard(
            activityName: "Projeto em grupo",
            activityMaxGrade: 6,
            activityType: "Atividade avaliativa",
            activtyDate: "04/01/2023",
            myGrade: 3.3,
            
          ),

          GradeActivityCard(
            activityName: "Atividades em sala",
            activityMaxGrade: 10,
            activityType: "Atividade avaliativa",
            activtyDate: "06/01/2023",
            myGrade: 2,
            
          ),

         

          // Adicione mais widgets conforme necessário
        ],
      ),
    );
  }
}

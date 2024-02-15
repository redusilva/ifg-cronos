import 'package:flutter/material.dart';
import 'materialCard.dart';

class MaterialScreen extends StatefulWidget {
  final String disciplineName;
  MaterialScreen({required this.disciplineName, Key? key}) : super(key: key);

  @override
  _GradeDiaryScreen createState() => _GradeDiaryScreen();
  
}

class _GradeDiaryScreen extends State<MaterialScreen> {
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
              title: Text("Material de aula"),
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
                preferredSize: Size.fromHeight(25.0),
                child: Container(
                  margin: EdgeInsets.only(top: 2.0),
                ),
              ),
            ),
            body: _buildDaySchedule(context)),
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
              Column(
                children: [
                  Text(
                    widget.disciplineName,
                    style: TextStyle(fontSize: 22, color: Colors.greenAccent[700]),
                  ),
                  Text("Prof. Leandro Freitas")
                ],
              ),
            ],
          ),

          MaterialCard(
            materialName: "Revisão Prova",
            activityType: "Documento",
            uploadDate: "03/01/2023",
            fileExtension: ".doc",
          ),

          MaterialCard(
            materialName: "Projeto em grupo",
            activityType: "Documento",
            uploadDate: "04/01/2023",
            fileExtension: ".pdf",
          ),

          MaterialCard(
            materialName: "Vídeo Aula explicativa",
            activityType: "Vídeo",
            uploadDate: "04/01/2023",
            fileExtension: ".mp4",
          ),

        

          // Adicione mais widgets conforme necessário
        ],
      ),
    );
  }
}

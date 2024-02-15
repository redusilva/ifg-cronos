import 'package:flutter/material.dart';

class FrontCard extends StatelessWidget {
  final String discipline;
  final String teacher;
  final String situation;
  final double grade;
  final int absences;
  final int maxAbsences;
  final int frequence;

  const FrontCard({
    required this.discipline,
    required this.teacher,
    required this.grade,
    required this.absences,
    required this.frequence,
    required this.maxAbsences,
    required this.situation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 10,
            height: 10,
          ),
          Card(
            color: Colors.white, // Cor de fundo cinza
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.green, width: 5.5), // Borda verde
            ),
            child: Container(
                padding: EdgeInsets.all(18.0),
                width: 370, // Largura do card
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70, // ajuste conforme necessário
                              width:
                                  220, // ajuste conforme necessário // ajuste conforme necessário
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/logo A.png'),
                                  fit: BoxFit
                                      .fill, // Usando scaleDown para evitar que a imagem seja ampliada
                                  scale:
                                      0.5, // Ajuste o valor de scale conforme necessário
                                ),
                              ),
                            ),
                            Container(
                              height: 75, // ajuste conforme necessário
                              width: 75, // ajuste conforme necessário
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/fotoExemplo.png'),
                                  fit: BoxFit
                                      .fill, // Usando scaleDown para evitar que a imagem seja ampliada
                                  scale:
                                      0.5, // Ajuste o valor de scale conforme necessário
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 25,
                          height: 25,
                        ),
                        Text(
                          "Carteira Estudantil",
                          style:
                              TextStyle(fontSize: 21, color: Colors.green[800]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.green[800],
                                    ),
                                    SizedBox(
                                      width: 5,
                                      height: 5,
                                    ),
                                    Text(
                                      "Nome",
                                      style: TextStyle(
                                        color: Colors.green[800],
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Tarcyo Guilherme Maia Borges",
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                          width: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.school,
                                      color: Colors.green[800],
                                    ),
                                    SizedBox(
                                      width: 5,
                                      height: 5,
                                    ),
                                    Text(
                                      "Curso",
                                      style: TextStyle(
                                        color: Colors.green[800],
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text("Engenharia de Software"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.assignment,
                                      color: Colors.green[800],
                                    ),
                                    SizedBox(
                                      width: 5,
                                      height: 5,
                                    ),
                                    Text(
                                      "Modalidade",
                                      style: TextStyle(
                                        color: Colors.green[800],
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Bacharelado",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

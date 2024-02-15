import 'package:flutter/material.dart';

class BackCard extends StatelessWidget {
  final String discipline;
  final String teacher;
  final String situation;
  final double grade;
  final int absences;
  final int maxAbsences;
  final int frequence;

  const BackCard({
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
                padding: EdgeInsets.all(16.0),
                width: 355, // Largura do card
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
                              width: 220, // ajuste conforme necessário
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
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 25,
                          height: 25,
                        ),
                        Text(
                          "Campus Inhumas",
                          style:
                              TextStyle(fontSize: 21, color: Colors.green[800]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.how_to_reg,
                              color: Colors.green[800],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Matrícula",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.green[800]),
                                ),
                                Text(
                                  "20211030180055",
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.flag,
                                      color: Colors.green[800],
                                    ),
                                    SizedBox(
                                      width: 5,
                                      height: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Situação",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.green[800]),
                                        ),
                                        SizedBox(
                                          height: 5,
                                          width: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Matriculado",
                                            ),
                                            SizedBox(
                                              width: 2,
                                              height: 2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 75,
                                  height: 75,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.event_busy,
                                      color: Colors.green[800],
                                    ),
                                    SizedBox(
                                      width: 5,
                                      height: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Validade",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.green[800]),
                                        ),
                                        SizedBox(
                                          height: 5,
                                          width: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text("07/07/2024"),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.green[800],
                                    ),
                                    SizedBox(
                                      width: 5,
                                      height: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nascimento",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.green[800]),
                                        ),
                                        SizedBox(
                                          height: 5,
                                          width: 5,
                                        ),
                                        Text(
                                          "13/12/2022",
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 75,
                                  height: 75,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.badge,
                                      color: Colors.green[800],
                                    ),
                                    SizedBox(
                                      width: 5,
                                      height: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Identidade",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.green[800]),
                                        ),
                                        SizedBox(
                                          height: 5,
                                          width: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "4523240 - SSP/GO",
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.qr_code_scanner,
                                  color: Colors.green[800],
                                ),
                                SizedBox(
                                  height: 5,
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Identificador",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green[800]),
                                    ),
                                    Container(
                                      height: 100, // ajuste conforme necessário
                                      width: 100, // ajuste conforme necessário
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/qr.png'),
                                          fit: BoxFit
                                              .fill, // Usando scaleDown para evitar que a imagem seja ampliada
                                          scale:
                                              0.5, // Ajuste o valor de scale conforme necessário
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                )),
          ),
          Divider(
            thickness: 0.5,
            height: 20,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

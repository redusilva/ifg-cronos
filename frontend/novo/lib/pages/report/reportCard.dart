import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String discipline;
  final String teacher;
  final String situation;
  final double grade;
  final int absences;
  final int maxAbsences;
  final int frequence;

  const ReportCard({
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
    Color corFrequencia = Colors.amber[800]!;
    if (frequence >= 90) {
      corFrequencia = Colors.green;
    } else if (frequence < 75) {
      corFrequencia = Colors.red;
    }

    Color corFaltas = Colors.amber[800]!;
    if ((maxAbsences / 2) > absences) {
      corFaltas = Colors.green;
    } else if ((maxAbsences - 4) <= absences) {
      corFaltas = Colors.red;
    }

    Color? corNota = Colors.amber[800]!;
    if (grade >= 6.5) {
      corNota = Colors.green;
    } else if (grade < 6) {
      corNota = Colors.red;
    }
    Color corSituacao = Colors.amber[800]!;

    IconData iconeSituacao = Icons.pending;
    if (situation == 'Aprovado') {
      iconeSituacao = Icons.verified;
      corSituacao = Colors.greenAccent[700]!;
    } else if (situation == 'Reprovado') {
      iconeSituacao = Icons.warning;
      corSituacao = Colors.red;
    }

    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    discipline,
                    style: TextStyle(color: Colors.greenAccent[700], fontSize: 22),
                  ),
                  Text(
                    "Prof. " + teacher,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: corSituacao,
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                              height: 10,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Icon(
                                    iconeSituacao,
                                    color: Colors.white,
                                    size: 65,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 3,
                              height: 3,
                            ),
                            Column(
                              children: [
                                Text(
                                  situation.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: Colors.black,
                            ),
                            Text(
                              " Nota: " + grade.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            grade <= 6.5
                                ? Row(
                                    children: [
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(Icons.warning, color: corNota),
                                    ],
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(height: 10, width: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.event_busy,
                              color: Colors.black,
                            ),
                            Text(
                              "Faltas: " +
                                  absences.toString() +
                                  " (máximo " +
                                  maxAbsences.toString() +
                                  ")",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            absences >= (maxAbsences / 2)
                                ? Row(
                                    children: [
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        Icons.warning,
                                        color: corFaltas,
                                      )
                                    ],
                                  )
                                : SizedBox()
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                          width: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.percent_outlined,
                              color: Colors.black,
                            ),
                            Text(
                              "Frequencia: " + frequence.toString() + "%",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            frequence < 70
                                ? Row(
                                    children: [
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        Icons.warning,
                                        color: corFrequencia,
                                      )
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 0.8,
            height: 40,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

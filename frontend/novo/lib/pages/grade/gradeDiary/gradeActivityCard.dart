import 'package:flutter/material.dart';

class GradeActivityCard extends StatelessWidget {
  final String activityName;
  final String activityType;
  final double activityMaxGrade;
  final double myGrade;
  final String activtyDate;

  const GradeActivityCard({
    required this.activityName,
    required this.activityType,
    required this.activityMaxGrade,
    required this.myGrade,
    required this.activtyDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color indicatorColor = Colors.greenAccent[700]!;
    IconData indicatorIcon = Icons.emoji_events;
    if (myGrade < (activityMaxGrade * 0.6)) {
      indicatorColor = Colors.amber[800]!;
      indicatorIcon = Icons.warning;
    }
    if (myGrade < (activityMaxGrade * 0.3)) {
      indicatorColor = Colors.red;
    }
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: indicatorColor,
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
                                  indicatorIcon,
                                  color: Colors.white,
                                  size: 40,
                                ),
    
                                //   Text(
                                //   end,
                                //   style: TextStyle(
                                //    color: Colors.white,
                                //    fontSize: 6,
                                //    ),
                                // )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 3,
                            height: 3,
                          ),
                          Column(
                            children: [
                              Text("Nota:",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  )),
                              Text(
                                myGrade.toString() +
                                    "  / " +
                                    activityMaxGrade.toString(),
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
                            Icons.science,
                            color: Colors.green[800],
                          ),
                          Text(
                            " " + activityName,
                            style: TextStyle(
                              color: Colors.green[800],
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10, width: 5),
                      Row(
                        children: [
                          Icon(Icons.book),
                          Text(
                            " " + activityType,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                        width: 5,
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_month),
                          Text(
                            " " + activtyDate,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.7,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

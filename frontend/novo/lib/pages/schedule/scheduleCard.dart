import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final String begin;
  final String end;
  final String discipline;
  final String teacher;
  final String classroom;

  const ScheduleCard({
    required this.begin,
    required this.end,
    required this.discipline,
    required this.teacher,
    required this.classroom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10,height: 10,),
                        Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: Colors.white,
                                size: 50,
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
                        SizedBox(width: 5,height: 5,),
                        Text(
                          begin + " - " + end,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
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
                          Icons.school,
                          color: Colors.green,
                        ),
                        Text(
                          " " + discipline,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10, width: 5),
                    Row(
                      children: [
                        Icon(Icons.person),
                        Text(
                          " Prof. " + teacher,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
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
                        Icon(Icons.room),
                        Text(
                          "Sala " + classroom,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
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
    );
  }
}

import 'package:flutter/material.dart';
import 'materialScreen/materialScreen.dart';

class MaterialDisciplineCard extends StatelessWidget {
  final String discipline;
  final String teacher;

  const MaterialDisciplineCard({
    required this.discipline,
    required this.teacher,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MaterialScreen(
                  disciplineName: discipline,
                )),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    const SizedBox(width: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 125,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            discipline,
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          Container(
            height: 2,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

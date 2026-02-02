import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String month;
  final int alphabetClicks;
  final int wordClicks;
  final int numberClicks;
  final int expressionClicks;
  final double percentage1;
  final double percentage2;
  final double percentage3;
  final double percentage4;

  const ChartBar({
    super.key,
    this.month = '',
    this.alphabetClicks = 0,
    this.wordClicks = 0,
    this.numberClicks = 0,
    this.expressionClicks = 0,
    this.percentage1 = 0,
    this.percentage2 = 0,
    this.percentage3 = 0,
    this.percentage4 = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(clicks.toString()),
        SizedBox(
          height: 5,
          width: 200,
        ),
        Row(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 50,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: percentage1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  'alfabeto',
                  style: TextStyle(fontSize: 8),
                ),
                Text(
                  "(${alphabetClicks.toString()})",
                  style: TextStyle(fontSize: 8),
                ),
              ],
            ),
            SizedBox(
              width: 1,
            ),
            Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 40,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: percentage2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  'palavras',
                  style: TextStyle(fontSize: 8),
                ),
                Text(
                  "(${wordClicks.toString()})",
                  style: TextStyle(fontSize: 8),
                ),
              ],
            ),
            SizedBox(
              width: 1,
            ),
            Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 40,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: percentage3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  'números',
                  style: TextStyle(fontSize: 8),
                ),
                Text(
                  "(${numberClicks.toString()})",
                  style: TextStyle(fontSize: 8),
                ),
              ],
            ),
            SizedBox(
              width: 1,
            ),
            Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 40,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: percentage4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 207, 207, 17),
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  'expressões',
                  style: TextStyle(fontSize: 8),
                ),
                Text(
                  "(${expressionClicks.toString()})",
                  style: TextStyle(fontSize: 8),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(month),
      ],
    );
  }
}

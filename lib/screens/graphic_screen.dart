import 'package:braille_app/components/chart_bar.dart';
import 'package:braille_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/graphic.dart';

//import '../models/graphic.dart';

// ignore: must_be_immutable
class GraphicScreen extends StatefulWidget {
  const GraphicScreen({super.key});

  @override
  State<GraphicScreen> createState() => _GraphicScreenState();
}

class _GraphicScreenState extends State<GraphicScreen> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    users.add({"id": 1, "label": "user 1"});
    users.add({"id": 2, "label": "user 2"});
  }

  List<num> alphabetClicksSum = [2, 9, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  List<num> wordsClicksSum = [72, 6, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  List<num> numbersClicksSum = [4, 8, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  List<num> expressionsClicksSum = [2, 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  monthNumberConvertor(int month) {
    if (month == 1 || month == -11) {
      return 'Janeiro';
    } else if (month == 2 || month == -10) {
      return 'Fevereiro';
    } else if (month == 3 || month == -9) {
      return 'Março';
    } else if (month == 4 || month == -8) {
      return 'Abril';
    } else if (month == 5 || month == -7) {
      return 'Maio';
    } else if (month == 6 || month == -6) {
      return 'Junho';
    } else if (month == 7 || month == -5) {
      return 'Julho';
    } else if (month == 8 || month == -4) {
      return 'Agosto';
    } else if (month == 9 || month == -3) {
      return 'Setembro';
    } else if (month == 10 || month == -2) {
      return 'Outubro';
    } else if (month == 11 || month == -1) {
      return 'Novembro';
    } else if (month == 12 || month == 0) {
      return 'Dezembro';
    }
  }

  monthStringConvertor(String month) {
    if (month == 'January') {
      return 1;
    } else if (month == 'February') {
      return 2;
    } else if (month == 'March') {
      return 3;
    } else if (month == 'April') {
      return 4;
    } else if (month == 'May') {
      return 5;
    } else if (month == 'June') {
      return 6;
    } else if (month == 'July') {
      return 7;
    } else if (month == 'August') {
      return 8;
    } else if (month == 'September') {
      return 9;
    } else if (month == 'October') {
      return 10;
    } else if (month == 'November') {
      return 11;
    } else if (month == 'December') {
      return 12;
    }
  }

  List<Map<String, dynamic>> get groupedClicks {
    return List.generate(
      2,
      (index) {
        final month = monthNumberConvertor((DateTime.now().month - 1) - index);
        final alphabetClicks = alphabetClicksSum[index];
        final wordClicks = wordsClicksSum[index];
        final numberClicks = numbersClicksSum[index];
        final expressionClicks = expressionsClicksSum[index];
        // print(wordClicks);
        return {
          'month': month,
          'AlphabetClicks': alphabetClicks,
          'wordClicks': wordClicks,
          'NumberClicks': numberClicks,
          'ExpressionClicks': expressionClicks
        };
      },
    );
  }

  List<Map<String, dynamic>> get groupedWordClicks {
    return List.generate(
      2,
      (index) {
        final month = monthNumberConvertor((DateTime.now().month - 1) - index);
        final wordClicks = wordsClicksSum[index];
        return {'month': month, 'wordClicks': wordClicks};
      },
    );
  }

  List<Map<String, dynamic>> get groupedNumberClicks {
    return List.generate(
      2,
      (index) {
        final month = monthNumberConvertor((DateTime.now().month - 1) - index);
        final numberClicks = numbersClicksSum[index];
        return {'month': month, 'NumberClicks': numberClicks};
      },
    );
  }

  List<Map<String, dynamic>> get groupedExpressionClicks {
    return List.generate(
      2,
      (index) {
        final month = monthNumberConvertor((DateTime.now().month - 1) - index);
        final expressionClicks = expressionsClicksSum[index];
        return {'month': month, 'ExpressionClicks': expressionClicks};
      },
    );
  }

  double get _monthsTotalAlphabetClicks {
    return groupedClicks.fold(0.0, (sum, alphabetClicks) {
      return sum + alphabetClicks['AlphabetClicks'];
    });
  }

  double get _monthsTotalWordClicks {
    return groupedWordClicks.fold(0.0, (sum, wordClicks) {
      return sum + wordClicks['wordClicks'];
    });
  }

  double get _monthsTotalNumberClicks {
    return groupedNumberClicks.fold(0.0, (sum, numberClicks) {
      return sum + numberClicks['NumberClicks'];
    });
  }

  double get _monthsTotalExpressionClicks {
    return groupedExpressionClicks.fold(0.0, (sum, expressionClicks) {
      return sum + expressionClicks['ExpressionClicks'];
    });
  }

  void _usersChart(BuildContext context) {
    Navigator.of(context).pushNamed('/users-chart-screen');
  }

  @override
  Widget build(BuildContext context) {
    final graphic = Provider.of<Graphic>(context);
    final auth = Provider.of<Auth>(context);
    alphabetClicksSum[0] = graphic.alphabet2Current;
    alphabetClicksSum[1] = graphic.alphabet;

    wordsClicksSum[0] = graphic.words2Current;
    wordsClicksSum[1] = graphic.words;

    numbersClicksSum[0] = graphic.numbers2Current;
    numbersClicksSum[1] = graphic.numbers;

    expressionsClicksSum[0] = graphic.expressions2Current;
    expressionsClicksSum[1] = graphic.expressions;

    double total = _monthsTotalAlphabetClicks +
        _monthsTotalExpressionClicks +
        _monthsTotalNumberClicks +
        _monthsTotalWordClicks;
    // print('${graphic.alphabet} eba');

    void dropdownCallback(int? selectedValue) {
      if (selectedValue is int) {
        setState(() {
          if (selectedValue == 2) {}
          //graphic.getClicks(auth.token??'', auth.userId??'',uid);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                _usersChart(context);
                graphic.getUIDs(
                    auth.token ?? '', auth.userId ?? '', 'Alphabet');
                // graphic.totalAlphabet2;
              },
              child: Text(
                'gráfico geral',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(
        children: [
          DropdownButton(items: [
            DropdownMenuItem(value: 1, child: Text("user 1")),
            DropdownMenuItem(
              value: 2,
              child: Text("user 2"),
            ),
            DropdownMenuItem(
              value: 3,
              child: Text("user 3"),
            ),
            DropdownMenuItem(
              value: 4,
              child: Text("user 4"),
            ),
          ], onChanged: dropdownCallback),
          Card(
            elevation: 6,
            margin: EdgeInsets.all(20),
            child: Row(
              children: groupedClicks.map((clicks) {
                return ChartBar(
                  month: clicks['month'].toString(),
                  alphabetClicks: clicks['AlphabetClicks'] as int,
                  wordClicks: clicks['wordClicks'] as int,
                  numberClicks: clicks['NumberClicks'] as int,
                  expressionClicks: clicks['ExpressionClicks'] as int,
                  percentage1: (clicks['AlphabetClicks'] as double) / total,
                  percentage2: (clicks['wordClicks'] as double) / total,
                  percentage3: (clicks['NumberClicks'] as double) / total,
                  percentage4: (clicks['ExpressionClicks'] as double) / total,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

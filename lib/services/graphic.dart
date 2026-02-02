// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:convert';

import 'package:braille_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Graphic with ChangeNotifier {
  final String click;

  Graphic({
    this.click = '',
  });

  List<String> dias = [];
  List<String> dias10 = [];
  num alphabet = 0;
  num alphabet2Current = 0;
  num words = 0;
  num words2Current = 0;
  num numbers = 0;
  num numbers2Current = 0;
  num expressions = 0;
  num expressions2Current = 0;

  List uids = [];
  List salvaDias = [];
  List salvaMeses = [];
  List totalAlphabetJanuary = [0, 0, 0, 0];
  List totalAlphabetJanuary2 = [0, 0, 0, 0];
  List totalAlphabetFebruary = [0, 0, 0, 0];
  List totalAlphabetFebruary2 = [0, 0, 0, 0];
  List totalAlphabetMarch = [0, 0, 0, 0];
  List totalAlphabetMarch2 = [0, 0, 0, 0];
  List totalAlphabetApril = [0, 0, 0, 0];
  List totalAlphabetApril2 = [0, 0, 0, 0];
  List totalAlphabetMay = [0, 0, 0, 0];
  List totalAlphabetMay2 = [0, 0, 0, 0];
  List totalAlphabetJune = [0, 0, 0, 0];
  List totalAlphabetJune2 = [0, 0, 0, 0];
  List totalAlphabetJuly = [0, 0, 0, 0];
  List totalAlphabetJuly2 = [0, 0, 0, 0];
  List totalAlphabetAugust = [0, 0, 0, 0];
  List totalAlphabetAugust2 = [0, 0, 0, 0];
  List totalAlphabetSeptember = [0, 0, 0, 0];
  List totalAlphabetSeptember2 = [0, 0, 0, 0];
  List totalAlphabetOctober = [0, 0, 0, 0];
  List totalAlphabetOctober2 = [0, 0, 0, 0];
  List totalAlphabetNovember = [0, 0, 0, 0];
  List totalAlphabetNovember2 = [0, 0, 0, 0];
  List totalAlphabetDecember = [0, 0, 0, 0];
  List totalAlphabetDecember2 = [0, 0, 0, 0];

  int sinal = 0;

  List sixMonths = [];

  Future<void> getClicks(String token, String userId, String user) async {
    alphabet = 0;
    alphabet2Current = 0;
    words = 0;
    words2Current = 0;
    numbers = 0;
    numbers2Current = 0;
    expressions = 0;
    expressions2Current = 0;
    final response = await http.get(Uri.parse(
        "${Constants.BASE_URL}/users/$user/clicks/2023/September.json?auth=$token"));
    final response10 = await http.get(Uri.parse(
        "${Constants.BASE_URL}/users/$user/clicks/2023/October.json?auth=$token"));
    Map<dynamic, dynamic> dados = jsonDecode(response.body);
    Map<dynamic, dynamic> dados10 = jsonDecode(response10.body);
    // print(dados);
    dias.clear();
    dados.forEach((id, dados) {
      dias.add(id);
    });

    dias10.clear();
    dados10.forEach((id, dados) {
      dias10.add(id);
    });
//  print(dias);
//  print(dias10);

    for (var dia in dias) {
      final response2 = await http.get(Uri.parse(
          "${Constants.BASE_URL}/users/$user/clicks/2023/September/$dia.json?auth=$token"));
      Map<dynamic, dynamic> dados2 = jsonDecode(response2.body);
      //   print('$dados2 esse formato');

      if (dados2.containsKey('alfabeto')) {
        alphabet += dados2['alfabeto'];
      }

      if (dados2.containsKey('palavras')) {
        words += dados2['palavras'];
      }

      if (dados2.containsKey('números')) {
        numbers += dados2['números'];
      }

      if (dados2.containsKey('expressões')) {
        expressions += dados2['expressões'];
      }
    }
    for (var dia in dias10) {
      final response20 = await http.get(Uri.parse(
          "${Constants.BASE_URL}/users/$user/clicks/2023/October/$dia.json?auth=$token"));
      Map<dynamic, dynamic> dados20 = jsonDecode(response20.body);
      //   print(dados2);
      if (dados20.containsKey('alfabeto')) {
        alphabet2Current += dados20['alfabeto'];
      }

      if (dados20.containsKey('palavras')) {
        words2Current += dados20['palavras'];
      }

      if (dados20.containsKey('números')) {
        numbers2Current += dados20['números'];
      }

      if (dados20.containsKey('expressões')) {
        expressions2Current += dados20['expressões'];
      }
//print('$alphabet2Current teste');
    }
    notifyListeners();
  }

  Future<void> getUIDs(String token, String userId, String aba) async {
    // salva as uids
    final response = await http
        .get(Uri.parse("${Constants.BASE_URL}/users.json?auth=$token"));
    Map<dynamic, dynamic> dados = jsonDecode(response.body);
    dias.clear();
    uids.clear();
    dados.forEach((id, dados) {
      uids.add(id);
    });

    totalAlphabetJanuary = [0, 0, 0, 0];
    totalAlphabetJanuary2 = [0, 0, 0, 0];
    totalAlphabetFebruary = [0, 0, 0, 0];
    totalAlphabetFebruary2 = [0, 0, 0, 0];
    totalAlphabetMarch = [0, 0, 0, 0];
    totalAlphabetMarch2 = [0, 0, 0, 0];
    totalAlphabetApril = [0, 0, 0, 0];
    totalAlphabetApril2 = [0, 0, 0, 0];
    totalAlphabetMay = [0, 0, 0, 0];
    totalAlphabetMay2 = [0, 0, 0, 0];
    totalAlphabetJune = [0, 0, 0, 0];
    totalAlphabetJune2 = [0, 0, 0, 0];
    totalAlphabetJuly = [0, 0, 0, 0];
    totalAlphabetJuly2 = [0, 0, 0, 0];
    totalAlphabetAugust = [0, 0, 0, 0];
    totalAlphabetAugust2 = [0, 0, 0, 0];
    totalAlphabetSeptember = [0, 0, 0, 0];
    totalAlphabetSeptember2 = [0, 0, 0, 0];
    totalAlphabetOctober = [0, 0, 0, 0];
    totalAlphabetOctober2 = [0, 0, 0, 0];
    totalAlphabetNovember = [0, 0, 0, 0];
    totalAlphabetNovember2 = [0, 0, 0, 0];
    totalAlphabetDecember = [0, 0, 0, 0];
    totalAlphabetDecember2 = [0, 0, 0, 0];

    // para cada uid
    for (int i = 0; i < uids.length; i++) {
      //pega os meses
      final availableMonths = await http.get(Uri.parse(
          "${Constants.BASE_URL}/users/${uids[i]}/clicks/2023/.json?auth=$token"));
      Map<dynamic, dynamic> dadosMes = jsonDecode(availableMonths.body);

      salvaMeses.clear();
      dadosMes.forEach((id, dadosMes) {
        salvaMeses.add(id);
      });

      //pega os dias do mes
      for (int m = 0; m < salvaMeses.length; m++) {
        // ignore: avoid_print
        print(salvaMeses[m]);
        final availableDays = await http.get(Uri.parse(
            "${Constants.BASE_URL}/users/${uids[i]}/clicks/2023/${salvaMeses[m]}.json?auth=$token"));
        Map<dynamic, dynamic> dadosDias = jsonDecode(availableDays.body);
        print("teste 2");

        salvaDias.clear();
        dadosDias.forEach((id, dadosDias) {
          salvaDias.add(id);
        });
        //soma clicks para cada dia
        for (int b = 0; b < salvaDias.length; b++) {
          print('dia ${salvaDias[b]}');
          print('user ${uids[i]}');
          final response3 = await http.get(Uri.parse(
              "${Constants.BASE_URL}/users/${uids[i]}/clicks/2023/${salvaMeses[m]}/${salvaDias[b]}.json?auth=$token"));
          Map<dynamic, dynamic> dados3 = jsonDecode(response3.body);

          if (salvaMeses[m] == 'January') {
            if (dados3['alfabeto'].runtimeType != Null) {
              totalAlphabetJanuary[0] += dados3['alfabeto'];
            }
            if (dados3['palavras'].runtimeType != Null) {
              totalAlphabetJanuary[1] += dados3['palavras'];
            }
            if (dados3['números'].runtimeType != Null) {
              totalAlphabetJanuary[2] += dados3['números'];
            }
            if (dados3['expressões'].runtimeType != Null) {
              totalAlphabetJanuary[3] += dados3['expressões'];
            }
          } else if (salvaMeses[m] == 'February') {
            if (dados3['alfabeto'].runtimeType != Null) {
              totalAlphabetFebruary[0] += dados3['alfabeto'];
            }
            if (dados3['palavras'].runtimeType != Null) {
              totalAlphabetFebruary[1] += dados3['palavras'];
            }
            if (dados3['números'].runtimeType != Null) {
              totalAlphabetFebruary[2] += dados3['números'];
            }
            if (dados3['expressões'].runtimeType != Null) {
              totalAlphabetFebruary[3] += dados3['expressões'];
            }
          } else if (salvaMeses[m] == 'March') {
            if (dados3['alfabeto'].runtimeType != Null) {
              totalAlphabetMarch[0] += dados3['alfabeto'];
            }
            if (dados3['palavras'].runtimeType != Null) {
              totalAlphabetMarch[1] += dados3['palavras'];
            }
            if (dados3['números'].runtimeType != Null) {
              totalAlphabetMarch[2] += dados3['números'];
            }
            if (dados3['expressões'].runtimeType != Null) {
              totalAlphabetMarch[3] += dados3['expressões'];
            }
          } else if (salvaMeses[m] == 'April') {
            if (dados3['alfabeto'].runtimeType != Null) {
              totalAlphabetApril[0] += dados3['alfabeto'];
            }
            if (dados3['palavras'].runtimeType != Null) {
              totalAlphabetApril[1] += dados3['palavras'];
            }
            if (dados3['números'].runtimeType != Null) {
              totalAlphabetApril[2] += dados3['números'];
            }
            if (dados3['expressões'].runtimeType != Null) {
              totalAlphabetApril[3] += dados3['expressões'];
            }
          } else if (salvaMeses[m] == 'May') {
            if (dados3['alfabeto'].runtimeType != Null) {
              totalAlphabetMay[0] += dados3['alfabeto'];
            }
            if (dados3['palavras'].runtimeType != Null) {
              totalAlphabetMay[1] += dados3['palavras'];
            }
            if (dados3['números'].runtimeType != Null) {
              totalAlphabetMay[2] += dados3['números'];
            }
            if (dados3['expressões'].runtimeType != Null) {
              totalAlphabetMay[3] += dados3['expressões'];
            }
          } else if (salvaMeses[m] == 'June') {
            if (dados3['alfabeto'].runtimeType != Null) {
              totalAlphabetJune[0] += dados3['alfabeto'];
            }
            if (dados3['palavras'].runtimeType != Null) {
              totalAlphabetJune[1] += dados3['palavras'];
            }
            if (dados3['números'].runtimeType != Null) {
              totalAlphabetJune[2] += dados3['números'];
            }
            if (dados3['expressões'].runtimeType != Null) {
              totalAlphabetJune[3] += dados3['expressões'];
            }
          } else if (salvaMeses[m] == 'July') {
            if (dados3['alfabeto'].runtimeType != Null) {
              totalAlphabetJuly[0] += dados3['alfabeto'];
            }
            if (dados3['palavras'].runtimeType != Null) {
              totalAlphabetJuly[1] += dados3['palavras'];
            }
            if (dados3['números'].runtimeType != Null) {
              totalAlphabetJuly[2] += dados3['números'];
            }
            if (dados3['expressões'].runtimeType != Null) {
              totalAlphabetJuly[3] += dados3['expressões'];
            }
          } else if (salvaMeses[m] == 'August') {
            if (dados3['alfabeto'].runtimeType != Null) {
              totalAlphabetAugust[0] += dados3['alfabeto'];
            }
            if (dados3['palavras'].runtimeType != Null) {
              totalAlphabetAugust[1] += dados3['palavras'];
            }
            if (dados3['números'].runtimeType != Null) {
              totalAlphabetAugust[2] += dados3['números'];
            }
            if (dados3['expressões'].runtimeType != Null) {
              totalAlphabetAugust[3] += dados3['expressões'];
            }
          } else if (salvaMeses[m] == 'September') {
            if (dados3['alfabeto'].runtimeType != Null) {
              totalAlphabetSeptember[0] += dados3['alfabeto'];
            }
            if (dados3['palavras'].runtimeType != Null) {
              totalAlphabetSeptember[1] += dados3['palavras'];
            }
            if (dados3['números'].runtimeType != Null) {
              totalAlphabetSeptember[2] += dados3['números'];
            }
            if (dados3['expressões'].runtimeType != Null) {
              totalAlphabetSeptember[3] += dados3['expressões'];
            }
          } else if (salvaMeses[m] == 'October') {
            if (dados3['alfabeto'].runtimeType != Null) {
              totalAlphabetOctober[0] += dados3['alfabeto'];
            }
            if (dados3['palavras'].runtimeType != Null) {
              totalAlphabetOctober[1] += dados3['palavras'];
            }
            if (dados3['números'].runtimeType != Null) {
              totalAlphabetOctober[2] += dados3['números'];
            }
            if (dados3['expressões'].runtimeType != Null) {
              totalAlphabetOctober[3] += dados3['expressões'];
            }
          } else if (salvaMeses[m] == 'November') {
            if (dados3['alfabeto'].runtimeType != Null) {
              totalAlphabetNovember[0] += dados3['alfabeto'];
            }
            if (dados3['palavras'].runtimeType != Null) {
              totalAlphabetNovember[1] += dados3['palavras'];
            }
            if (dados3['números'].runtimeType != Null) {
              totalAlphabetNovember[2] += dados3['números'];
            }
            if (dados3['expressões'].runtimeType != Null) {
              totalAlphabetNovember[3] += dados3['expressões'];
            }
          } else if (salvaMeses[m] == 'December') {
            if (dados3['alfabeto'].runtimeType != Null) {
              totalAlphabetDecember[0] += dados3['alfabeto'];
            }
            if (dados3['palavras'].runtimeType != Null) {
              totalAlphabetDecember[1] += dados3['palavras'];
            }
            if (dados3['números'].runtimeType != Null) {
              totalAlphabetDecember[2] += dados3['números'];
            }
            if (dados3['expressões'].runtimeType != Null) {
              totalAlphabetDecember[3] += dados3['expressões'];
            }
          }
        }

        notifyListeners();
      }
    }
    totalAlphabetJanuary2 = totalAlphabetJanuary;
    totalAlphabetFebruary2 = totalAlphabetFebruary;
    totalAlphabetMarch2 = totalAlphabetMarch;
    totalAlphabetApril2 = totalAlphabetApril;
    totalAlphabetMay2 = totalAlphabetMay;
    totalAlphabetJune2 = totalAlphabetJune;
    totalAlphabetJuly2 = totalAlphabetJuly;
    totalAlphabetAugust2 = totalAlphabetAugust;
    totalAlphabetSeptember2 = totalAlphabetSeptember;
    totalAlphabetOctober2 = totalAlphabetOctober;
    totalAlphabetNovember2 = totalAlphabetNovember;
    totalAlphabetDecember2 = totalAlphabetDecember;

    notifyListeners();
  }
}

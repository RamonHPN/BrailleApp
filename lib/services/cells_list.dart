import 'dart:convert';

import 'package:braille_app/components/ball.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CellsList with ChangeNotifier {
  final List<Ball> _items = [];

  List<Ball> get items => [..._items];

  final bool pressedBall1;
  int id;
  CellsList({
    this.pressedBall1 = false,
    this.id = 0,
  });

  clear() {
    _items.clear();
  }

  addCells(String frase) {
    int phraseLength = frase.length;
    _items.clear();
    for (int i = 0; i < phraseLength; i++) {
      _items.add(Ball());
    }
    notifyListeners();
  }

  addOneCell(String letra) {
    _items.clear();
    _items.add(Ball());
    notifyListeners();
  }

  int numberOfClicks = 0;
  DateTime date = DateTime.now();
  String writtedDate = "";

  Future<void> wordsClicker(String token, String userId) async {
    numberOfClicks++;
    writtedDate = DateFormat("yyyy/MMMM/dd").format(date);
    http.put(
        Uri.parse(
            '${Constants.BASE_URL}/users/$userId/clicks/$writtedDate/palavras.json?auth=$token'),
        body: jsonEncode(numberOfClicks));
    notifyListeners();
  }
}

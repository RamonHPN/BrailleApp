import 'package:braille_app/models/modulos.dart';
import 'package:flutter/material.dart';
import 'package:braille_app/data/fases_data.dart';

class ModulosList with ChangeNotifier {
  final List<Modulo> _items = fasesData;

  List<Modulo> get items => [..._items];

  void addFase(Modulo fase) {
    _items.add(fase);
    notifyListeners();
  }
}

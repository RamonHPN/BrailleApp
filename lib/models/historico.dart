import 'package:flutter/material.dart';

class Historico with ChangeNotifier {
  String id;
  String data;
  String textoPortugues;
  String textoBraille;

  Historico({
    this.id = '',
    this.data = '',
    this.textoPortugues = '',
    this.textoBraille = '',
  });
}

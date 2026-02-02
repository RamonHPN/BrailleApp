// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:braille_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Information1 with ChangeNotifier {
  String nome;

  Information1({
    this.nome = '',
  });
  Future<void> saveName(String token, String userId) async {
    http.put(
        Uri.parse('${Constants.BASE_URL}/users/$userId/dados.json?auth=$token'),
        body: jsonEncode({"Nome": nome}));
    print(nome);
    notifyListeners();
  }

  Future<void> saveInformation1(
      String token, String userId, int selected) async {
    http.put(
        Uri.parse('${Constants.BASE_URL}/users/$userId/dados.json?auth=$token'),
        body: jsonEncode({"nível de entendimento": selected}));
    notifyListeners();
  }

  Future<void> saveInformation2(String token, String userId, bool selected1,
      bool selected2, bool selected3) async {
    http.put(
        Uri.parse(
            '${Constants.BASE_URL}/users/$userId/dados/interesse.json?auth=$token'),
        body: jsonEncode({
          "Traduzir caracteres": selected1,
          'Aprender': selected2,
          'Praticar': selected3
        }));
    notifyListeners();
  }

  Future<void> getDados(String token, String userId) async {
    final response = await http.get(Uri.parse(
        "${Constants.BASE_URL}/users/$userId/dados.json?auth=$token"));

    Map<dynamic, dynamic> dados = jsonDecode(response.body);
    nome = dados['Nome'];
  }
}

import 'package:flutter/material.dart';
import 'package:braille_app/models/minigame_model.dart';

class Fase {
  final String id;
  final String title;
  final String description;
  final Color color;
  final String icon;
  final List<MiniGameTemplate> miniGames;

  Fase({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.miniGames,
  });

  Fase copyWith({
    List<MiniGameTemplate>? miniGames,
  }) {
    return Fase(
      id: id,
      title: title,
      description: description,
      color: color,
      icon: icon,
      miniGames: miniGames ?? this.miniGames,
    );
  }
}




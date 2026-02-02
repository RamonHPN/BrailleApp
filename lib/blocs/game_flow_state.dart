import 'package:braille_app/components/fase.dart';
import '../models/minigame_model.dart';

abstract class GameFlowState {}

class GameFlowInitial extends GameFlowState {}

class FaseLoading extends GameFlowState {}

class FaseLoaded extends GameFlowState {
  final Fase fase;
  final int currentMiniGameIndex;
  final int lives;

  FaseLoaded({
    required this.fase,
    this.currentMiniGameIndex = 0,
    this.lives = 3,
  });
}

class MiniGameStarted extends GameFlowState {
  final MiniGameTemplate miniGame;
  final int remainingLives;

  MiniGameStarted({
    required this.miniGame,
    required this.remainingLives,
  });
}

class GameOver extends GameFlowState {
  final String faseId;

  GameOver({required this.faseId});
}

class FaseCompleted extends GameFlowState {}
import '../models/minigame_model.dart';

abstract class GameFlowEvent {}

class LoadFaseEvent extends GameFlowEvent {
  final String faseId;
  LoadFaseEvent(this.faseId);
}

class StartMiniGameEvent extends GameFlowEvent {
  final MiniGameTemplate miniGame;
  StartMiniGameEvent(this.miniGame);
}

class AnswerSubmittedEvent extends GameFlowEvent {
  final String faseId;
  final bool isCorrect;
  AnswerSubmittedEvent(this.isCorrect, this.faseId);
}

class RetryFaseEvent extends GameFlowEvent {}
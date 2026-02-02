import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:braille_app/models/minigame_model.dart';
import 'package:flutter/material.dart';
import 'package:braille_app/blocs/game_flow_event.dart';
import 'package:braille_app/blocs/game_flow_state.dart';
import 'package:braille_app/components/fase.dart';
import 'package:braille_app/data/fases2_data.dart';
import 'package:braille_app/services/fase_service.dart';

class GameFlowBloc extends Bloc<GameFlowEvent, GameFlowState> {
  final FaseService faseService;

  /// Sequência atual de minigames
  late List<MiniGameTemplate> _currentMiniGames;
  /// Número da fase atual (como inteiro)
  late int _currentPhaseNumber;

  GameFlowBloc({required this.faseService}) : super(GameFlowInitial()) {
    on<LoadFaseEvent>(_onLoadFase);
    on<StartMiniGameEvent>(_onStartMiniGame);
    on<AnswerSubmittedEvent>(_onAnswerSubmitted);
    on<RetryFaseEvent>(_onRetryFase);
  }

  Future<void> _onLoadFase(
    LoadFaseEvent event,
    Emitter<GameFlowState> emit,
  ) async {
    emit(FaseLoading());
    _currentPhaseNumber = int.tryParse(event.faseId) ?? 1;
    try {
      final faseBase = fases.firstWhere((f) => f.id == event.faseId);
      _currentMiniGames =
          await faseService.carregarMiniGamesDaFase(faseBase.id);

      emit(FaseLoaded(
        fase: faseBase.copyWith(miniGames: _currentMiniGames),
      ));

      if (_currentMiniGames.isNotEmpty) {
        add(StartMiniGameEvent(_currentMiniGames.first));
      }
    } catch (e, st) {
      debugPrint('Erro ao carregar fase: $e\n$st');
      emit(GameFlowInitial());
    }
  }

  void _onStartMiniGame(
    StartMiniGameEvent event,
    Emitter<GameFlowState> emit,
  ) {
    if (state is FaseLoaded) {
      final current = state as FaseLoaded;
      emit(MiniGameStarted(
        miniGame: event.miniGame,
        remainingLives: current.lives,
      ));
    }
  }

  Future<void> _onAnswerSubmitted(
    AnswerSubmittedEvent event,
    Emitter<GameFlowState> emit,
  ) async {
    if (state is! MiniGameStarted) return;
    final current = state as MiniGameStarted;
    final idx = _currentMiniGames.indexOf(current.miniGame);

    if (event.isCorrect) {
      if (idx == _currentMiniGames.length - 1) {
        // Último minigame da fase: tenta atualizar para a próxima
        await faseService.atualizarFase(_currentPhaseNumber + 1);
        emit(FaseCompleted());
      } else {
        // Avança para o próximo minigame, mantendo as vidas
        emit(MiniGameStarted(
          miniGame: _currentMiniGames[idx + 1],
          remainingLives: current.remainingLives,
        ));
      }
    } else {
      // Errou: desconta vida
      final livesLeft = current.remainingLives - 1;
      if (livesLeft <= 0) {
        emit(GameOver(faseId: _currentPhaseNumber.toString()));
      } else {
        emit(MiniGameStarted(
          miniGame: current.miniGame,
          remainingLives: livesLeft,
        ));
      }
    }
  }

  void _onRetryFase(
    RetryFaseEvent event,
    Emitter<GameFlowState> emit,
  ) {
    add(LoadFaseEvent(_currentPhaseNumber.toString()));
  }
}

import 'package:braille_app/models/minigame_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:braille_app/blocs/game_flow_bloc.dart';
import 'package:braille_app/blocs/game_flow_event.dart';
import 'package:braille_app/blocs/game_flow_state.dart';
import 'package:braille_app/services/fase_service.dart';
import 'package:braille_app/components/minigames_templates/apresentar_game.dart';
import 'package:braille_app/components/minigames_templates/letra_linha_game.dart';
import 'package:braille_app/components/minigames_templates/completar_palavra_game.dart';

class Fase2Screen extends StatefulWidget {
  final String faseId;
  final FaseService faseService;

  const Fase2Screen({Key? key, required this.faseId, required this.faseService})
      : super(key: key);

  @override
  _Fase2ScreenState createState() => _Fase2ScreenState();
}

class _Fase2ScreenState extends State<Fase2Screen> {
  late final GameFlowBloc _bloc;
  bool _showFeedback = false;
  bool _feedbackSuccess = false;
  String _feedbackText = '';

  @override
  void initState() {
    super.initState();
    _bloc = GameFlowBloc(faseService: widget.faseService)
      ..add(LoadFaseEvent(widget.faseId));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _onUserSubmit(bool acertou) {
    setState(() {
      _feedbackSuccess = acertou;
      _feedbackText = acertou ? 'Resposta correta' : 'Resposta errada';
      _showFeedback = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _showFeedback = false);
      _bloc.add(AnswerSubmittedEvent(acertou, widget.faseId));
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<GameFlowBloc, GameFlowState>(
        builder: (context, state) {
          final hearts = (state is MiniGameStarted)
              ? List.generate(
                  state.remainingLives,
                  (_) => const Icon(Icons.favorite, color: Colors.red),
                )
              : <Widget>[];

          Widget content;
          if (state is FaseLoading) {
            content = const Center(child: CircularProgressIndicator());
          } else if (state is MiniGameStarted) {
            Widget gameWidget = const SizedBox.shrink();
            switch (state.miniGame.type) {
              case MiniGameType.APRESENTAR:
                gameWidget = ApresentarGame(
                  questao: state.miniGame.questao!,
                  onContinue: () => _bloc.add(
                    AnswerSubmittedEvent(true, widget.faseId),
                  ),
                );
                break;
              case MiniGameType.MULTIPLE_LETRAS_LINHA:
  gameWidget = LetraLinhaGame(
    key: ValueKey(state.miniGame.id),      
    questao: state.miniGame.questao!,
    onSubmit: _onUserSubmit,
  );
  break;
              case MiniGameType.COMPLETAR_PALAVRA:
                gameWidget = CompletarPalavraSimpleGame(
                  questao: state.miniGame.questao!,
                  onSubmit: _onUserSubmit,
                );
                break;
            }
            content = Column(
              children: [Expanded(child: gameWidget)],
            );
          } else if (state is FaseCompleted) {
  content = Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: screenHeight * 0.08),
          alignment: Alignment.center,
          width: screenWidth * 340 / 360,
          height: screenHeight * 150 / 360,
          child: Image.asset(
            'assets/images/fase_concluida.png',
            fit: BoxFit.fill,
          ),
        ),
        const Text(
          'Parabéns, você concluiu a fase com sucesso!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: SizedBox(
            width: screenWidth * 0.8,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF208B52),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Próxima Fase',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    ),
  );
} else if (state is GameOver) {
            content = Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Container(
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.all(29),
              margin: const EdgeInsets.only(top: 100, bottom: 5),
              alignment: Alignment.center,
              width: screenWidth * 290 / 360,
              height: screenHeight * 150 / 360,
              child: Image.asset(
                'assets/images/muiraquita_triste.png',
                fit: BoxFit.fill,
              ),
            ),
                  const Text(
                    'Você perdeu todas as vidas!',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                     style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF208B52),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                    onPressed: () => _bloc.add(RetryFaseEvent()),
                    child: const Text('Tentar novamente', style: TextStyle(fontSize: 20),),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                     style: TextButton.styleFrom(
                  //  backgroundColor: Color(0xFF208B52),
                    foregroundColor: Color(0xFF1CB9C5),
                   // padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Voltar para fases', style: TextStyle(fontSize: 20),),
                  ),
                ],
              ),
            );
          }


else if (state is FaseCompleted) {
  content = Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: screenHeight * 0.08),
          alignment: Alignment.center,
          width: screenWidth * 340 / 360,
          height: screenHeight * 150 / 360,
          child: Image.asset(
            'assets/images/fase_concluida.png',
            fit: BoxFit.fill,
          ),
        ),
        const Text(
          'Parabéns, você concluiu a fase com sucesso!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: SizedBox(
            width: screenWidth * 0.8,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF208B52),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Próxima Fase',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
           else {
            content = const SizedBox.shrink();
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Fase ${widget.faseId}'),
              centerTitle: true,
              actions: [Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(children: hearts),
                )],
            ),
            body: Stack(
              children: [
                content,
                if (_showFeedback)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        decoration: BoxDecoration(
                          color: _feedbackSuccess ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _feedbackText,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

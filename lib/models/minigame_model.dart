import 'package:braille_app/models/questao_model.dart';

enum MiniGameType { LETTER_RECOGNITION, SYLLABLE, TEXT_TRANSCRIPTION, MULTIPLE_LETRAS_LINHA, APRESENTAR, COMPLETAR_PALAVRA }

class MiniGameTemplate {
  final String id;
  final MiniGameType type;
  final int difficulty;
  final QuestaoModel? questao;

  MiniGameTemplate({
    required this.id,
    required this.type,
    required this.difficulty,
    this.questao,
  });
}

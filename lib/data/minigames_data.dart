import 'package:braille_app/models/minigame_model.dart';

final Map<String, List<Map<String, dynamic>>> sequenciaMinigames = {
  '1': [
    {
      'categoria': 'apresentar',
      'padrao': 'padrao_1',
      'tipo': MiniGameType.APRESENTAR,
      'direct': true, // busca direto do doc “padrao_1”
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_1',
      'grupo': 'a',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      // sem 'id': o serviço vai sortear 3 questões desse grupo
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_1',
      'grupo': 'b',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_1',
      'grupo': 'c',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_1',
      'grupo': 'd',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_1',
      'grupo': 'e',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
  ],
  '2': [
    {
      'categoria': 'apresentar',
      'padrao': 'padrao_2',
      'tipo': MiniGameType.APRESENTAR,
      'direct': true,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_2',
      'grupo': 'a',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_2',
      'grupo': 'b',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_2',
      'grupo': 'c',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
  ],
  '3': [
    {
      'categoria': 'apresentar',
      'padrao': 'padrao_3',
      'tipo': MiniGameType.APRESENTAR,
      'direct': true,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_3',
      'grupo': 'a',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_3',
      'grupo': 'b',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_3',
      'grupo': 'c',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
  ],
  '4': [
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_1',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q1',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_1',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q2',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_1',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q3',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_1',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q4',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_1',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q5',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_1',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q6',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_1',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q7',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_1',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q8',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_1',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q9',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_1',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q10',
    },
  ],
  '5': [
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_2',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q1',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_2',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q2',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_2',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q3',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_2',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q4',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_2',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q5',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_2',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q6',
    },
  ],
  '6': [
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_3',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q1',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_3',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q2',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_3',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q3',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_3',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q4',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_3',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q5',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_3',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q6',
    },
    {
      'categoria': 'diferenciar',
      'padrao': 'padrao_3',
      'tipo': MiniGameType.COMPLETAR_PALAVRA,
      'id': 'q7',
    },
  ],
  '7': [
    {
      'categoria': 'apresentar',
      'padrao': 'padrao_4',
      'tipo': MiniGameType.APRESENTAR,
      'direct': true,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_4',
      'grupo': 'a',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      'subset': [0,1]
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_4',
      'grupo': 'b',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_4',
      'grupo': 'c',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
  ],
  '8': [
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_4',
      'grupo': 'a',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      'subset': [0,2]
    },

  ],

  '9': [
    {
      'categoria': 'apresentar',
      'padrao': 'padrao_5',
      'tipo': MiniGameType.APRESENTAR,
      'direct': true,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_5',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      'subset': [0,1]
    },
  ],
  '10': [
    {
      'categoria': 'apresentar',
      'padrao': 'padrao_6',
      'tipo': MiniGameType.APRESENTAR,
      'direct': true,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_6',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      'subset': [0,1]
    },
  ],
  '11': [
    {
      'categoria': 'apresentar',
      'padrao': 'padrao_7',
      'tipo': MiniGameType.APRESENTAR,
      'direct': true,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_7',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      'subset': [0,1]
    },
  ],
  '12': [
    {
      'categoria': 'apresentar',
      'padrao': 'padrao_8',
      'tipo': MiniGameType.APRESENTAR,
      'direct': true,
    },
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_8',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      'subset': [0,1]
    },
  ],
  '13': [
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_4',
      'grupo': 'a',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      'subset': [0,2]
    },
  ],
  '14': [
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_5',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      'subset': [0,2]
    },
  ],
  '15': [
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_6',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      'subset': [0,2]
    },
  ],
  '16': [
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_7',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      'subset': [0,2]
    },
  ],
  '17': [
    {
      'categoria': 'reconhecer',
      'padrao': 'padrao_8',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      'subset': [0,2]
    },
  ],
   '18': [
    {
      'categoria': 'fixar',
      'padrao': 'padrao_1',
      'grupo': 'a',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      // sem 'id': o serviço vai sortear 3 questões desse grupo
    },
    {
      'categoria': 'fixar',
      'padrao': 'padrao_1',
      'grupo': 'b',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'fixar',
      'padrao': 'padrao_1',
      'grupo': 'c',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'fixar',
      'padrao': 'padrao_1',
      'grupo': 'd',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'fixar',
      'padrao': 'padrao_1',
      'grupo': 'e',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'fixar',
      'padrao': 'padrao_1',
      'grupo': 'f',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
  ],
   '19': [
    {
      'categoria': 'fixar',
      'padrao': 'padrao_2',
      'grupo': 'a',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      // sem 'id': o serviço vai sortear 3 questões desse grupo
    },
    {
      'categoria': 'fixar',
      'padrao': 'padrao_2',
      'grupo': 'b',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'fixar',
      'padrao': 'padrao_2',
      'grupo': 'c',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
  ],
   '20': [
    {
      'categoria': 'fixar',
      'padrao': 'padrao_3',
      'grupo': 'a',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
      // sem 'id': o serviço vai sortear 3 questões desse grupo
    },
    {
      'categoria': 'fixar',
      'padrao': 'padrao_3',
      'grupo': 'b',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
    {
      'categoria': 'fixar',
      'padrao': 'padrao_3',
      'grupo': 'c',
      'tipo': MiniGameType.MULTIPLE_LETRAS_LINHA,
    },
  ],
};

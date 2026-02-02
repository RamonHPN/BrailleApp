// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Ball with ChangeNotifier {
  int id;
  bool pressedBall1;
  bool pressedBall2;
  bool pressedBall3;
  bool pressedBall4;
  bool pressedBall5;
  bool pressedBall6;
  int pressedBall11;
  int pressedBall22;
  int pressedBall33;
  int pressedBall44;
  int pressedBall55;
  int pressedBall66;
  String translation;

  Ball({
    this.id = 0,
    this.pressedBall1 = false,
    this.pressedBall2 = false,
    this.pressedBall3 = false,
    this.pressedBall4 = false,
    this.pressedBall5 = false,
    this.pressedBall6 = false,
    this.pressedBall11 = 0,
    this.pressedBall22 = 0,
    this.pressedBall33 = 0,
    this.pressedBall44 = 0,
    this.pressedBall55 = 0,
    this.pressedBall66 = 0,
    this.translation = "",
  });

  void pressBall() {
    if (id == 1) {
      pressedBall1 = !pressedBall1;
    }
    if (id == 2) {
      pressedBall2 = !pressedBall2;
    }
    if (id == 3) {
      pressedBall3 = !pressedBall3;
    }
    if (id == 4) {
      pressedBall4 = !pressedBall4;
    }
    if (id == 5) {
      pressedBall5 = !pressedBall5;
    }
    if (id == 6) {
      pressedBall6 = !pressedBall6;
    }
  }

  //  phraseLenght(String letra){
  //    int length = letra.length;
  //    notifyListeners();
  //  }

  List duasMatrizes = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  List<int> balls1 = List.filled(500, 0);
  List<int> balls2 = List.filled(500, 0);
  List<int> balls3 = List.filled(500, 0);
  List<int> balls4 = List.filled(500, 0);
  List<int> balls5 = List.filled(500, 0);
  List<int> balls6 = List.filled(500, 0);
  bool blank = false;
  translatePhrase(String letra, int id) {
    for (int i = 0; i < letra.length; i++) {
      balls1[i] = 0;
      balls2[i] = 0;
      balls3[i] = 0;
      balls4[i] = 0;
      balls5[i] = 0;
      balls6[i] = 0;
      blank = false;
      if (letra[i] == 'a') {
        balls1[i] = 1;
      } else if (letra[i] == "b") {
        balls1[i] = 1;
        balls2[i] = 1;
      } else if (letra[i] == "A") {
        balls4[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "c") {
        balls1[i] = 1;
        balls4[i] = 1;
      } else if (letra[i] == "d") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "e") {
        balls1[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "f") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls2[i] = 1;
      } else if (letra[i] == "g") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "h") {
        balls1[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "i") {
        balls4[i] = 1;
        balls2[i] = 1;
      } else if (letra[i] == "j") {
        balls4[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "k") {
        balls1[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "l") {
        balls1[i] = 1;
        balls2[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "m") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "n") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "o") {
        balls1[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "p") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls2[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "q") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "r") {
        balls1[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "s") {
        balls4[i] = 1;
        balls2[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "t") {
        balls4[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "u") {
        balls1[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "v") {
        balls1[i] = 1;
        balls2[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "w") {
        balls4[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "x") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "y") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "z") {
        balls1[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == " ") {
        balls1[i] = 2;
        balls4[i] = 2;
        balls2[i] = 2;
        balls5[i] = 2;
        balls3[i] = 2;
        balls6[i] = 2;
      } else if (letra[i] == '1') {
        balls1[i] = 1;
      } else if (letra[i] == "2") {
        balls1[i] = 1;
        balls2[i] = 1;
      } else if (letra[i] == "3") {
        balls1[i] = 1;
        balls4[i] = 1;
      } else if (letra[i] == "4") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "5") {
        balls1[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "6") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls2[i] = 1;
      } else if (letra[i] == "7") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "8") {
        balls1[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "9") {
        balls4[i] = 1;
        balls2[i] = 1;
      } else if (letra[i] == "0") {
        balls4[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "B") {
        balls4[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "*") {
        balls5[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "-") {
        balls6[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "/") {
        balls2[i] = 1;
        balls5[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "+") {
        balls2[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "=") {
        balls2[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "(") {
        balls1[i] = 1;
        balls2[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == ")") {
        balls4[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "á") {
        balls1[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "é") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "í") {
        balls4[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "ó") {
        balls4[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "ú") {
        balls4[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "à") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls2[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "â") {
        balls1[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "ê") {
        balls1[i] = 1;
        balls2[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "ô") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls5[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "ã") {
        balls4[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "õ") {
        balls4[i] = 1;
        balls2[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "ç") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls2[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == ",") {
        balls2[i] = 1;
      } else if (letra[i] == ";") {
        balls2[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == ":") {
        balls2[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == ".") {
        balls3[i] = 1;
      } else if (letra[i] == "?") {
        balls2[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "!") {
        balls2[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "-") {
        balls6[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "&") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls2[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "|") {
        balls4[i] = 1;
        balls5[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == ">") {
        balls1[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "<") {
        balls4[i] = 1;
        balls2[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "°") {
        balls5[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == '"') {
        balls2[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == '\$') {
        balls5[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "[") {
        balls1[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "]") {
        balls4[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      }
    }
    notifyListeners();
  }

  translateNumber(String letra, int id) {
    for (int i = 0; i < letra.length; i++) {
      balls1[i] = 0;
      balls2[i] = 0;
      balls3[i] = 0;
      balls4[i] = 0;
      balls5[i] = 0;
      balls6[i] = 0;
      if (letra[i] == '1') {
        balls1[i] = 1;
      } else if (letra[i] == "2") {
        balls1[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "A") {
        balls2[i] = 1;
        balls4[i] = 1;
        balls5[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "3") {
        balls1[i] = 1;
        balls2[i] = 1;
      } else if (letra[i] == "4") {
        balls1[i] = 1;
        balls2[i] = 1;
        balls4[i] = 1;
      } else if (letra[i] == "5") {
        balls1[i] = 1;
        balls4[i] = 1;
      } else if (letra[i] == "6") {
        balls1[i] = 1;
        balls2[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "7") {
        balls1[i] = 1;
        balls2[i] = 1;
        balls3[i] = 1;
        balls4[i] = 1;
      } else if (letra[i] == "8") {
        balls1[i] = 1;
        balls3[i] = 1;
        balls4[i] = 1;
      } else if (letra[i] == "9") {
        balls2[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "0") {
        balls2[i] = 1;
        balls3[i] = 1;
        balls4[i] = 1;
      }
    }
    notifyListeners();
  }

  translateExpressions(String letra, int id) {
    for (int i = 0; i < letra.length; i++) {
      balls1[i] = 0;
      balls2[i] = 0;
      balls3[i] = 0;
      balls4[i] = 0;
      balls5[i] = 0;
      balls6[i] = 0;
      if (letra[i] == '1') {
        balls1[i] = 1;
      } else if (letra[i] == "2") {
        balls1[i] = 1;
        balls2[i] = 1;
      } else if (letra[i] == "A") {
        balls4[i] = 1;
        balls5[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "3") {
        balls1[i] = 1;
        balls4[i] = 1;
      } else if (letra[i] == "4") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "5") {
        balls1[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "6") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls2[i] = 1;
      } else if (letra[i] == "7") {
        balls1[i] = 1;
        balls4[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "8") {
        balls1[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "9") {
        balls4[i] = 1;
        balls2[i] = 1;
      } else if (letra[i] == "0") {
        balls4[i] = 1;
        balls2[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "*") {
        balls5[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "-") {
        balls6[i] = 1;
        balls3[i] = 1;
      } else if (letra[i] == "/") {
        balls2[i] = 1;
        balls5[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "+") {
        balls3[i] = 1;
        balls4[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == "=") {
        balls3[i] = 1;
        balls4[i] = 1;
        balls5[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == "(") {
        balls1[i] = 1;
        balls3[i] = 1;
        balls6[i] = 1;
      } else if (letra[i] == ")") {
        balls2[i] = 1;
        balls4[i] = 1;
        balls5[i] = 1;
      } else if (letra[i] == " ") {
        balls1[i] = 2;
        balls2[i] = 2;
        balls3[i] = 2;
        balls4[i] = 2;
        balls5[i] = 2;
        balls6[i] = 2;
      }
    }
    notifyListeners();
  }

  reset(String letra) {
    pressedBall1 = false;
    pressedBall2 = false;
    pressedBall3 = false;
    pressedBall4 = false;
    pressedBall5 = false;
    pressedBall6 = false;
  }

  void alphabet(String letra) {
    if (letra == 'a') {
      pressedBall1 = !pressedBall1;
    } else if (letra == "b") {
      pressedBall1 = !pressedBall1;
      pressedBall3 = !pressedBall3;
    } else if (letra == "c") {
      pressedBall1 = !pressedBall1;
      pressedBall2 = !pressedBall2;
    } else if (letra == "d") {
      pressedBall1 = !pressedBall1;
      pressedBall2 = !pressedBall2;
      pressedBall4 = !pressedBall4;
    } else if (letra == "e") {
      pressedBall1 = !pressedBall1;
      pressedBall4 = !pressedBall4;
    } else if (letra == "f") {
      pressedBall1 = !pressedBall1;
      pressedBall2 = !pressedBall2;
      pressedBall3 = !pressedBall3;
    } else if (letra == "g") {
      pressedBall1 = !pressedBall1;
      pressedBall2 = !pressedBall2;
      pressedBall3 = !pressedBall3;
      pressedBall4 = !pressedBall4;
    } else if (letra == "h") {
      pressedBall1 = !pressedBall1;
      pressedBall3 = !pressedBall3;
      pressedBall4 = !pressedBall4;
    } else if (letra == "i") {
      pressedBall2 = !pressedBall2;
      pressedBall3 = !pressedBall3;
    } else if (letra == "j") {
      pressedBall2 = !pressedBall2;
      pressedBall3 = !pressedBall3;
      pressedBall4 = !pressedBall4;
    } else if (letra == "k") {
      pressedBall1 = !pressedBall1;
      pressedBall5 = !pressedBall5;
    } else if (letra == "l") {
      pressedBall1 = !pressedBall1;
      pressedBall3 = !pressedBall3;
      pressedBall5 = !pressedBall5;
    } else if (letra == "m") {
      pressedBall1 = !pressedBall1;
      pressedBall2 = !pressedBall2;
      pressedBall5 = !pressedBall5;
    } else if (letra == "n") {
      pressedBall1 = !pressedBall1;
      pressedBall2 = !pressedBall2;
      pressedBall4 = !pressedBall4;
      pressedBall5 = !pressedBall5;
    } else if (letra == "o") {
      pressedBall1 = !pressedBall1;
      pressedBall4 = !pressedBall4;
      pressedBall5 = !pressedBall5;
    } else if (letra == "p") {
      pressedBall1 = !pressedBall1;
      pressedBall2 = !pressedBall2;
      pressedBall3 = !pressedBall3;
      pressedBall5 = !pressedBall5;
    } else if (letra == "q") {
      pressedBall1 = !pressedBall1;
      pressedBall2 = !pressedBall2;
      pressedBall3 = !pressedBall3;
      pressedBall4 = !pressedBall4;
      pressedBall5 = !pressedBall5;
    } else if (letra == "r") {
      pressedBall1 = !pressedBall1;
      pressedBall3 = !pressedBall3;
      pressedBall4 = !pressedBall4;
      pressedBall5 = !pressedBall5;
    } else if (letra == "s") {
      pressedBall2 = !pressedBall2;
      pressedBall3 = !pressedBall3;
      pressedBall5 = !pressedBall5;
    } else if (letra == "t") {
      pressedBall2 = !pressedBall2;
      pressedBall3 = !pressedBall3;
      pressedBall4 = !pressedBall4;
      pressedBall5 = !pressedBall5;
    } else if (letra == "u") {
      pressedBall1 = !pressedBall1;
      pressedBall5 = !pressedBall5;
      pressedBall6 = !pressedBall6;
    } else if (letra == "v") {
      pressedBall1 = !pressedBall1;
      pressedBall3 = !pressedBall3;
      pressedBall5 = !pressedBall5;
      pressedBall6 = !pressedBall6;
    } else if (letra == "w") {
      pressedBall2 = !pressedBall2;
      pressedBall3 = !pressedBall3;
      pressedBall4 = !pressedBall4;
      pressedBall6 = !pressedBall6;
    } else if (letra == "x") {
      pressedBall1 = !pressedBall1;
      pressedBall2 = !pressedBall2;
      pressedBall5 = !pressedBall5;
      pressedBall6 = !pressedBall6;
    } else if (letra == "y") {
      pressedBall1 = !pressedBall1;
      pressedBall2 = !pressedBall2;
      pressedBall4 = !pressedBall4;
      pressedBall5 = !pressedBall5;
      pressedBall6 = !pressedBall6;
    } else if (letra == "z") {
      pressedBall1 = !pressedBall1;
      pressedBall4 = !pressedBall4;
      pressedBall5 = !pressedBall5;
      pressedBall6 = !pressedBall6;
    }
    notifyListeners();
  }

  braille_translator(String texto) {
    Map<String, String> brailleMap = {
      'a': '⠁',
      'b': '⠃',
      'c': '⠉',
      'd': '⠙',
      'e': '⠑',
      'f': '⠋',
      'g': '⠛',
      'h': '⠓',
      'i': '⠊',
      'j': '⠚',
      'k': '⠅',
      'l': '⠇',
      'm': '⠍',
      'n': '⠝',
      'o': '⠕',
      'p': '⠏',
      'q': '⠟',
      'r': '⠗',
      's': '⠎',
      't': '⠞',
      'u': '⠥',
      'v': '⠧',
      'w': '⠺',
      'x': '⠭',
      'y': '⠽',
      'z': '⠵',
      ' ': '  ',
      'A': '⠨',
      'B': '⠼',
      '1': '⠁',
      '2': '⠃',
      '3': '⠉',
      '4': '⠙',
      '5': '⠑',
      '6': '⠋',
      '7': '⠛',
      '8': '⠓',
      '9': '⠊',
      '0': '⠚',
      '*': '⠔',
      '/': '⠲',
      '=': '⠶',
      'á': '⠷',
      'é': '⠿',
      'í': '⠌',
      'ó': '⠬',
      'ú': '⠾',
      'à': '⠫',
      'â': '⠡',
      'ê': '⠣',
      'ô': '⠹',
      'ã': '⠜',
      'õ': '⠪',
      'ç': '⠯',
      ',': '⠂',
      ';': '⠆',
      '.': '⠄',
      ':': '⠒',
      '?': '⠢',
      '!': '⠖',
      '-': '⠤',
      '+': '⠖',
      '(': '⠣',
      ')': '⠜',
      '&': '⠯',
      '[': '',
      ']': '',
      '°': '⠴',
      '÷': '⠲',
      '×': '⠦',
      '#': '⠼',
      '\$': '⠰' 

    };

    String brailleText = '';
    for (int i = 0; i < texto.length; i++) {
      brailleText += brailleMap[texto[i]] ?? '';
    }

    return brailleText;
  }

  //  void numbers (String numero){
  //   pressedBall11 = false;
  //   pressedBall22 = true;
  //   pressedBall33 = false;
  //   pressedBall44 = true;
  //   pressedBall55 = true;
  //   pressedBall66 = true;
  //   if (numero =='1'){
  //     pressedBall1=!pressedBall1;
  //     }
  //   else if (numero=="2"){
  //     pressedBall1=!pressedBall1;
  //     pressedBall3=!pressedBall3;
  //   }
  //   else if (numero=="3"){
  //     pressedBall1=!pressedBall1;
  //     pressedBall2=!pressedBall2;
  //   }
  //   else if (numero=="4"){
  //     pressedBall1=!pressedBall1;
  //     pressedBall2=!pressedBall2;
  //     pressedBall4=!pressedBall4;
  //   }
  //   else if (numero=="5"){
  //     pressedBall1=!pressedBall1;
  //     pressedBall4=!pressedBall4;
  //   }
  //   else if (numero=="6"){
  //     pressedBall1=!pressedBall1;
  //     pressedBall2=!pressedBall2;
  //     pressedBall3=!pressedBall3;
  //   }
  //   else if (numero=="7"){
  //     pressedBall1=!pressedBall1;
  //     pressedBall2=!pressedBall2;
  //     pressedBall3=!pressedBall3;
  //     pressedBall4=!pressedBall4;
  //   }
  //   else if (numero=="8"){
  //     pressedBall1=!pressedBall1;
  //     pressedBall3=!pressedBall3;
  //     pressedBall4=!pressedBall4;
  //   }
  //   else if (numero=="9"){
  //     pressedBall2=!pressedBall2;
  //     pressedBall3=!pressedBall3;
  //   }
  //   notifyListeners();
  //  }

  List<bool> c1L = [];
  List<bool> c2L = [];
  List<bool> c3L = [];
  List<bool> c4L = [];
  List<bool> c5L = [];
  List<bool> c6L = [];
  int aux = 0;
  List separaCaracteres = List.filled(100, '');

  String cell_translator(
      bool c1, bool c2, bool c3, bool c4, bool c5, bool c6, List numMatrizes) {
    String letra = '';

    for (int i = 0; i < numMatrizes.length; i++) {
      if (c1 == true &&
          c2 == false &&
          c3 == false &&
          c4 == false &&
          c5 == false &&
          c6 == false) {
        letra = '${letra}a';
      } else if (c1 == true &&
          c2 == true &&
          c3 == false &&
          c4 == false &&
          c5 == false &&
          c6 == false) {
        letra = '${letra}b';
      } else if (c1 == true &&
          c2 == false &&
          c3 == false &&
          c4 == true &&
          c5 == false &&
          c6 == false) {
        letra = '${letra}c';
      } else if (c1 == true &&
          c2 == false &&
          c3 == false &&
          c4 == true &&
          c5 == true &&
          c6 == false) {
        letra = '${letra}d';
      } else if (c1 == true &&
          c2 == false &&
          c3 == false &&
          c4 == false &&
          c5 == true &&
          c6 == false) {
        letra = '${letra}e';
      } else if (c1 == true &&
          c2 == true &&
          c3 == false &&
          c4 == true &&
          c5 == false &&
          c6 == false) {
        letra = '${letra}f';
      } else if (c1 == true &&
          c2 == true &&
          c3 == false &&
          c4 == true &&
          c5 == true &&
          c6 == false) {
        letra = '${letra}g';
      } else if (c1 == true &&
          c2 == true &&
          c3 == false &&
          c4 == false &&
          c5 == true &&
          c6 == false) {
        letra = '${letra}h';
      } else if (c1 == false &&
          c2 == true &&
          c3 == false &&
          c4 == true &&
          c5 == false &&
          c6 == false) {
        letra = '${letra}i';
      } else if (c1 == false &&
          c2 == true &&
          c3 == false &&
          c4 == true &&
          c5 == true &&
          c6 == false) {
        letra = '${letra}j';
      } else if (c1 == true &&
          c2 == false &&
          c3 == true &&
          c4 == false &&
          c5 == false &&
          c6 == false) {
        letra = '${letra}k';
      } else if (c1 == true &&
          c2 == true &&
          c3 == true &&
          c4 == false &&
          c5 == false &&
          c6 == false) {
        letra = '${letra}l';
      } else if (c1 == true &&
          c2 == false &&
          c3 == true &&
          c4 == true &&
          c5 == false &&
          c6 == false) {
        letra = '${letra}m';
      } else if (c1 == true &&
          c2 == false &&
          c3 == true &&
          c4 == true &&
          c5 == true &&
          c6 == false) {
        letra = '${letra}n';
      } else if (c1 == true &&
          c2 == false &&
          c3 == true &&
          c4 == false &&
          c5 == true &&
          c6 == false) {
        letra = '${letra}o';
      } else if (c1 == true &&
          c2 == true &&
          c3 == true &&
          c4 == true &&
          c5 == false &&
          c6 == false) {
        letra = '${letra}p';
      } else if (c1 == true &&
          c2 == true &&
          c3 == true &&
          c4 == true &&
          c5 == true &&
          c6 == false) {
        letra = '${letra}q';
      } else if (c1 == true &&
          c2 == true &&
          c3 == true &&
          c4 == false &&
          c5 == true &&
          c6 == false) {
        letra = '${letra}r';
      } else if (c1 == false &&
          c2 == true &&
          c3 == true &&
          c4 == true &&
          c5 == false &&
          c6 == false) {
        letra = '${letra}s';
      } else if (c1 == false &&
          c2 == true &&
          c3 == true &&
          c4 == true &&
          c5 == true &&
          c6 == false) {
        letra = '${letra}t';
      } else if (c1 == true &&
          c2 == false &&
          c3 == true &&
          c4 == false &&
          c5 == false &&
          c6 == true) {
        letra = '${letra}u';
      } else if (c1 == true &&
          c2 == true &&
          c3 == true &&
          c4 == false &&
          c5 == false &&
          c6 == true) {
        letra = '${letra}v';
      } else if (c1 == false &&
          c2 == true &&
          c3 == false &&
          c4 == true &&
          c5 == true &&
          c6 == true) {
        letra = '${letra}w';
      } else if (c1 == true &&
          c2 == false &&
          c3 == true &&
          c4 == true &&
          c5 == false &&
          c6 == true) {
        letra = '${letra}x';
      } else if (c1 == true &&
          c2 == false &&
          c3 == true &&
          c4 == true &&
          c5 == true &&
          c6 == true) {
        letra = '${letra}y';
      } else if (c1 == true &&
          c2 == false &&
          c3 == true &&
          c4 == false &&
          c5 == true &&
          c6 == true) {
        letra = '${letra}z';
      } else if (c1 == false &&
          c2 == false &&
          c3 == false &&
          c4 == false &&
          c5 == false &&
          c6 == false) {
        letra = letra;
      }
    }

    return letra;
  }
}

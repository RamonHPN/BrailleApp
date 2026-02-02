// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, duplicate_ignore

import 'package:braille_app/components/matriz_maiuscula.dart';
import 'package:braille_app/components/matriz_numero.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:braille_app/components/ball.dart';

class Matriz extends StatefulWidget {
  const Matriz({super.key});

  @override
  State<Matriz> createState() => _MatrizState();
}

class _MatrizState extends State<Matriz> {
  bool isClicked1 = false;
  bool isClicked2 = false;
  bool isClicked3 = false;
  bool isClicked4 = false;
  bool isClicked5 = false;
  bool isClicked6 = false;
  int indice = 0;
  bool maiuscula = false;
  bool numero = false;
  String letraAtual = "_"; // Placeholder antes de submeter

  // Lógica para a célula Braille
  void novaLetra() {
    setState(() {
      isClicked1 = false;
      isClicked2 = false;
      isClicked3 = false;
      isClicked4 = false;
      isClicked5 = false;
      isClicked6 = false;
      letraAtual = "_"; // Reseta a letra antes de submeter
    });
  }

  void submeterLetra() {
    final ball = Provider.of<Ball>(context, listen: false);
    final translatedLetter = numero ? number_translator() : cell_translator();

    if (translatedLetter.isEmpty) {
      // Mostra uma mensagem de erro se for inválido
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Caractere inválido'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return; // Interrompe o envio
    }

    setState(() {
      if (indice >= ball.separaCaracteres.length) {
        ball.separaCaracteres.add(translatedLetter);
      } else {
        ball.separaCaracteres[indice] = translatedLetter;
      }

      // ignore: invalid_use_of_protected_member
      ball.notifyListeners();
      indice++;
      novaLetra();
    });
  }

  void voltarLetra() {
    final ball = Provider.of<Ball>(context, listen: false);
    if (indice > 0) {
      setState(() {
        indice--; // Volta um caractere
        ball.separaCaracteres[indice] = "_"; // Reseta a posição anterior
        ball.notifyListeners();
        novaLetra(); // Reseta os botões
      });
    }
  }

  void limpar() {
    final ball = Provider.of<Ball>(context, listen: false);
    setState(() {
      ball.separaCaracteres = List<String>.from(['_']); // Reinicia corretamente
      isClicked1 = false;
      isClicked2 = false;
      isClicked3 = false;
      isClicked4 = false;
      isClicked5 = false;
      isClicked6 = false;
      indice = 0;
      ball.notifyListeners();
    });
  }

  void toggleBall1() => setState(() => isClicked1 = !isClicked1);
  void toggleBall2() => setState(() => isClicked2 = !isClicked2);
  void toggleBall3() => setState(() => isClicked3 = !isClicked3);
  void toggleBall4() => setState(() => isClicked4 = !isClicked4);
  void toggleBall5() => setState(() => isClicked5 = !isClicked5);
  void toggleBall6() => setState(() => isClicked6 = !isClicked6);

  void habilitaMaiuscula() {
    setState(() {
      maiuscula = !maiuscula;
      if (maiuscula) numero = false; // Desabilita número ao ativar maiúscula
    });
  }

  void habilitaNumero() {
    setState(() {
      numero = !numero;
      if (numero) maiuscula = false; // Desabilita maiúscula ao ativar número
    });
  }

  // ignore: non_constant_identifier_names
  String number_translator() {
    if (isClicked1 &&
        !isClicked2 &&
        !isClicked3 &&
        !isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return '1';
    }
    if (isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        !isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return '2';
    }
    if (isClicked1 &&
        !isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return '3';
    }
    if (isClicked1 &&
        !isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return '4';
    }
    if (isClicked1 &&
        !isClicked2 &&
        !isClicked3 &&
        !isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return '5';
    }
    if (isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return '6';
    }
    if (isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return '7';
    }
    if (isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        !isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return '8';
    }
    if (!isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return '9';
    }
    if (!isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return '0';
    }
    return '';
  }

  // ignore: non_constant_identifier_names
  String cell_translator() {
    // Lógica para tradução dos caracteres (como no código original)
    if (isClicked1 &&
        !isClicked2 &&
        !isClicked3 &&
        !isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'A' : 'a';
    }
    if (isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        !isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'B' : 'b';
    }
    if (isClicked1 &&
        !isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'C' : 'c';
    }
    if (isClicked1 &&
        !isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'D' : 'd';
    }
    if (isClicked1 &&
        !isClicked2 &&
        !isClicked3 &&
        !isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'E' : 'e';
    }
    if (isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'F' : 'f';
    }
    if (isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'G' : 'g';
    }
    if (isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        !isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'H' : 'h';
    }
    if (!isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'I' : 'i';
    }
    if (!isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'J' : 'j';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        !isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'K' : 'k';
    }
    if (isClicked1 &&
        isClicked2 &&
        isClicked3 &&
        !isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'L' : 'l';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'M' : 'm';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'N' : 'n';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        !isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'O' : 'o';
    }
    if (isClicked1 &&
        isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'P' : 'p';
    }
    if (isClicked1 &&
        isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'Q' : 'q';
    }
    if (isClicked1 &&
        isClicked2 &&
        isClicked3 &&
        !isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'R' : 'r';
    }
    if (!isClicked1 &&
        isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'S' : 's';
    }
    if (!isClicked1 &&
        isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return maiuscula ? 'T' : 't';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        !isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'U' : 'u';
    }
    if (isClicked1 &&
        isClicked2 &&
        isClicked3 &&
        !isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'V' : 'v';
    }
    if (!isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        isClicked6) {
      return maiuscula ? 'W' : 'w';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'X' : 'x';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        isClicked6) {
      return maiuscula ? 'Y' : 'y';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        !isClicked4 &&
        isClicked5 &&
        isClicked6) {
      return maiuscula ? 'Z' : 'z';
    }
    // if (isClicked1 &&
    //     !isClicked2 &&
    //     !isClicked3 &&
    //     !isClicked4 &&
    //     !isClicked5 &&
    //     !isClicked6) {
    //   return '1';
    // }
    // if (!isClicked1 &&
    //     !isClicked2 &&
    //     isClicked3 &&
    //     isClicked4 &&
    //     isClicked5 &&
    //     isClicked6) {
    //   return '2';
    // }
    // if (isClicked1 &&
    //     !isClicked2 &&
    //     !isClicked3 &&
    //     isClicked4 &&
    //     !isClicked5 &&
    //     !isClicked6) {
    //   return '3';
    // }
    // if (isClicked1 &&
    //     !isClicked2 &&
    //     !isClicked3 &&
    //     isClicked4 &&
    //     isClicked5 &&
    //     !isClicked6) {
    //   return '4';
    // }
    // if (isClicked1 &&
    //     !isClicked2 &&
    //     !isClicked3 &&
    //     !isClicked4 &&
    //     isClicked5 &&
    //     !isClicked6) {
    //   return '5';
    // }
    // if (isClicked1 &&
    //     isClicked2 &&
    //     !isClicked3 &&
    //     isClicked4 &&
    //     !isClicked5 &&
    //     !isClicked6) {
    //   return '6';
    // }
    // if (isClicked1 &&
    //     isClicked2 &&
    //     !isClicked3 &&
    //     isClicked4 &&
    //     isClicked5 &&
    //     !isClicked6) {
    //   return '7';
    // }
    // if (isClicked1 &&
    //     isClicked2 &&
    //     !isClicked3 &&
    //     !isClicked4 &&
    //     isClicked5 &&
    //     !isClicked6) {
    //   return '8';
    // }
    // if (!isClicked1 &&
    //     isClicked2 &&
    //     !isClicked3 &&
    //     isClicked4 &&
    //     !isClicked5 &&
    //     !isClicked6) {
    //   return '9';
    // }
    // if (!isClicked1 &&
    //     isClicked2 &&
    //     !isClicked3 &&
    //     isClicked4 &&
    //     isClicked5 &&
    //     !isClicked6) {
    //   return '0';
    // }
    if (!isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return '*';
    }
    if (!isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return '-';
    }
    if (!isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return '+';
    }
    if (!isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return '/';
    }
    if (!isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return '=';
    }
    if (!isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return '(';
    }
    if (!isClicked1 &&
        isClicked2 &&
        !isClicked3 &&
        isClicked4 &&
        isClicked5 &&
        !isClicked6) {
      return ')';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'Á' : 'Á';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'É' : 'é';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'Í' : 'í';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'Ó' : 'ó';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'Ú' : 'ú';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'À' : 'à';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'Â' : 'â';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'Ê' : 'ê';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'Ô' : 'ô';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'Ã' : 'ã';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'Õ' : 'õ';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return maiuscula ? 'Ç' : 'ç';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return ',';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return ';';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return ':';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return '.';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return '?';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return '!';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return '&';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return '|';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return '>';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return '<';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return '°';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return '"';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return '\$';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return '[';
    }
    if (isClicked1 &&
        !isClicked2 &&
        isClicked3 &&
        isClicked4 &&
        !isClicked5 &&
        isClicked6) {
      return ']';
    }
    if (!isClicked1 &&
        !isClicked2 &&
        !isClicked3 &&
        !isClicked4 &&
        !isClicked5 &&
        !isClicked6) {
      return ' ';
    }
    // ... o restante da lógica continua igual para os outros caracteres Braille
    return "";
  }

  bool espelhado = false;

  void habilitaReglete() {
    setState(() {
      espelhado = !espelhado;
    });
  }

  void excluirUltimoCaractere() {
    final ball = Provider.of<Ball>(context, listen: false);
    if (indice > 0 && ball.separaCaracteres.isNotEmpty) {
      setState(() {
        indice--; // Retrocede o índice
        ball.separaCaracteres =
            List.from(ball.separaCaracteres); // Garante que a lista é mutável
        ball.separaCaracteres.removeAt(indice); // Remove o último caractere
        ball.notifyListeners();
        novaLetra(); // Reseta os botões
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: 50),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
      onTap: habilitaMaiuscula,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: maiuscula
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF208B52),
              )
            : null,
        child: Icon(
          Icons.format_size,
          color: maiuscula ? Colors.white : Colors.black,
        ),
      ),
    ),
    const Text('Caixa alta', style: TextStyle(fontSize: 10)),
                  ],
                ),
                SizedBox(
                  width: 35,
                ),
                Column(
                  children: [
                    GestureDetector(
      onTap: habilitaReglete,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: espelhado
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF208B52),
              )
            : null,
        child: Icon(
          Icons.flip,
          color: espelhado ? Colors.white : Colors.black,
        ),
      ),
    ),
    const Text('Reglete', style: TextStyle(fontSize: 10)),
                  ],
                ),
                SizedBox(
                  width: 35,
                ),
                Column(
                  children: [
                    GestureDetector(
      onTap: habilitaNumero,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: numero
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF208B52),
              )
            : null,
        child: Icon(
          Icons.numbers,
          color: numero ? Colors.white : Colors.black,
        ),
      ),
    ),
    const Text('Número', style: TextStyle(fontSize: 10)),
                  ],
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              child: Stack(
                children: [
                  Visibility(
                    visible: maiuscula,
                    child: MatrizMaiuscula(),
                  ),
                  Visibility(
                    visible: numero,
                    child: MatrizNumero(),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.5, // largura proporcional à tela
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(espelhado ? '4' : '1',
                          style: TextStyle(fontSize: 16)),
                      IconButton(
                        iconSize: 50,
                        onPressed: espelhado ? toggleBall4 : toggleBall1,
                        icon: Icon((espelhado ? isClicked4 : isClicked1)
                            ? Icons.circle
                            : Icons.circle_outlined),
                      ),
                      IconButton(
                        iconSize: 50,
                        onPressed: espelhado ? toggleBall1 : toggleBall4,
                        icon: Icon((espelhado ? isClicked1 : isClicked4)
                            ? Icons.circle
                            : Icons.circle_outlined),
                      ),
                      Text(espelhado ? '1' : '4',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(espelhado ? '5' : '2',
                          style: TextStyle(fontSize: 16)),
                      IconButton(
                        iconSize: 50,
                        onPressed: espelhado ? toggleBall5 : toggleBall2,
                        icon: Icon((espelhado ? isClicked5 : isClicked2)
                            ? Icons.circle
                            : Icons.circle_outlined),
                      ),
                      IconButton(
                        iconSize: 50,
                        onPressed: espelhado ? toggleBall2 : toggleBall5,
                        icon: Icon((espelhado ? isClicked2 : isClicked5)
                            ? Icons.circle
                            : Icons.circle_outlined),
                      ),
                      Text(espelhado ? '2' : '5',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(espelhado ? '6' : '3',
                          style: TextStyle(fontSize: 16)),
                      IconButton(
                        iconSize: 50,
                        onPressed: espelhado ? toggleBall6 : toggleBall3,
                        icon: Icon((espelhado ? isClicked6 : isClicked3)
                            ? Icons.circle
                            : Icons.circle_outlined),
                      ),
                      IconButton(
                        iconSize: 50,
                        onPressed: espelhado ? toggleBall3 : toggleBall6,
                        icon: Icon((espelhado ? isClicked3 : isClicked6)
                            ? Icons.circle
                            : Icons.circle_outlined),
                      ),
                      Text(espelhado ? '3' : '6',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
  onPressed: submeterLetra,
  style: ElevatedButton.styleFrom(
    shape: const CircleBorder(),
    padding: const EdgeInsets.all(10),   // controla o tamanho do círculo
    backgroundColor: Color(0xFF208B52),       // cor de fundo do círculo
    foregroundColor: Colors.white,       // cor do ícone
    elevation: 4,
  ),
  child: const Icon(
    Icons.arrow_forward,                // seta para a direita
    size: 24,
    color: Colors.white,
  ),
),
SizedBox(height: 10,),
                Text(
                  'Traduzir',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        // Adiciona os outros botões de Braille
        SizedBox(height: 30),
        SizedBox(
          width: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 30,
            ),
            IconButton(
              onPressed: excluirUltimoCaractere,
              icon: Icon(Icons.backspace_outlined),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ],
    );
  }
}

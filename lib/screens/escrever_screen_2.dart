// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:braille_app/components/matriz.dart';
import 'package:braille_app/components/ball.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EscreverScreen2 extends StatefulWidget {
  const EscreverScreen2({super.key});

  @override
  State<EscreverScreen2> createState() => _EscreverScreen2State();
}

class _EscreverScreen2State extends State<EscreverScreen2> {
  late TextEditingController _controller;
  late Ball ball;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    ball = Provider.of<Ball>(context);
    _controller.text =
        ball.separaCaracteres.isEmpty ? "_" : ball.separaCaracteres.join('');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escrever em Braile'),
      ),
      body: Column(
        children: [
          Matriz(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _controller,
              showCursor: false,
              readOnly: true,
              maxLines: null, // Permite múltiplas linhas
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: _clearText, // Chama a função de limpar
                      )
                    : null, // Esconde o botão quando o texto estiver vazio
              ),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              onChanged: (text) {
                ball.separaCaracteres = text.split('');
              },
              onTap: () {
                if (_controller.text == "_") {
                  _controller.text = "";
                  ball.separaCaracteres.clear();
                }
              },
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          const SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     IconButton(
          //       onPressed: _handleBackspace,
          //       icon: Icon(Icons.backspace_outlined),
          //     ),
          //     const SizedBox(width: 10),
          //     IconButton(onPressed: _clearText, icon: Icon(Icons.delete)),
          //   ],
          // ),
        ],
      ),
    );
  }

  void _clearText() {
    setState(() {
      // Substitui cada elemento da lista por uma string vazia
      for (int i = 0; i < ball.separaCaracteres.length; i++) {
        ball.separaCaracteres[i] = '';
      }

      _controller.text = ball.separaCaracteres.join(''); // Atualiza o TextField
      ball.notifyListeners(); // Notifica para atualizar o estado do Provider
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

import 'package:braille_app/components/translation.dart';
import 'package:braille_app/components/ball.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhraseTranslatorScreen extends StatelessWidget {
  const PhraseTranslatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<Ball>(context);
    // var texto = ball.braille_translator('teste');
    return Scaffold(
      appBar: AppBar(
        title: Text("Tradução"),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFDDE9DD),
      body: Column(
        children: [
          Translation(),
          //  MatrizShowed(),
          //  CaracterTranslator()
        ],
      ),
    );
  }
}

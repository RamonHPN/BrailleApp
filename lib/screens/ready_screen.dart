import 'package:braille_app/components/finished.dart';
import 'package:flutter/material.dart';

class ReadyScreen extends StatelessWidget {
  const ReadyScreen({super.key});
  void _interface(BuildContext context) {
    Navigator.of(context).pushNamed('/interface-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Finished(
      image: 'assets/images/Isolation_Mode.png',
      negrito: "Vamos começar a decifrar o Braille?",
      texto: 'Desvende o mundo do Braille de forma divertida e interativa com vBraille!',
      botao: 'Continuar',
      rota: (){
        _interface(context);
      },
    );
  }
}

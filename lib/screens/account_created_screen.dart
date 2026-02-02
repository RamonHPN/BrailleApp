// ignore_for_file: non_constant_identifier_names

import 'package:braille_app/services/auth.dart';
import 'package:braille_app/components/finished.dart';
import 'package:braille_app/services/information_1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountCreatedScreen extends StatelessWidget {
  const AccountCreatedScreen({super.key});

  void _about_you_1(BuildContext context) {
    Navigator.of(context).pushNamed('/about-you-1-screen');
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final name = Provider.of<Information1>(context);
    return Finished(
        image: 'assets/images/Layer_1.png',
        negrito: "Estamos felizes por você estar aqui!",
        texto: 'Seu perfil foi criado com sucesso.',
        botao: 'Continuar',
        rota: () {
          _about_you_1(context);
          name.saveName(auth.token ?? '', auth.userId ?? '');
        });
  }
}

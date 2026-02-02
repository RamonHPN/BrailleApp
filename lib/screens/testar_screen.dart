import 'package:braille_app/services/auth.dart';
import 'package:braille_app/models/modulos.dart';
import 'package:braille_app/components/finished.dart';
import 'package:braille_app/services/passer.dart';
import 'package:braille_app/services/topico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestarScreen extends StatelessWidget {
  const TestarScreen({super.key});

  void _quest_1(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Modulo fase = args['fase'];
    final Topico topico = args['topico'];
    final Passer passer = args['passer'];
    Provider.of<Auth>(context, listen: false);
    // if (passer.topicoCompleto <= topico.id) {
    //   passer.incrementaFracao(passer, topico, fase, auth.token??'', auth.userId??"");
    // }
    Navigator.of(context).pushNamed('/quest-1-screen',
        arguments: {'fase': fase, "topico": topico, 'passer': passer});
  }

  @override
  Widget build(BuildContext context) {
    return Finished(
      image: 'assets/images/Group46.png',
      negrito: 'Agora vamos testar seus conhecimentos!',
      texto: 'Pronto para o questionário final?',
      botao: 'Continuar',
      rota: () => _quest_1(context),
    );
  }
}

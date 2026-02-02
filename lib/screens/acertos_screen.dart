// ignore_for_file: unused_local_variable

import 'package:braille_app/data/topicos_data.dart';
import 'package:braille_app/services/auth.dart';
import 'package:braille_app/models/modulos.dart';
import 'package:braille_app/components/finished.dart';
import 'package:braille_app/services/passer.dart';
import 'package:braille_app/services/topico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcertosScreen extends StatelessWidget {
  const AcertosScreen({super.key});

  void _topicos(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Modulo fase = args['fase'];
    final Topico topico = args['topico'];
    final passer = Provider.of<Passer>(context, listen: false);
    if (passer.topicoCompleto == topico.id) {
      passer.incrementaTopico(topico);
    }
    passer.salvaTopico(topico, auth.token ?? '', auth.userId ?? '');

    if (topicos_data[passer.faseCompleta - 1].length ==
        int.parse(topico.number)) {
      passer.incrementaFaset(fase, topico, auth.token ?? "", auth.userId ?? '');
    }
    passer.salvaModulo(fase, auth.token ?? "", auth.userId ?? "");
    Navigator.of(context).popUntil(ModalRoute.withName('/fases-screen'));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final auth = Provider.of<Auth>(context, listen: false);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Modulo fase = args['fase'];
    final Topico topico = args['topico'];
    return Finished(
      image: 'assets/images/Group48.png',
      negrito:
          'Você acertou ${topico.acertou} de ${topico.perguntas.length} perguntas!',
      texto: '',
      botao: 'Concluir',
      rota: () => _topicos(context),
    );
  }
}

// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'package:braille_app/services/auth.dart';
import 'package:braille_app/models/modulos.dart';
import 'package:braille_app/services/passer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Topico extends StatelessWidget with ChangeNotifier {
  int id;
  String number;
  String title;
  VoidCallback? rota;
  String conteudo;
  List videos;
  List titulos;
  List conteudos;
  List perguntas;
  List respostas;
  List acertos;
  int numTelas;
  num avanco;
  int checkpoint = 0;

  Topico({
    super.key,
    this.id = 1,
    this.number = '',
    this.title = '',
    this.rota,
    this.conteudo = '',
    this.videos = const [],
    this.titulos = const [],
    this.conteudos = const [],
    this.perguntas = const [],
    this.respostas = const [],
    this.acertos = const [],
    this.numTelas = 0,
    this.avanco = 0,
  });
  int acertou = 0;
  void qnt_acertos() {
    acertou++;
  }

  @override
  Widget build(BuildContext context) {
    final passer = Provider.of<Passer>(context);
    void topic1f(BuildContext context) async {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final Modulo fase = args['fase'];
      final Topico topico = this;
      final Passer passer = args['passer'];
      final auth = Provider.of<Auth>(context, listen: false);
      await passer.getLugar(fase, topico, auth.token ?? '', auth.userId ?? '');
      String caminho = '/topic-1-screen';
      checkpoint = passer.chek;
      print("teste2${passer.chek}");
      if (checkpoint == 1) {
        caminho = '/topico-1-conteudo-screen';
      } else if (checkpoint == 2) {
        caminho = '/quest-1-screen';
      } else {
        caminho = '/topic-1-screen';
      }
      await passer.getIndice(fase, topico, auth.token ?? '', auth.userId ?? '');
      print("i1${passer.indice}");
      Navigator.of(context).pushNamed(caminho,
          arguments: {'fase': fase, 'topico': topico, "passer": passer});
    }

    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            margin: EdgeInsets.only(right: 20, left: 30),
            child: Text(
              number,
              style: TextStyle(
                color: Color(0xFF00210E),
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: passer.topicoCompleto >= id
                ? IconButton(
                    onPressed: () => topic1f(context),
                    icon: Icon(
                      Icons.play_circle,
                      color: Color(0xFF208B52),
                      size: 30,
                    ),
                  )
                : IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.lock,
                      color: Color(0xFFACC9B8),
                      size: 30,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

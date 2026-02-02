// ignore_for_file: avoid_print

import 'package:braille_app/data/topicos_data.dart';
import 'package:braille_app/models/modulos.dart';
import 'package:braille_app/services/passer.dart';
import 'package:braille_app/services/topico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:braille_app/services/auth.dart';

class FaseScreen extends StatefulWidget {
  const FaseScreen({super.key});

  @override
  State<FaseScreen> createState() => _FaseScreenState();
}

class _FaseScreenState extends State<FaseScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final fracao = Provider.of<Passer>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Modulo modulo = args['fase'];

    fracao.getTelaT(modulo, auth.token ?? '', auth.userId ?? '');
  }

  int calcularTotalTelasPorModulo(List<Topico> modulo) {
    int totalVideos = 0;
    int totalPerguntas = 0;

    for (var topico in modulo) {
      totalVideos += topico.videos.length;
      totalPerguntas += topico.perguntas.length;
    }

    return totalVideos + totalPerguntas;
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Modulo modulo = args['fase'];
    final List<List<Topico>> topicos = topicos_data;
    int telas = calcularTotalTelasPorModulo(topicos[modulo.id - 1]);

    if (telas == 0) {
      telas = 1;
    }
    print("telas$telas");

    return Scaffold(
      backgroundColor: Color(0xFFDDE9DD),
      appBar: AppBar(
        title: Text(
            '${ModalRoute.of(context)!.settings.arguments != null ? (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>)['fase'].title : 'Modulo'}'),
        backgroundColor: Color(0xFFF1FEF1),
        centerTitle: true,
        actions: [
          Container(
            width: MediaQuery.of(context).size.width * 20 / 360,
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 25 / 360),
            child: Image.asset('assets/images/muiraq_preto.png'),
          )
        ],
      ),
      body: Consumer<Passer>(builder: (ctx, fracao, child) {
        double screenWidth = MediaQuery.of(context).size.width;
        final List<Topico> topicosModulo = topicos[modulo.id - 1];

        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black)),
              ),
              child: Container(
                color: Color(0xFFF1FEF1),
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Image.asset('assets/images/modulo1.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Introdução ao Braille",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          width: screenWidth - 200,
                          child: Text(
                            'Este módulo tem como objetivo proporcionar uma compreensão abrangente do sistema Braille e destacar sua relevância crucial na educação de pessoas com deficiência visual',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 30),
                          child: Text(
                            '${(((fracao.fracaoT) / telas) * 100).toInt()}% concluído',
                            style: TextStyle(
                              color: Color(0xFF208B52),
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: 10,
              child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: fracao.fracaoT / telas,
                    child: Container(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: topicosModulo.length,
                itemBuilder: (context, index) {
                  return topicosModulo[index];
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

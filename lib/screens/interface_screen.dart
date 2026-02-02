// ignore_for_file: unused_local_variable, avoid_print

import 'package:braille_app/services/auth.dart';
import 'package:braille_app/services/graphic.dart';
import 'package:braille_app/services/information_1.dart';
import 'package:braille_app/services/passer.dart';
import 'package:braille_app/services/topico.dart';
// ignore: unused_import
import 'package:braille_app/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:braille_app/data/topicos_data.dart';

Map<String, int> calcularTotalVideosEPerguntas(List<List<Topico>> topicosData) {
  int totalVideos = 0;
  int totalPerguntas = 0;

  for (var listaTopicos in topicosData) {
    for (var topico in listaTopicos) {
      totalVideos += topico.videos.length;
      totalPerguntas += topico.perguntas.length;
    }
  }

  return {
    'totalVideos': totalVideos,
    'totalPerguntas': totalPerguntas,
  };
}

class Interface extends StatefulWidget {
  const Interface({super.key});

  @override
  State<Interface> createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final auth = Provider.of<Auth>(context, listen: false);
    Provider.of<Information1>(context, listen: false)
        .getDados(auth.token ?? "", auth.userId ?? "");
  }

  void _modulos(BuildContext context) {
    final modulo = Provider.of<Passer>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    modulo.getModulo(auth.token ?? '', auth.userId ?? "");
    modulo.getTopico(auth.token ?? '', auth.userId ?? "");
    modulo.getTelaM(auth.token ?? '', auth.userId ?? "");
    var resultado = calcularTotalVideosEPerguntas(topicos_data);
    int totalVideos = resultado['totalVideos'] ?? 0;
    int totalPerguntas = resultado['totalPerguntas'] ?? 0;
    print(totalPerguntas + totalVideos);
    // Navigator.of(context).pushNamed(
    //   '/tabs-screen-2',
    //   arguments: {
    //     'initialIndex': 1,
    //     'totalVideos': totalVideos,
    //     'totalPerguntas': totalPerguntas,
    //   },
    // );
  }

  void _learn(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/tabs-screen-2',
      arguments: {'initialIndex': 0},
    );
  }

  void _traduzir(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/tabs-screen-2',
      arguments: {'initialIndex': 1},
    );
  }

  void _escrever(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/tabs-screen-2',
      arguments: {'initialIndex': 2},
    );
  }

  final bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final graphic = Provider.of<Graphic>(context);
    final auth = Provider.of<Auth>(context);

    // Chama a função aqui e armazena os resultados
    var resultado = calcularTotalVideosEPerguntas(topicos_data);
    int totalVideos = resultado['totalVideos'] ?? 0;
    int totalPerguntas = resultado['totalPerguntas'] ?? 0;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.all(29),
              margin: const EdgeInsets.only(top: 100, bottom: 5),
              alignment: Alignment.center,
              width: screenWidth * 290 / 360,
              height: screenHeight * 150 / 360,
              child: Image.asset(
                'assets/images/interface_braille.png',
                fit: BoxFit.fill,
              ),
            ),
            // Container(
            // //  alignment: Alignment.center,
            //   height: screenHeight * 20 / 360,
            //   child: const Text('vBraille',
            //       style: TextStyle(
            //           color: Colors.black,
            //           fontWeight: FontWeight.w700,
            //           fontSize: 26)),
            // ),
            // Container(
            //   width: screenWidth * 0.80,
            //   height: screenHeight * 50 / 800,
            //   margin: const EdgeInsets.only(top: 10),
            //   child: 
            //   ElevatedButton(
            //       onPressed: (() => _modulos(context)),
            //       style: ElevatedButton.styleFrom(
            //           backgroundColor: Color(0xFF208B52),
            //           foregroundColor: Colors.white,
            //           elevation: 20,
            //           shadowColor: Colors.black),
            //       child: const Text('Aprender')),
            // ),
            Container(
              width: screenWidth * 0.80,
              height: screenHeight * 50 / 800,
              margin: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  onPressed: (() => _learn(context)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF208B52),
                      foregroundColor: Colors.white,
                      elevation: 20,
                      shadowColor: Colors.black),
                  child: const Text('Aprender', style: TextStyle(fontSize: 18),)),
            ),
            Container(
              width: screenWidth * 0.80,
              height: screenHeight * 50 / 800,
              margin: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  onPressed: (() => _escrever(context)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF208B52),
                      foregroundColor: Colors.white,
                      elevation: 20,
                      shadowColor: Colors.black),
                  child: const Text('Escrever',style: TextStyle(fontSize: 18),)),
            ),
            Container(
              width: screenWidth * 0.80,
              height: screenHeight * 50 / 800,
              margin: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  onPressed: _isButtonDisabled
                      ? null
                      : (() {
                          _traduzir(context);
                        }),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF208B52),
                      foregroundColor: Colors.white,
                      elevation: 20,
                      shadowColor: Colors.black),
                  child: const Text('Traduzir', style: TextStyle(fontSize: 18),)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: const Text(
                'Bem-Vindo!',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Color(0xFFDDE9DD),
    );
  }
}

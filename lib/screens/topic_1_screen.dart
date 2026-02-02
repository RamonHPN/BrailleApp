import 'package:braille_app/services/auth.dart';
import 'package:braille_app/models/modulos.dart';
import 'package:braille_app/services/passer.dart';
import 'package:braille_app/services/topico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Topic1Screen extends StatelessWidget {
  const Topic1Screen({super.key});

  void _topico1conteudo(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Modulo fase = args['fase'];
    final Topico topico = args['topico'];
    final Passer passer = args['passer'];
    final auth = Provider.of<Auth>(context, listen: false);
    topico.checkpoint = 1;
    passer.salvaLugar(
        fase, topico, auth.token ?? '', auth.userId ?? "", topico.checkpoint);
    Navigator.of(context).pushNamed('/topico-1-conteudo-screen',
        arguments: {'fase': fase, "topico": topico, "passer": passer});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Topico topico = args['topico'];
    return Scaffold(
      backgroundColor: Color(0xFFDDE9DD),
      appBar: AppBar(
        backgroundColor: Color(0xFFF1FEF1),
        title: Text(topico.title),
        centerTitle: true,
        actions: [
          Container(
            width: screenWidth * 20 / 360,
            margin: EdgeInsets.only(right: screenWidth * 25 / 360),
            child: Image.asset('assets/images/muiraq_preto.png'),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black)),
            ),
            child: Container(
              color: Color(0xFFF1FEF1),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 159 / 800 * screenHeight,
                    margin: EdgeInsets.only(right: 47 / 360 * screenWidth),
                    child: Image.asset('assets/images/Group143.png'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        width: 134 / 360 * screenWidth,
                        child: Text(
                          topico.title,
                          style: TextStyle(
                            fontSize: 16,
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 41 / 800 * screenHeight),
                    width: 324 / 360 * screenWidth,
                    child: Text(topico.conteudo),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 80 / 800 * screenHeight),
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: screenWidth,
            height: screenHeight * 50 / 800,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF208B52),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                _topico1conteudo(context);
              },
              child: Text(
                'Continuar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

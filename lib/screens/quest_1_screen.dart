import 'package:braille_app/services/auth.dart';
import 'package:braille_app/models/modulos.dart';
import 'package:braille_app/services/passer.dart';
import 'package:braille_app/services/topico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Quest1Screen extends StatefulWidget {
  const Quest1Screen({super.key});

  @override
  State<Quest1Screen> createState() => _Quest1ScreenState();
}

class _Quest1ScreenState extends State<Quest1Screen> {
  int selected = 0;
  bool isAnswered = false;
  bool isCorrect = false;
  bool showContinueButton = false;

  void _acertos(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Modulo fase = args['fase'];
    final Topico topico = args['topico'];
    final Passer passer = args['passer'];
    final auth = Provider.of<Auth>(context, listen: false);
    topico.checkpoint = 0;
    passer.salvaLugar(
        fase, topico, auth.token ?? '', auth.userId ?? "", topico.checkpoint);
    Navigator.of(context).pushNamed('/acertos-screen',
        arguments: {'fase': fase, "topico": topico, "passer": passer});

    passer.salvaAcerto(
        fase, topico, auth.token ?? '', auth.userId ?? '', topico.acertou);
  }

  void select(int number, Topico topico) {
    setState(() {
      selected = number;
    });
  }

  void analiseAcerto(int number, Topico topico) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Topico topico = args['topico'];
    final Passer passer = args['passer'];
    Provider.of<Auth>(context, listen: false);
    setState(() {
      isAnswered = true;
      isCorrect = topico.acertos[passer.indice] == (number - 1);
      showContinueButton = true;
      if (isCorrect) {
        topico.qnt_acertos();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Modulo fase = args['fase'];
    final Topico topico = args['topico'];
    final Passer passer = args['passer'];
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final auth = Provider.of<Auth>(context, listen: false);
    int incrementaLista() {
      setState(() {
        passer.indice++;
        isAnswered = false;
        selected = 0;
        showContinueButton = false;
        passer.salvaIndice(
            fase, topico, auth.token ?? "", auth.userId ?? '', passer.indice);
      });
      return passer.indice;
    }

    if (topico.perguntas.isEmpty || topico.respostas.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFDDE9DD),
          title: Text("Questionário"),
          centerTitle: true,
          shape: Border(bottom: BorderSide(color: Colors.black)),
        ),
        body: Center(
          child: Text(
            'Nenhuma pergunta disponível.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFDDE9DD),
      appBar: AppBar(
        backgroundColor: Color(0xFFDDE9DD),
        title: Text("Questionário"),
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: Colors.black)),
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
            width: screenWidth * 310 / 360,
            margin: EdgeInsets.only(top: screenHeight * 30 / 800),
            child: Text(
              topico.perguntas[passer.indice],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: screenHeight * 15 / 800),
              itemCount: 4,
              itemBuilder: (context, i) {
                int buttonIndex = i + 1;
                bool isSelected = selected == buttonIndex;
                bool isCurrentCorrect = isAnswered && isSelected && isCorrect;
                bool isCurrentIncorrect =
                    isAnswered && isSelected && !isCorrect;

                return Container(
                  margin: EdgeInsets.only(
                      left: 16 / 360 * screenWidth,
                      right: 16 / 360 * screenWidth),
                  width: screenWidth * 328 / 360,
                  constraints:
                      BoxConstraints(minHeight: screenHeight * 50 / 800),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(width: 1)),
                      backgroundColor: isCurrentCorrect
                          ? Colors.green
                          : isCurrentIncorrect
                              ? Colors.red
                              : Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    onPressed:
                        isAnswered ? null : () => select(buttonIndex, topico),
                    child: Row(
                      children: [
                        Icon(
                          // Display filled circle when selected, otherwise outlined
                          isSelected ? Icons.circle : Icons.circle_outlined,
                          color: isAnswered
                              ? (isCurrentCorrect
                                  ? Colors.black
                                  : (isCurrentIncorrect
                                      ? Colors.black
                                      : Colors.black))
                              : Colors.black,
                        ),
                        SizedBox(width: screenWidth * 8 / 360),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              topico.respostas[passer.indice][i],
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (!isAnswered)
            Container(
              margin: EdgeInsets.only(
                  top: screenHeight * 15 / 800,
                  bottom: 80 / 800 * screenHeight),
              height: screenHeight * 50 / 800,
              width: screenWidth * 328 / 360,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF208B52),
                ),
                onPressed: selected != 0
                    ? () => analiseAcerto(selected, topico)
                    : null,
                child: Text(
                  'Confirmar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          if (showContinueButton)
            Container(
              margin: EdgeInsets.only(
                  top: screenHeight * 15 / 800,
                  bottom: 20 / 800 * screenHeight),
              child: Text(
                isCorrect ? 'Resposta correta!' : 'Resposta incorreta!',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isCorrect ? Colors.green : Colors.red),
              ),
            ),
          if (showContinueButton)
            Container(
              margin: EdgeInsets.only(bottom: screenHeight * 80 / 800),
              height: screenHeight * 50 / 800,
              width: screenWidth * 328 / 360,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF208B52),
                ),
                onPressed: () {
                  if (passer.topicoCompleto <= topico.id) {
                    passer.incrementaFracao(passer, topico, fase,
                        auth.token ?? '', auth.userId ?? "");
                  }
                  if (passer.indice + 1 == topico.perguntas.length) {
                    passer.indice = 0;
                    passer.salvaIndice(fase, topico, auth.token ?? "",
                        auth.userId ?? "", passer.indice);
                    _acertos(context);
                  } else {
                    incrementaLista();
                  }
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

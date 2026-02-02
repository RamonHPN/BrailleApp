import 'package:braille_app/services/auth.dart';
import 'package:braille_app/services/information_1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutYou1Screen extends StatefulWidget {
  const AboutYou1Screen({super.key});

  @override
  State<AboutYou1Screen> createState() => _AboutYou1ScreenState();
}

class _AboutYou1ScreenState extends State<AboutYou1Screen> {
  void _about_you_2(BuildContext context) {
    Navigator.of(context).pushNamed('/about-you-2-screen');
  }

  int selected = 0;

  select(int number) {
    setState(() {
      selected = number;
      print(number);
    });
  }

  @override
  Widget build(BuildContext context) {
    final information = Provider.of<Information1>(context);
    final auth = Provider.of<Auth>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFDDE9DD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDDE9DD),
        title: const Text("Sobre você"),
        centerTitle: true,
        shape: const Border(bottom: BorderSide(color: Colors.black)),
        actions: [
          Container(
            width: screenWidth * 20 / 360,
            margin: EdgeInsets.only(right: screenWidth * 25 / 360),
            child: Image.asset('assets/images/muiraq_preto.png'),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 30 / 800),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 16 / 360),
                      child: const Text(
                        'O quanto você entende do sistema braille?',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...List.generate(4, (index) {
                      final options = [
                        'Não sei nada',
                        'Conheço alguns caracteres',
                        'Consigo ler com alguma ajuda',
                        'Leio sem nenhuma dificuldade'
                      ];
                      final optionIndex = index + 1;

                      return Container(
                        margin: EdgeInsets.only(top: screenHeight * 15 / 800),
                        width: screenWidth * 328 / 360,
                        height: screenHeight * 50 / 800,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            foregroundColor: Colors.black,
                            backgroundColor: selected == optionIndex
                                ? const Color(0xFFBAE2CD)
                                : Colors.white,
                          ),
                          onPressed: () {
                            select(optionIndex);
                          },
                          child: Row(
                            children: [
                              Icon(
                                selected == optionIndex
                                    ? Icons.check_circle_outline_outlined
                                    : Icons.circle_outlined,
                              ),
                              SizedBox(width: screenWidth * 8 / 360),
                              Flexible(child: Text(options[index])),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: screenHeight * 40 / 800,
              ),
              child: SizedBox(
                height: screenHeight * 50 / 800,
                width: screenWidth * 328 / 360,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF208B52),
                  ),
                  onPressed: () {
                    _about_you_2(context);
                    information.saveInformation1(
                        auth.token ?? '', auth.userId ?? '', selected);
                  },
                  child: const Text(
                    'Continuar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

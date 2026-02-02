import 'package:braille_app/services/auth.dart';
import 'package:braille_app/services/information_1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutYou2Screen extends StatefulWidget {
  const AboutYou2Screen({super.key});

  @override
  State<AboutYou2Screen> createState() => _AboutYou2ScreenState();
}

class _AboutYou2ScreenState extends State<AboutYou2Screen> {
  void _ready(BuildContext context) {
    Navigator.of(context).pushNamed('/ready-screen');
  }

  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;

  select1() => setState(() => selected1 = !selected1);
  select2() => setState(() => selected2 = !selected2);
  select3() => setState(() => selected3 = !selected3);

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
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 16 / 360),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 30 / 800),
                      const Text(
                        'No que você tem interesse?',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 20 / 800),
                      ...[
                        {
                          'selected': selected1,
                          'label': 'Traduzir caracteres em Braille',
                          'onPressed': select1,
                        },
                        {
                          'selected': selected2,
                          'label': 'Aprender sobre o Sistema Braille',
                          'onPressed': select2,
                        },
                        {
                          'selected': selected3,
                          'label': 'Praticar meus conhecimentos',
                          'onPressed': select3,
                        },
                      ].map((option) {
                        return Container(
                          margin:
                              EdgeInsets.only(top: screenHeight * 20 / 800),
                          height: screenHeight * 50 / 800,
                          width: screenWidth * 328 / 360,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              foregroundColor: Colors.black,
                              backgroundColor: option['selected'] as bool
                                  ? const Color(0xFFBAE2CD)
                                  : Colors.white,
                            ),
                            onPressed: option['onPressed'] as VoidCallback,
                            child: Row(
                              children: [
                                Icon((option['selected'] as bool)
                                    ? Icons.check_box
                                    : Icons.square_outlined),
                                SizedBox(width: screenWidth * 8 / 360),
                                Flexible(
                                  child: Text(option['label'] as String),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 40 / 800),
              child: SizedBox(
                height: screenHeight * 50 / 800,
                width: screenWidth * 328 / 360,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF208B52),
                  ),
                  onPressed: () {
                    _ready(context);
                    information.saveInformation2(
                      auth.token ?? '',
                      auth.userId ?? '',
                      selected1,
                      selected2,
                      selected3,
                    );
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

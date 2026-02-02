import 'package:flutter/material.dart';

class AboutYou3Screen extends StatefulWidget {
  const AboutYou3Screen({super.key});

  @override
  State<AboutYou3Screen> createState() => _AboutYou3ScreenState();
}

class _AboutYou3ScreenState extends State<AboutYou3Screen> {
  void _ready(BuildContext context) {
    Navigator.of(context).pushNamed('/ready-screen');
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
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 30 / 800,
                        left: screenWidth * 16 / 360,
                        right: screenWidth * 16 / 360,
                      ),
                      child: const Text(
                        'Podemos te ajudar a lembrar de praticar?',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: screenWidth * 328 / 360,
                      height: screenHeight * 50 / 800,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Colors.black,
                          backgroundColor: selected == 1
                              ? const Color(0xFFBAE2CD)
                              : Colors.white,
                        ),
                        onPressed: () {
                          select(1);
                        },
                        child: Row(
                          children: [
                            Icon(selected == 1
                                ? Icons.check_circle_outline_outlined
                                : Icons.circle_outlined),
                            SizedBox(width: screenWidth * 8 / 360),
                            const Text('Sim, por favor!'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: screenWidth * 328 / 360,
                      height: screenHeight * 50 / 800,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Colors.black,
                          backgroundColor: selected == 2
                              ? const Color(0xFFBAE2CD)
                              : Colors.white,
                        ),
                        onPressed: () {
                          select(2);
                        },
                        child: Row(
                          children: [
                            Icon(selected == 2
                                ? Icons.check_circle_outline_outlined
                                : Icons.circle_outlined),
                            SizedBox(width: screenWidth * 8 / 360),
                            const Text('Agora não'),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                  onPressed: () => _ready(context),
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

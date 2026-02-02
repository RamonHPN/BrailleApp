import 'package:flutter/material.dart';

class Finished extends StatelessWidget {
  String image;
  String negrito;
  String texto;
  String botao;
  VoidCallback? rota;

  Finished({
    super.key,
    this.image = '',
    this.negrito = '',
    this.texto = '',
    this.botao = '',
    this.rota,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFDDE9DD),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center( // 👈 isso garante centralização horizontal
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: screenHeight * 298 / 800,
                      margin: EdgeInsets.only(bottom: screenHeight * 20 / 800),
                      child: Image.asset(image),
                    ),
                    Container(
                      width: screenWidth * 276 / 360,
                      margin: EdgeInsets.only(bottom: screenHeight * 10 / 800),
                      child: Text(
                        negrito,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: screenWidth * 276 / 360,
                      child: Text(
                        texto,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
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
                  onPressed: rota,
                  child: Text(
                    botao,
                    style: const TextStyle(color: Colors.white),
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

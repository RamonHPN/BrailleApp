import 'package:braille_app/screens/escrever_screen_2.dart';
import 'package:braille_app/screens/learn_screen.dart';
import 'package:braille_app/screens/modulos_screen.dart';
import 'package:braille_app/screens/phrase_translator_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen2 extends StatelessWidget {
  const TabsScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final initialIndex = args?['initialIndex'] ?? 0;

    return DefaultTabController(
      length: 3,
      initialIndex: initialIndex,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  LearnScreen(),
                  PhraseTranslatorScreen(),
                  EscreverScreen2(),
                //  ModulosScreen(),
                //  Container(),
                ],
              ),
            ),
            Container(
              height: 1.0,
              color: Colors.black,
            ),
          ],
        ),
        bottomNavigationBar: TabBar(
          indicatorColor: Color(0xFF208B52),
          labelStyle: TextStyle(
            fontSize: 12 / 800 * screenHeight,
          ),
          tabs: [
            Tab(
              icon: Icon(Icons.auto_fix_high, size: 23 / 800 * screenHeight),
              text: "Aprender",
            ),
            Tab(
              icon: Icon(
                Icons.translate,
                size: 23 / 800 * screenHeight,
              ),
              text: "Traduzir",
            ),
            Tab(
              icon: Icon(Icons.text_snippet, size: 23 / 800 * screenHeight),
              text: "Escrever",
            ),
            // Tab(
            //   icon: Icon(Icons.person, size: 23 / 800 * screenHeight),
            //   text: "Perfil",
            // ),
          ],
          labelColor: Color(0xFF208B52),
          unselectedLabelColor: Color(0xFF4AB37B),
        ),
      ),
    );
  }
}

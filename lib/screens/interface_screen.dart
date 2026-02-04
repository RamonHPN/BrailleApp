// ignore_for_file: unused_local_variable, avoid_print

import 'package:braille_app/services/auth.dart';
import 'package:braille_app/services/graphic.dart';
import 'package:braille_app/services/information_1.dart';
import 'package:braille_app/services/passer.dart';
import 'package:braille_app/services/topico.dart';
import 'package:braille_app/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:braille_app/data/topicos_data.dart';

// Função utilitária para cálculos
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

  // --- FUNÇÕES DE NAVEGAÇÃO ---
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

    return Scaffold(
      backgroundColor: const Color(0xFFDDE9DD),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. LOGO COM ACESSIBILIDADE
                Semantics(
                  label: "Logotipo do aplicativo Braille: Ilustração de mãos sobre pontos em relevo.",
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.25,
                    child: Image.asset(
                      'assets/images/interface_braille.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // 2. BOAS-VINDAS
                Semantics(
                  header: true,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Bem-Vindo!',
                      style: TextStyle(
                        color: Colors.black, 
                        fontSize: 26, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),

                // 3. BOTÕES DE MENU
                _buildMenuButton(
                  context,
                  label: 'Aprender',
                  hint: 'Toque duas vezes para acessar os módulos de ensino',
                  onPressed: () => _learn(context),
                  screenWidth: screenWidth,
                ),

                _buildMenuButton(
                  context,
                  label: 'Escrever',
                  hint: 'Toque duas vezes para praticar a escrita em Braille',
                  onPressed: () => _escrever(context),
                  screenWidth: screenWidth,
                ),

                _buildMenuButton(
                  context,
                  label: 'Traduzir',
                  hint: 'Toque duas vezes para usar o tradutor de Braille',
                  onPressed: _isButtonDisabled ? null : () => _traduzir(context),
                  screenWidth: screenWidth,
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // WIDGET AUXILIAR PARA PADRONIZAR BOTÕES E ACESSIBILIDADE
  Widget _buildMenuButton(
    BuildContext context, {
    required String label,
    required String hint,
    required VoidCallback? onPressed,
    required double screenWidth,
  }) {
    return Semantics(
      button: true,
      label: label,
      hint: hint,
      child: Container(
        width: screenWidth * 0.85,
        height: 55,
        margin: const EdgeInsets.only(top: 15),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF208B52),
            foregroundColor: Colors.white,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}
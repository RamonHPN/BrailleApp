import 'package:flutter/material.dart';

class SwitchAuth extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const SwitchAuth({
    super.key,
    this.screenHeight = 0,
    this.screenWidth = 0,
  });

  void _login(BuildContext context) {
    Navigator.of(context).pushNamed('/login-screen');
  }

  void _register(BuildContext context) {
    Navigator.of(context).pushNamed('/register-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // BOTÃO CRIAR CONTA
        Semantics(
          label: "Botão Criar conta",
          hint: "Toque para abrir o formulário de cadastro de novo usuário",
          button: true, // Indica que é um elemento clicável
          child: Container(
            margin: EdgeInsets.only(top: 84 / 800 * screenHeight),
            width: screenWidth * 0.91,
            height: screenHeight * 50 / 800,
            child: ElevatedButton(
              onPressed: () => _register(context),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF208B52),
                  foregroundColor: Colors.white,
                  elevation: 20,
                  shadowColor: Colors.black),
              child: Text(
                "Criar conta",
                style: TextStyle(
                    fontSize: 16 / 800 * screenHeight,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
        
        // BOTÃO JÁ TENHO UMA CONTA
        Semantics(
          label: "Botão Já tenho uma conta",
          hint: "Toque para ir para a tela de login",
          button: true,
          child: Container(
            margin: EdgeInsets.only(top: 20 / 800 * screenHeight), // Ajustado margem para espaçamento melhor
            height: screenHeight * 50 / 800,
            width: screenWidth * 0.91,
            child: ElevatedButton(
              onPressed: () => _login(context),
              style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
              child: Text(
                "Já tenho uma conta",
                style: TextStyle(
                    fontSize: 16 / 800 * screenHeight,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
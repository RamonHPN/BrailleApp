import 'package:braille_app/components/auth_form_register.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFDDE9DD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDDE9DD),
        // 1. Definimos o título como um cabeçalho para o leitor de tela
        title: Semantics(
          header: true,
          label: 'Tela de criação de conta',
          child: const Text('Criar conta'),
        ),
        centerTitle: true,
        shape: const Border(bottom: BorderSide(color: Colors.black)),
        actions: [
          // 2. A imagem no AppBar parece ser um logotipo ou ícone decorativo.
          // Se for apenas decorativa, usamos ExcludeSemantics para o leitor não travar nela.
          ExcludeSemantics(
            child: Container(
              width: screenWidth * 20 / 360,
              margin: EdgeInsets.only(right: screenWidth * 25 / 360),
              child: Image.asset('assets/images/muiraq_preto.png'),
            ),
          )
        ],
      ),
      // 3. O corpo já chama o AuthFormRegister que deixamos acessível no passo anterior!
      body: const AuthFormRegister(),
    );
  }
}
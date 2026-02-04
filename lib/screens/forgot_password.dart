// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  Future resetPassword(BuildContext context) async {
    String email = _emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um e-mail válido.')),
      );
      return;
    }

    try {
      // 1. Traduz o e-mail para Português (Brasil)
      await FirebaseAuth.instance.setLanguageCode("pt-br");
      
      // 2. Envia o e-mail
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('Enviando e-mail de recuperação para $email');

      // 3. Mostra o Diálogo de Sucesso
      showDialog(
        context: context,
        barrierDismissible: false, // Usuário é obrigado a clicar no OK
        builder: (ctx) => AlertDialog(
          title: const Text('E-mail enviado!'),
          content: Semantics(
            liveRegion: true, // Acessibilidade: o leitor lê assim que abrir
            child: Text('Um e-mail de recuperação foi enviado para $email.'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // PRIMEIRO: Fecha o Alerta
                Navigator.of(ctx).pop(); 
                // SEGUNDO: Volta para a tela de Login (Tela Inicial)
                Navigator.of(context).pop(); 
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Erro ao resetar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao processar solicitação. Verifique o e-mail.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Insira seu e-mail para recuperar sua senha',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            // ACESSIBILIDADE: Adicionado rótulo semântico para o campo
            Semantics(
              label: "Campo de texto: Digite o e-mail para recuperação",
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'exemplo@gmail.com',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 20.0),
            // ACESSIBILIDADE: Botão com label claro
            Semantics(
              label: "Botão enviar e-mail de recuperação",
              button: true,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF208B52), // Cor do seu tema
                  foregroundColor: Colors.white,
                ),
                onPressed: () => resetPassword(context),
                child: const Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
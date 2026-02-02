// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  Future resetPassword(BuildContext context) async {
    String email = _emailController.text.trim();
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    print('Enviando e-mail de recuperação para $email');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('E-mail enviado!'),
        content: Text('Um e-mail de recuperação foi enviado para $email.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Senha'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Insira seu e-mail para recuperar sua senha',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'E-mail inválido';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => resetPassword(context),
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}

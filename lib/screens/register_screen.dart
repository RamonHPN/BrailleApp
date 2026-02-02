import 'package:braille_app/components/auth_form_register.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFDDE9DD),
      appBar: AppBar(
        backgroundColor: Color(0xFFDDE9DD),
        title: Text('Criar conta'),
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: Colors.black)),
        actions: [
          Container(
            width: screenWidth * 20 / 360,
            margin: EdgeInsets.only(right: screenWidth * 25 / 360),
            child: Image.asset('assets/images/muiraq_preto.png'),
          )
        ],
      ),
      body: AuthFormRegister(),
    );
  }
}


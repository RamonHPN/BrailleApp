import 'package:braille_app/components/auth_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _register(BuildContext context) {
    Navigator.of(context).pushNamed('/register-screen');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFDDE9DD),
      appBar: AppBar(
        // ACESSIBILIDADE: Melhorando o botão de voltar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: "Voltar para a tela anterior", // Ajuda usuários com baixa visão
          onPressed: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(const Duration(milliseconds: 200));
            Navigator.of(context).maybePop();
          },
        ),
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: const Color(0xFFDDE9DD),
        shape: const Border(bottom: BorderSide(color: Colors.black)),
        actions: [
          // ACESSIBILIDADE: Imagem decorativa oculta para o leitor não perder tempo
          ExcludeSemantics(
            child: Container(
              width: screenWidth * 20 / 360,
              margin: EdgeInsets.only(right: screenWidth * 25 / 360),
              child: Image.asset('assets/images/muiraq_preto.png'),
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ACESSIBILIDADE: Descrevendo a logo principal
                      Semantics(
                        label: "Logotipo do aplicativo Braille.",
                        child: Container(
                          width: 0.7 * screenWidth,
                          margin: EdgeInsets.only(top: screenHeight * 36 / 800),
                          child: Image.asset('assets/images/interface_braille.png'),
                        ),
                      ),
                      
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 16 / 360),
                        child: const AuthForm(), // Certifique-se de que o AuthForm tenha Semantics
                      ),
                      
                      Column(
                        children: [
                          Container(
                            height: 0.5,
                            width: screenWidth * 300 / 360,
                            color: Colors.black,
                          ),
                          // ACESSIBILIDADE: Agrupando a pergunta e o botão
                          Semantics(
                            container: true,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Primeira vez por aqui?',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Semantics(
                                  button: true,
                                  label: "Botão: Crie uma conta agora",
                                  child: TextButton(
                                    onPressed: () => _register(context),
                                    child: const Text(
                                      'Crie uma conta',
                                      style: TextStyle(color: Color(0xFF1CB9C5)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
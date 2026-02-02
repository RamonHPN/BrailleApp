import 'package:braille_app/exceptions/auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:braille_app/services/auth.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  final double screenHeight;
  const AuthForm({
    super.key,
    this.screenHeight = 0,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.login;

  // --- FUNÇÃO DE CHECAGEM DE FORÇA (O "PEDÁGIO") ---
  bool _isPasswordStrong(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
        
        // --- VERIFICAÇÃO APÓS LOGIN BEM SUCEDIDO ---
        // Se a senha for fraca, manda para a tela de troca obrigatória
        if (!_isPasswordStrong(_authData['password']!)) {
          // Passamos o email e senha no arguments
          Navigator.of(context).pushReplacementNamed(
            '/force-password-update',
            arguments: {
              'email': _authData['email'],
              'password': _authData['password'],
            },
          );
          return;
        }
      } else {
        await auth.signup(
          _authData['email']!,
          _authData['password']!,
        );
      }

      // Se passou na verificação de força (ou se foi cadastro), vai para o app
      Navigator.of(context).pushReplacementNamed('/interface-screen');
      
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          )
        ],
      ),
    );
  }

  void _forgotPassword(BuildContext context) {
    Navigator.of(context).pushNamed('/forgot-password-screen');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(color: Color(0xFFDDE9DD)),
        ),
        Container(
          color: const Color(0xFFDDE9DD),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: screenWidth * 328 / 360,
                      height: screenHeight * 70 / 800,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'E-mail',
                          labelStyle: TextStyle(fontWeight: FontWeight.w800),
                          hintText: 'Ex: joao@gmail.com',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (email) => _authData['email'] = email ?? '',
                        validator: (value) {
                          final email = value ?? '';
                          if (email.trim().isEmpty || !email.contains('@')) {
                            return 'Informe um e-mail válido';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 328 / 360,
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Senha',
                          labelStyle: TextStyle(fontWeight: FontWeight.w800),
                          hintText: 'Ex: senha123',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (password) => _authData['password'] = password ?? '',
                        validator: (value) {
                          final password = value ?? '';
                          if (password.isEmpty || password.length < 5) {
                            return 'Informe uma senha válida';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: screenWidth * 300 / 360,
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: WidgetStateProperty.all(const Size(0, 25)),
                        ),
                        onPressed: () => _forgotPassword(context),
                        child: const Text(
                          'Esqueceu sua senha?',
                          style: TextStyle(color: Color(0xFF1CB9C5)),
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight * 29 / 800,
                      color: const Color(0xFFDDE9DD),
                    ),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      SizedBox(
                        height: screenHeight * 50 / 800,
                        width: screenWidth * 328 / 360,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF208B52),
                          ),
                          onPressed: _submit,
                          child: Text(
                            _isLogin() ? 'Entrar' : 'REGISTRAR',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
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
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.login;
  bool _isSignup() => _authMode == AuthMode.signup;

  Future<void> _submit() async {
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
      } else {
        await auth.signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.signup;
      } else {
        _authMode = AuthMode.login;
      }
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Ocorreu um erro'),
              content: Text(msg),
              actions: [
                TextButton(
                    onPressed: (() => Navigator.of(context).pop()),
                    child: const Text('Fechar'))
              ],
            ));
  }

  void _interface(BuildContext context) {
    Navigator.of(context).pushNamed('/interface-screen');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xFFDDE9DD)),
        ),
        Container(
          color: Color(0xFFDDE9DD),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: screenWidth * 328 / 360,
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        labelStyle: TextStyle(fontWeight: FontWeight.w800),
                        hintText: 'Ex: joao@gmail.com',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (email) => _authData['email'] = email ?? '',
                      // ignore: no_leading_underscores_for_local_identifiers
                      validator: (_email) {
                        final email = _email ?? '';
                        if (email.trim().isEmpty || !email.contains('@')) {
                          return 'Informe um e-mail válido';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: screenHeight * 28 / 800,
                    color: Color(0xFFDDE9DD),
                  ),
                  Container(
                    width: screenWidth * 328 / 360,
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        labelStyle: TextStyle(fontWeight: FontWeight.w800),
                        hintText: 'Ex: senha123',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      controller: _passwordController,
                      onSaved: (password) =>
                          _authData['password'] = password ?? '',
                      // ignore: no_leading_underscores_for_local_identifiers, body_might_complete_normally_nullable
                      validator: (_password) {
                        final password = _password ?? '';
                        if (password.isEmpty || password.length < 5) {
                          return 'Informe uma senha válida';
                        }
                      },
                    ),
                  ),
                  if (_isSignup())
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Confirmar Senha'),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      // onSaved: (password) => _authData['password'] = password ??'',
                      validator: _isLogin()
                          ? null
                          // ignore: no_leading_underscores_for_local_identifiers
                          : (_password) {
                              final password = _password ?? '';
                              if (password != _passwordController.text) {
                                return 'Senhas informadas não conferem.';
                              }
                              return null;
                            },
                    ),
                  Container(
                    height: screenHeight * 29 / 800,
                    color: Color(0xFFDDE9DD),
                  ),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    SizedBox(
                      width: screenWidth * 328 / 360,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFACC9B8)),
                          onPressed: () {
                            _interface(context);
                            _submit;
                          },
                          child: Text(
                            _authMode == AuthMode.login
                                ? 'Entrar'
                                : 'REGISTRAR',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  SizedBox(
                    height: screenHeight * 1 / 40,
                  ),
                  SizedBox(
                    width: screenWidth * 328 / 360,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {},
                        child: Text(
                          'Continue com Google',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w800),
                        )),
                  ),
                  SizedBox(
                    height: screenHeight * 1 / 40,
                  ),
                  SizedBox(
                    width: screenWidth * 328 / 360,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {},
                        child: Text(
                          'Continue com Facebook',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w800),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 30 / 800),
                    height: 0.5,
                    width: screenWidth * 300 / 360,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 68 / 800),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Primeira vez por aqui?',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                            onPressed: _switchAuthMode,
                            child: Text(
                              _isLogin()
                                  ? 'Crie uma conta'
                                  : 'JÁ POSSUI CONTA?',
                              style: TextStyle(color: Color(0xFF1CB9C5)),
                            )),
                      ],
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }
}

import 'package:braille_app/exceptions/auth_exception.dart';
import 'package:braille_app/services/information_1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:braille_app/services/auth.dart';

enum AuthMode { signup, login }

class AuthFormRegister extends StatefulWidget {
  final double screenHeight;
  const AuthFormRegister({
    super.key,
    this.screenHeight = 0,
  });

  @override
  State<AuthFormRegister> createState() => _AuthFormRegisterState();
}

class _AuthFormRegisterState extends State<AuthFormRegister> {
  // --- CONTROLLERS PARA MONITORAR OS CAMPOS ---
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final AuthMode _authMode = AuthMode.signup;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  // --- ESTADO DO CHECKLIST ---
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  void _validatePassword(String value) {
    setState(() {
      _hasMinLength = value.length >= 8;
      _hasUppercase = value.contains(RegExp(r'[A-Z]'));
      _hasNumber = value.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  bool _isPasswordStrong() {
    return _hasMinLength && _hasUppercase && _hasNumber && _hasSpecialChar;
  }

  // --- LÓGICA DE ATIVAÇÃO DO BOTÃO ---
  bool _canSubmit() {
    return _nomeController.text.trim().isNotEmpty &&
           _emailController.text.trim().contains('@') &&
           _isPasswordStrong() &&
           _passwordController.text == _confirmPasswordController.text;
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid || !_canSubmit()) return;

    setState(() => _isLoading = true);
    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      await auth.signup(_authData['email']!, _authData['password']!);
      FocusScope.of(context).unfocus();
      
      if (mounted) {
        Navigator.of(context).pushNamed('/account-created-screen');
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }
    
    if (mounted) setState(() => _isLoading = false);
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

// 1. Melhorei o checklist para ser anunciado corretamente
  Widget _buildCheckItem(String label, bool isMet) {
    return Semantics(
      label: "Requisito de senha: $label",
      checked: isMet, // Indica ao leitor de tela se o item já foi cumprido
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isMet ? Colors.green : Colors.grey,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isMet ? Colors.green : Colors.black54,
              fontSize: 12,
              fontWeight: isMet ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final nameProvider = Provider.of<Information1>(context);

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // CAMPO NOME - Adicionado rótulo semântico
                    SizedBox(
                      width: screenWidth * 328 / 360,
                      child: Semantics(
                        label: "Campo para digitar seu nome completo",
                        child: TextFormField(
                          controller: _nomeController,
                          textInputAction: TextInputAction.next, // Facilita navegação por teclado
                          onChanged: (_) => setState(() {}),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Nome',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (rec) => nameProvider.nome = rec ?? '',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // CAMPO EMAIL
                    SizedBox(
                      width: screenWidth * 328 / 360,
                      child: Semantics(
                        label: "Campo para digitar seu endereço de e-mail",
                        child: TextFormField(
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) => setState(() {}),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'E-mail',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (email) => _authData['email'] = email ?? '',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // CAMPO SENHA
                    SizedBox(
                      width: screenWidth * 328 / 360,
                      child: Semantics(
                        label: "Campo para criar sua senha",
                        hint: "A senha deve conter letras maiúsculas, números e caracteres especiais",
                        child: TextFormField(
                          controller: _passwordController,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          onChanged: _validatePassword,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Senha',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (pw) => _authData['password'] = pw ?? '',
                        ),
                      ),
                    ),
                    // CHECKLIST - Agrupado para leitura contínua
                    MergeSemantics(
                      child: SizedBox(
                        width: screenWidth * 328 / 360,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, left: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildCheckItem("Mínimo de 8 caracteres", _hasMinLength),
                              _buildCheckItem("Pelo menos 1 letra maiúscula", _hasUppercase),
                              _buildCheckItem("Pelo menos 1 número", _hasNumber),
                              _buildCheckItem("Pelo menos 1 caractere especial", _hasSpecialChar),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // CONFIRMAR SENHA
                    SizedBox(
                      width: screenWidth * 328 / 360,
                      child: Semantics(
                        label: "Confirme sua senha",
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          textInputAction: TextInputAction.done, // Indica fim do formulário
                          onChanged: (_) => setState(() {}),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Confirmar Senha',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          onFieldSubmitted: (_) => _canSubmit() ? _submit() : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // BOTÃO REGISTRAR
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 24),
            child: _isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    height: screenHeight * 50 / 800,
                    width: screenWidth * 328 / 360,
                    child: Semantics(
                      label: "Botão para finalizar o registro",
                      enabled: _canSubmit(),
                      hint: _canSubmit() ? "Clique para cadastrar" : "Preencha todos os campos e requisitos de senha para habilitar",
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF208B52),
                          disabledBackgroundColor: Colors.grey.shade400,
                        ),
                        onPressed: _canSubmit() ? _submit : null, 
                        child: Text(
                          'REGISTRAR',
                          style: TextStyle(
                            color: _canSubmit() ? Colors.white : Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
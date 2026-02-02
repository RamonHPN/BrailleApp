import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForcePasswordUpdateScreen extends StatefulWidget {
  const ForcePasswordUpdateScreen({super.key});

  @override
  State<ForcePasswordUpdateScreen> createState() => _ForcePasswordUpdateScreenState();
}

class _ForcePasswordUpdateScreenState extends State<ForcePasswordUpdateScreen> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Lógica do Checklist
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

  Future<void> _updatePassword() async {
    if (!_isPasswordStrong()) return;
    setState(() => _isLoading = true);

    try {
      // 1. Pegar os dados que vieram da tela de login
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final email = args['email'];
      final oldPassword = args['password'];

      // 2. Garantir login ativo (Re-autenticação forçada)
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: oldPassword,
      );

      User? user = userCredential.user;

      if (user != null) {
        // 3. Agora sim, atualiza a senha
        await user.updatePassword(_passwordController.text);
        
        print("Sucesso! Senha atualizada.");

        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/interface-screen');
        }
      }
    } on FirebaseAuthException catch (e) {
      print("Erro Firebase: ${e.code}");
      _showErrorDialog(e.message ?? "Erro ao validar acesso.");
    } catch (e) {
      print("Erro Geral: $e");
      _showErrorDialog("Ocorreu um erro ao processar sua senha.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
  // Função auxiliar para mostrar o erro na tela
  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Atenção'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  Widget _buildCheckItem(String label, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isMet ? Colors.green : Colors.grey,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(color: isMet ? Colors.green : Colors.black54),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE9DD),
      appBar: AppBar(
        title: const Text('Atualização Obrigatória'),
        backgroundColor: const Color(0xFFDDE9DD),
        automaticallyImplyLeading: false, // Impede o usuário de voltar sem trocar
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sua senha atual é fraca. Por favor, crie uma senha segura para continuar utilizando o app.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                onChanged: _validatePassword,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Nova Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              _buildCheckItem("Mínimo de 8 caracteres", _hasMinLength),
              _buildCheckItem("Uma letra maiúscula", _hasUppercase),
              _buildCheckItem("Um número", _hasNumber),
              _buildCheckItem("Um caractere especial", _hasSpecialChar),
              const SizedBox(height: 32),
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF208B52),
                        ),
                        onPressed: _isPasswordStrong() ? _updatePassword : null,
                        child: const Text('ATUALIZAR E ENTRAR', style: TextStyle(color: Colors.white)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
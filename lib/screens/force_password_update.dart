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
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final email = args['email'];
      final oldPassword = args['password'];

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: oldPassword,
      );

      User? user = userCredential.user;

      if (user != null) {
        await user.updatePassword(_passwordController.text);
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/interface-screen');
        }
      }
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.message ?? "Erro ao validar acesso.");
    } catch (e) {
      _showErrorDialog("Ocorreu um erro ao processar sua senha.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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

  // 1. Melhoria no item do checklist com excludeSemantics e labels claras
  Widget _buildCheckItem(String label, bool isMet) {
    return Semantics(
      excludeSemantics: true,
      label: "${isMet ? 'Cumprido' : 'Pendente'}: $label",
      checked: isMet,
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isMet ? Colors.green : Colors.grey,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isMet ? Colors.green : Colors.black54,
              fontWeight: isMet ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE9DD),
      appBar: AppBar(
        // 2. Definindo como cabeçalho
        title: Semantics(
          header: true,
          child: const Text('Atualização Obrigatória'),
        ),
        backgroundColor: const Color(0xFFDDE9DD),
        automaticallyImplyLeading: false, 
      ),
      body: SingleChildScrollView( // Adicionado para evitar erro de layout com teclado
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 3. Texto explicativo com semântica de alerta
              Semantics(
                label: "Aviso importante: Sua senha atual é considerada fraca. Você precisa criar uma nova senha segura para continuar acessando o aplicativo.",
                child: const Text(
                  'Sua senha atual é fraca. Por favor, crie uma senha segura para continuar utilizando o app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 32),
              
              // 4. Campo de Senha simplificado (o labelText já resolve a label)
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                onChanged: _validatePassword,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Digite uma senha forte com letras, números e símbolos',
                  hintText: 'Mínimo de 8 caracteres',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // 5. Lista de requisitos
              _buildCheckItem("Mínimo de 8 caracteres", _hasMinLength),
              _buildCheckItem("Pelo menos uma letra maiúscula", _hasUppercase),
              _buildCheckItem("Pelo menos um número", _hasNumber),
              _buildCheckItem("Pelo menos um caractere especial", _hasSpecialChar),
              
              const SizedBox(height: 32),

              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      height: 50,
                      // 6. Botão com feedback de estado
                      child: Semantics(
                        label: "Atualizar senha e entrar",
                        button: true,
                        enabled: _isPasswordStrong(),
                        hint: _isPasswordStrong() 
                            ? "Toque duas vezes para salvar sua nova senha" 
                            : "Botão desabilitado. Verifique os requisitos de senha pendentes acima.",
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF208B52),
                            disabledBackgroundColor: Colors.grey.shade400,
                          ),
                          onPressed: _isPasswordStrong() ? _updatePassword : null,
                          child: const Text(
                            'ATUALIZAR E ENTRAR', 
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
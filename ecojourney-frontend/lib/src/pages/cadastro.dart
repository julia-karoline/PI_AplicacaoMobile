import 'package:flutter/material.dart';
import 'package:app_ecojourney/src/pages/login.dart';
import 'package:app_ecojourney/src/services/api_service.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();
  bool agreeToTerms = false;

  String? _validateNome(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo nome é obrigatório';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo e-mail é obrigatório';
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

  String? _validateSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo senha é obrigatório';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }

    final senhaSegura = RegExp(r'^(?=.*[A-Z])(?=.*[!@#\$&*~]).{6,}$');
    if (!senhaSegura.hasMatch(value)) {
      return 'A senha deve conter pelo menos uma letra maiúscula e um caractere especial';
    }

    return null;
  }

  String? _validateConfirmarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirme sua senha';
    }
    if (value != _senhaController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  Future<void> _cadastrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      if (!agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Você precisa aceitar os termos de uso")),
        );
        return;
      }

      final result = await ApiService.registerUser(
        name: _nomeController.text.trim(),
        email: _emailController.text.trim(),
        password: _senhaController.text,
      );

      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'])),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TelaLogin()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['error'] ?? 'Erro ao cadastrar usuário')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFE0FEEA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Criar uma conta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0E4931),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildTextField(
                      'Nome',
                      _nomeController,
                      _validateNome,
                      fieldKey: const Key('nome_field'),
                    ),
                    _buildTextField(
                      'Email',
                      _emailController,
                      _validateEmail,
                      fieldKey: const Key('email_field'),
                    ),
                    _buildTextField(
                      'Senha',
                      _senhaController,
                      _validateSenha,
                      isPassword: true,
                      fieldKey: const Key('senha_field'),
                    ),
                    _buildTextField(
                      'Repetir senha',
                      _confirmarSenhaController,
                      _validateConfirmarSenha,
                      isPassword: true,
                      fieldKey: const Key('confirmar_senha_field'),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              agreeToTerms = value!;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'Eu concordo com os termos de uso',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      key: const Key('cadastrar_button'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0E4931),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _cadastrarUsuario,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Criar conta',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TelaLogin()),
                        );
                      },
                      child: const Text(
                        'Já tem uma conta? Entre',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String? Function(String?) validator, {
    bool isPassword = false,
    Key? fieldKey,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        key: fieldKey,
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.green),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        validator: validator,
      ),
    );
  }
      @override
    void dispose() {
      _nomeController.dispose();
      _emailController.dispose();
      _senhaController.dispose();
      _confirmarSenhaController.dispose();
      super.dispose();
    }
}

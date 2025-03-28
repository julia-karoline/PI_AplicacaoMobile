import 'package:app_ecojourney/src/pages/home_page.dart';
import 'package:app_ecojourney/src/pages/login.dart';
import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FractionallySizedBox(
    widthFactor: 1.0, // Define a largura como 90% da tela
    heightFactor: 1.0, // Define a altura como 80% da tela
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFE0FEEA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                 mainAxisSize: MainAxisSize.min, // Ajusta o tamanho conforme o conteúdo
                children: [
                  const Text(
                    'Criar uma conta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:40,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0E4931),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildTextField('Nome',),
                  _buildTextField('Email'),
                  _buildTextField('Senha', isPassword: true),
                  _buildTextField('Repetir senha', isPassword: true),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E4931),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                      );},
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
                    onPressed: () { Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaLogin()),
                      );},
                    child: const Text(
                      'Já tem uma conta? Entre',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'ou continue com',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.g_mobiledata, size: 32),
                      SizedBox(width: 16),
                      Icon(Icons.facebook, size: 32),
                      SizedBox(width: 16),
                      Icon(Icons.camera_alt, size: 32),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 Widget _buildTextField(String label, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: isPassword,
        style: const TextStyle(color: Colors.black), // Define a cor do texto como preto
        decoration: InputDecoration(
          filled: true, // Garante que o campo esteja preenchido
          fillColor: Colors.white, // Define o fundo branco
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey), // Cor do placeholder
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.black), // Borda preta
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.green), // Borda verde ao focar
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }
}

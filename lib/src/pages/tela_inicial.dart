import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildContent(context),
        ],
      ),
    );
  }

  /// Background Image
  Widget _buildBackground() {
    return Positioned.fill(
      child: Image.asset(
        "lib/src/assets/images/tela-fundo.png",
        fit: BoxFit.cover,
      ),
    );
  }

  /// Main Content of the Screen
  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTitle(),
        const Spacer(),
        _buildLoginButton(context),
        _buildLoginText(),
        const SizedBox(height: 40),
      ],
    );
  }

  /// App Title
  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Center(
        child: Text(
          'EcoJourney',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.w900,
            shadows: [
              Shadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Login Button
  Widget _buildLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to login screen
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Inicie a jornada',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: Image.asset(
              "lib/src/assets/images/right-arrow.png",
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }

  /// Login Text
  Widget _buildLoginText() {
    return const Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text(
        'Já tem uma conta? Entre',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

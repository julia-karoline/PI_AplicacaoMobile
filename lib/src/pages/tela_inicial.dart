import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildContent(context, size),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Image.asset(
        "assets/images/tela-fundo.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildContent(BuildContext context, Size size) {
    final isSmallDevice = size.height < 600;
    final double maxContentWidth = 500; 

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: isSmallDevice ? 40 : size.height * 0.1),
              _buildTitle(size),
              const SizedBox(height: 40),
              _buildLoginButton(context, size),
              _buildLoginText(context, size),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(Size size) {
    final double fontSize = size.width > 500 ? 50 : size.width * 0.12;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Text(
          'EcoJourney',
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
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

  Widget _buildLoginButton(BuildContext context, Size size) {
    final double width = size.width > 500 ? 400 : size.width * 0.8;
    final double height = size.height * 0.07;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/cadastro');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Inicie a jornada',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width > 500 ? 20 : size.width * 0.055,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 10),
            Image.asset(
              "assets/images/right-arrow.png",
              width: size.width > 500 ? 24 : size.width * 0.08,
              height: size.width > 500 ? 24 : size.width * 0.08,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginText(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Text(
          'Já tem uma conta? Entre',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width > 500 ? 16 : size.width * 0.045,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

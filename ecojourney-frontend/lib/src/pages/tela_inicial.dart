import 'package:app_ecojourney/src/components/initial_action_buttons.dart';
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
        "assets/images/imagem_fundo.jpg",
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
              if (!isSmallDevice) const Spacer(),
              _buildTitle(size),
              const SizedBox(height: 40),
              InitialActionButtons(size: size),
              const SizedBox(height: 20),
              if (!isSmallDevice) const Spacer(),
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
            color: Color (0xFF0E4932),
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            shadows: [
              Shadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: Colors.white.withOpacity(0.25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

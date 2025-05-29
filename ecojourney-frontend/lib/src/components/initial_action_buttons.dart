import 'package:flutter/material.dart';

class InitialActionButtons extends StatelessWidget {
  final Size size;

  const InitialActionButtons({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final double width = size.width > 500 ? 400 : size.width * 0.8;
    final double height = size.height * 0.07;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/cadastro');
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 205, 248, 223).withOpacity(0.6),
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
                  'Criar conta',
                  style: TextStyle(
                    color: Colors.black,
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
        ),
        const SizedBox(height: 20),
        GestureDetector(
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
   
      ],
    );
  }
}

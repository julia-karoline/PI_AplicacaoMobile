import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 393,
            height: 852,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFFE0FEEA)),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 393,
                    height: 217,
                    decoration: BoxDecoration(
                      color: Color(0xFF0E4932),
                    ),
                  ),
                ),
                Positioned(
                  left: 19,
                  top: 780,
                  child: Container(
                    width: 394,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Color(0xFF0E4932),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Ícone 1
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset('lib/src/assets/images/home.png', fit: BoxFit.cover),
                        ),
                        // Ícone 2
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(),
                          child: Image.asset('lib/src/assets/images/book.png', fit: BoxFit.cover),
                        ),
                        // Ícone 3
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset('lib/src/assets/images/trophy.png', fit: BoxFit.fitWidth),
                        ),
                        // Ícone 4
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset('lib/src/assets/images/shopping.png', fit: BoxFit.fitWidth),
                        ),
                      ],
                    ),
                  ),
                ),
                // Imagem de perfil
                Positioned(
                  left: 19,
                  top: 59,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/src/assets/images/plant.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                // Nome do usuário
                Positioned(
                  left: 136,
                  top: 53,
                  child: Text(
                    'Giovana Muniz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  left: 134,
                  top: 222,
                  child: Text(
                    'Hábitos',
                    style: TextStyle(
                      color: Color(0xFF0E4932),
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  left: 155,
                  top: 97,
                  child: Text(
                    'Pegada de Carbono',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  left: 136,
                  top: 133,
                  child: Container(
                    width: 241,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  left: 196,
                  top: 133,
                  child: Text(
                    '0.89t CO2/ano',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  left: 188,
                  top: 159,
                  child: Text(
                    'Redução de: 10%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Combustível
                Positioned(
                  left: 19,
                  top: 276,
                  child: Container(
                    width: 328,
                    height: 113,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 261,
                  top: 276,
                  child: Container(
                    width: 86,
                    height: 113,
                    decoration: BoxDecoration(
                      color: Color(0xFF0E4932),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 26,
                  top: 276,
                  child: Text(
                    'Combustível',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  left: 274,
                  top: 301,
                  child: Text(
                    '50,0 ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  left: 280,
                  top: 338,
                  child: Text(
                    'Litros',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
                Positioned(
                  left: 26,
                  top: 304,
                  child: Text(
                    'Litros de álcool ou gasolina \nutilizados por mês\nVeículo:  Motocicleta\nCombustível: Gasolina\n',
                    style: TextStyle(
                      color: Color(0xFF232323),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                ),
                // Carne
                Positioned(
                  left: 19,
                  top: 400,
                  child: Container(
                    width: 328,
                    height: 113,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 261,
                  top: 400,
                  child: Container(
                    width: 86,
                    height: 113,
                    decoration: BoxDecoration(
                      color: Color(0xFF0E4932),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 26,
                  top: 409,
                  child: Text(
                    'Carne',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  left: 274,
                  top: 434,
                  child: Text(
                    '15,5 ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
                Positioned(
                  left: 280,
                  top: 461,
                  child: Text(
                    'kg',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
                Positioned(
                  left: 26,
                  top: 436,
                  child: Text(
                    'Consumo de carne por mês\nQuantidade: 15,5kg\nTipo de Carne: Bovina\n',
                    style: TextStyle(
                      color: Color(0xFF232323),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                ),
                // Energia Elétrica
                Positioned(
                  left: 19,
                  top: 520,
                  child: Container(
                    width: 328,
                    height: 113,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 261,
                  top: 520,
                  child: Container(
                    width: 86,
                    height: 113,
                    decoration: BoxDecoration(
                      color: Color(0xFF0E4932),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 26,
                  top: 529,
                  child: Text(
                    'Energia Elétrica',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  left: 274,
                  top: 554,
                  child: Text(
                    '75,0 ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  left: 280,
                  top: 581,
                  child: Text(
                    'kWh',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  left: 26,
                  top: 566,
                  child: Text(
                    'Consumo de energia\nTotal: 75kWh por mês\nFonte: Energia Elétrica\n',
                    style: TextStyle(
                      color: Color(0xFF232323),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

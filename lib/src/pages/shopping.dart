import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  decoration: ShapeDecoration(
                    color: Color(0xFF0E4932),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 19,
                top: 780,
                child: Container(
                  width: 394,
                  height: 72,
                  decoration: ShapeDecoration(
                    color: Color(0xFF0E4932),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Ícone 1
                      Container(
                        width: 54,
                        height: 54,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Image.asset('lib/src/assets/images/home.png',
                            fit: BoxFit.cover),
                      ),
                      // Ícone 2
                      Container(
                        width: 54,
                        height: 54,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(),
                        ),
                        child: Image.asset('lib/src/assets/images/book.png',
                            fit: BoxFit.cover),
                      ),
                      // Ícone 3
                      Container(
                        width: 54,
                        height: 54,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Image.asset('lib/src/assets/images/trophy.png',
                            fit: BoxFit.fitWidth),
                      ),
                      // Ícone 4
                      Container(
                        width: 54,
                        height: 54,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Image.asset('lib/src/assets/images/shopping.png',
                            fit: BoxFit.fitWidth),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 19,
                top: 59,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/src/assets/images/plant.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 136,
                top: 53,
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  child: Text('Giovana Muniz'),
                ),
              ),
              Positioned(
                left: 85,
                top: 223,
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Color(0xFF0E4932),
                    fontSize: 32,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  child: Text('Metas Diárias'),
                ),
              ),
              Positioned(
                left: 19,
                top: 300,
                child: Container(
                  width: 353,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 319,
                top: 300,
                child: Container(
                  width: 53,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: Color(0xFF0E4932),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Image.asset('lib/src/assets/images/add.png',
                      fit: BoxFit.fitHeight),
                ),
              ),
              Positioned(
                left: 30,
                top: 300,
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  child: Text('Nova meta'),
                ),
              ),
              Positioned(
                left: 19,
                top: 400,
                child: Container(
                  width: 353,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 319,
                top: 400,
                child: Container(
                  width: 53,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: Color(0xFF0E4932),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Image.asset('lib/src/assets/images/add.png',
                      fit: BoxFit.fitHeight),
                ),
              ),
              Positioned(
                left: 30,
                top: 400,
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  child: Text('Nova meta'),
                ),
              ),
              Positioned(
                left: 19,
                top: 500,
                child: Container(
                  width: 353,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 319,
                top: 500,
                child: Container(
                  width: 53,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: Color(0xFF0E4932),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Image.asset('lib/src/assets/images/add.png',
                      fit: BoxFit.fitHeight),
                ),
              ),
              Positioned(
                left: 30,
                top: 500,
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  child: Text('Nova meta'),
                ),
              ),
              Positioned(
                left: 181,
                top: 101,
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  child: SizedBox(
                    width: 150,
                    child: Text(
                      'Pontos:  18.750',
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 135,
                top: 138,
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                  child: SizedBox(
                    width: 242,
                    height: 21,
                    child: Text(
                      '10 dias ajudando a salvar o mundo',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

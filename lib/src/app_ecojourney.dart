import 'package:app_ecojourney/src/pages/home_page.dart';
import 'package:app_ecojourney/src/pages/login.dart';
import 'package:app_ecojourney/src/pages/tela_inicial.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class AppEcojourney extends StatelessWidget {
  const AppEcojourney({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AppEcojourney',
        home: TelaInicial());
  }
}
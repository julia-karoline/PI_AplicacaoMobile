import 'package:app_ecojourney/src/pages/info_screen.dart';
import 'package:app_ecojourney/src/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:app_ecojourney/src/pages/RankingScreen.dart';
import 'package:app_ecojourney/src/pages/shopping.dart';
import 'package:app_ecojourney/src/pages/cadastro.dart';
import 'package:app_ecojourney/src/pages/daily_goals_screen/daily_goals_screen.dart';
import 'package:app_ecojourney/src/pages/tela_inicial.dart'; 

class AppEcojourney extends StatelessWidget {
  const AppEcojourney({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppEcojourney',
      initialRoute: '/inicial', 
      routes: {
        '/inicial': (context) => const TelaInicial(), 
        '/cadastro': (context) => const CadastroScreen(),
        '/login': (context) => const TelaLogin(),
        '/home': (context) => const DailyGoalsScreen(),
        '/ranking': (context) => const RankingScreen(),
        '/shopping': (context) => const RewardsScreen(),
        '/habitos': (context) => const InfoScreen(),
      },
    );
  }
}

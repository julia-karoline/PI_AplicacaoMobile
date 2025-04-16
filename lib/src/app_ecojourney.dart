import 'package:app_ecojourney/src/pages/RankingScreen.dart';
import 'package:app_ecojourney/src/pages/shopping.dart';
import 'package:flutter/material.dart';
import 'package:app_ecojourney/src/pages/cadastro.dart';
import 'package:app_ecojourney/src/pages/daily_goals_screen.dart';



class AppEcojourney extends StatelessWidget {
  const AppEcojourney({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppEcojourney',
      initialRoute: '/cadastro',
      routes: {
        '/cadastro': (context) => const CadastroScreen(),
        '/home': (context) => const DailyGoalsScreen(),
        '/ranking': (context) => const RankingScreen(),
        '/shopping': (context) => const RewardsScreen(),
      },
    );
  }
}

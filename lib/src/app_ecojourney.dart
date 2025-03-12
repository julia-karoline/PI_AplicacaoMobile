import 'package:app_ecojourney/src/pages/home_page.dart';
import 'package:flutter/material.dart';

class AppEcojourney extends StatelessWidget {
  const AppEcojourney({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AppEcojourney',
        home: HomePage());
  }
}

import 'package:app_ecojourney/src/app_ecojourney.dart';
import 'package:app_ecojourney/src/components/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: AppEcojourney(),
    ));
}

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String name = '';
  double points = 0;
  int daysUsingApp = 0;

  void updateUser({
    required String name,
    required double points,
    int? days,
  }) {
    this.name = name;
    this.points = points;
    if (days != null) {
      daysUsingApp = days;
    }
    notifyListeners();
  }

  void addPoints(double value) {
    points += value;
    notifyListeners();
  }

  void subtractPoints(double value) {
    points = (points - value).clamp(0, double.infinity);
    notifyListeners();
  }

  void resetUser() {
    name = '';
    points = 0;
    daysUsingApp = 0;
    notifyListeners();
  }
}

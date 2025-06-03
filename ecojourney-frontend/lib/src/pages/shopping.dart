// ... imports

import 'package:app_ecojourney/src/components/bottom_nav_bar.dart';
import 'package:app_ecojourney/src/components/reward_confirmation_dialog.dart';
import 'package:app_ecojourney/src/components/rewards_card.dart';
import 'package:app_ecojourney/src/components/user_header.dart';
import 'package:app_ecojourney/src/services/auth_api_service.dart';
import 'package:flutter/material.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  String userName = "Carregando...";
  int userPoints = 0;
  int daysUsingApp = 10;

  final List<Map<String, dynamic>> coupons = [
    {
      'title': 'Cosméticos',
      'description': '10% off em produtos de beleza - 20.000 pontos',
      'pointsRequired': 20000,
      'redeemed': false,
    },
    {
      'title': 'Esportes',
      'description': '20% off em itens esportivos - 18.000 pontos',
      'pointsRequired': 18000,
      'redeemed': false,
    },
    {
      'title': 'Moda e Acessórios',
      'description': '15% off em moda - 15.000 pontos',
      'pointsRequired': 15000,
      'redeemed': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    await Future.delayed(const Duration(seconds: 1));
    final name = await AuthApiService.getUserName();
    final points = await AuthApiService.getUserPoints();

    setState(() {
      userName = name ?? 'Usuário';
      userPoints = points ?? 0;
    });
  }

 void _redeemCoupon(int index) async {
  final cupom = coupons[index];
  final pontosNecessarios = cupom['pointsRequired'] as int;

  if (userPoints >= pontosNecessarios) {
    final success = await AuthApiService.redeemPoints(pontosNecessarios);

    if (success) {
      setState(() {
        coupons[index]['redeemed'] = true;
      });

      final updatedPoints = await AuthApiService.getUserPoints();
      setState(() {
        userPoints = updatedPoints ?? userPoints;
      });

      await showRewardConfirmationDialog(
        context: context,
        title: cupom['title'],
        discountCode: 'ECO10OFF-${index + 1}0',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao resgatar o cupom. Tente novamente.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Você precisa de mais pontos para resgatar este cupom.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}



  void _onNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/habitos');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/ranking');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/shopping');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/home');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("")),
      bottomNavigationBar: BottomNavBar(currentIndex: 2, onTap: _onNavTap),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserHeader(
              userName: userName,
              userPoints: userPoints,
              daysUsingApp: daysUsingApp,
            ),
            const SizedBox(height: 20),
            const Text(
              "Recompensas Disponíveis",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "Troque seus pontos por descontos e recompensas sustentáveis!",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: coupons.length,
                itemBuilder: (context, index) {
                  final coupon = coupons[index];
                  return RewardsCard(
                    key: ValueKey(coupon['title']),
                    title: coupon['title'],
                    description: coupon['description'],
                    isCompleted: coupon['redeemed'],
                    onCheck: () => _redeemCoupon(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

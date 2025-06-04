import 'package:app_ecojourney/src/components/bottom_nav_bar.dart';
import 'package:app_ecojourney/src/components/reward_confirmation_dialog.dart';
import 'package:app_ecojourney/src/components/rewards_card.dart';
import 'package:app_ecojourney/src/components/user_header.dart';
import 'package:app_ecojourney/src/components/user_provider.dart';
import 'package:app_ecojourney/src/services/auth_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  String userName = "Carregando...";
  double userPoints = 0;
  
  int daysUsingApp = 10;

  final List<Map<String, dynamic>> coupons = [
    {
      'title': 'Cosméticos',
      'description': '10% off em produtos de beleza - 20 pontos',
      'pointsRequired': 20,
      'redeemed': false,
    },
    {
      'title': 'Esportes',
      'description': '5% off em itens esportivos - 18 pontos',
      'pointsRequired': 18,
      'redeemed': false,
    },
    {
      'title': 'Moda e Acessórios',
      'description': '15% off em moda - 15 pontos',
      'pointsRequired': 15,
      'redeemed': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadRedeemedCoupons();
  }

Future<void> _loadUserInfo() async {
  final name = await AuthApiService.getUserName();
  final points = await AuthApiService.getUserPoints();

  if (!mounted) return; 

  final userProvider = Provider.of<UserProvider>(context, listen: false);
  userProvider.updateUser(
    name: name ?? 'Usuário',
    points: points?.toDouble() ?? 0.0,
  );


  setState(() {
    userName = name ?? 'Usuário';
  });
}
Future<void> _saveRedeemedCoupons() async {
  final prefs = await SharedPreferences.getInstance();
  final redeemedTitles = coupons
      .where((c) => c['redeemed'] == true)
      .map((c) => c['title'].toString())
      .toList();
  await prefs.setStringList('redeemedCoupons', redeemedTitles);
}

 void _redeemCoupon(int index) async {
  final cupom = coupons[index];
  final pontosNecessarios = (cupom['pointsRequired'] as num).toInt();

  final userProvider = Provider.of<UserProvider>(context, listen: false);

  if (userProvider.points >= pontosNecessarios) {
    final success = await AuthApiService.redeemPoints(pontosNecessarios);

    if (success) {
      setState(() {
        coupons[index]['redeemed'] = true;
        

      });
    await _saveRedeemedCoupons();
      final updatedPoints = await AuthApiService.getUserPoints();
      if (updatedPoints != null) {
        userProvider.updateUser(
          name: userProvider.name,
          points: updatedPoints.toDouble(),
        );
      }

      await showRewardConfirmationDialog(
        context: context,
        title: cupom['title'],
        discountCode: 'ECO10OFF-${index + 1}0',
      );
    } else {
      _showSnackBar('Erro ao resgatar o cupom. Tente novamente.');
    }
  } else {
    _showSnackBar('Você precisa de mais pontos para resgatar este cupom.');
  }
}


Future<void> _loadRedeemedCoupons() async {
  final prefs = await SharedPreferences.getInstance();
  final redeemed = prefs.getStringList('redeemedCoupons') ?? [];

  setState(() {
    for (var c in coupons) {
      c['redeemed'] = redeemed.contains(c['title']);
    }
  });
}

void _showSnackBar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
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
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("")),
      bottomNavigationBar: BottomNavBar(currentIndex: 2, onTap: _onNavTap),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            UserHeader(
              userName: userProvider.name,
              userPoints: userProvider.points,
              daysUsingApp: userProvider.daysUsingApp,
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

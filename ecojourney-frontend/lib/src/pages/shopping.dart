import 'package:flutter/material.dart';
import '../components/user_header.dart';
import '../components/bottom_nav_bar.dart';
import '../components/rewards_card.dart';
import 'package:app_ecojourney/src/services/auth_api_service.dart';



class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  String userName = "Carregando...";
  int userPoints = 0;
  int daysUsingApp = 10;

  List<Map<String, dynamic>> coupons = [
    {
      'title': 'Cosméticos',
      'description': '10% off na compra de produtos de beleza por 20000 pontos',
      'pointsRequired': 20000,
      'redeemed': false,
    },
    {
      'title': 'Esportes',
      'description': '20% off na compra de itens esportivos por 18000 pontos',
      'pointsRequired': 18000,
      'redeemed': false,
    },
    {
      'title': 'Moda e Acessórios',
      'description': '15% off em moda por 15000 pontos',
      'pointsRequired': 15000,
      'redeemed': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _carregarUsuario();
  }

  void _carregarUsuario() async {
    final nome = await AuthApiService.getUserName();
    final pontos = await AuthApiService.getUserPoints();


    setState(() {
      userName = nome ?? 'Usuário';
      userPoints = pontos ?? 120;
    });
  }

  void _resgatarCupom(int index) {
    final cupom = coupons[index];
    final pontosNecessarios = cupom['pointsRequired'] as int;

    if (userPoints >= pontosNecessarios) {
      setState(() {
        userPoints -= pontosNecessarios;
        coupons[index]['redeemed'] = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cupom "${cupom['title']}" resgatado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Você precisa de mais pontos para resgatar este cupom.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void onNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/ranking');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/shopping');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/habitos');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("")),
      bottomNavigationBar: BottomNavBar(currentIndex: 2, onTap: onNavTap),
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
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: coupons.length,
                itemBuilder: (context, index) {
                  final cupom = coupons[index];

                  return RewardsCard(
                    key: ValueKey(cupom['title']),
                    title: cupom['title'],
                    description: cupom['description'],
                    isCompleted: cupom['redeemed'],
                    onCheck: () => _resgatarCupom(index),
                    onEdit: () {},
                    onDelete: () {},
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

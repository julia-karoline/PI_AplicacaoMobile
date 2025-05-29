import 'package:app_ecojourney/src/components/user_header.dart';
import 'package:app_ecojourney/src/components/bottom_nav_bar.dart';
import 'package:app_ecojourney/src/components/ranking_card.dart';
import 'package:app_ecojourney/src/services/auth_api_service.dart';
import 'package:flutter/material.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  String userName = "Carregando...";
  int userPoints = 0;
  bool isLoading = true;
  List<Map<String, dynamic>> ranking = [];

  @override
  void initState() {
    super.initState();
    _carregarUsuario();
    _carregarRanking();
  }

  void _carregarUsuario() async {
    final nome = await AuthApiService.getUserName();
    final pontos = await AuthApiService.getUserPoints();
    setState(() {
      userName = nome ?? 'Usuário';
      userPoints = pontos ?? 0;
    });
  }

  void _carregarRanking() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulação de carregamento

    final dados = [
      {'name': '12/05/2025', 'days': 5, 'points': 30000},
      {'name': '11/05/2025', 'days': 4, 'points': 27500},
      {'name': '10/05/2025', 'days': 3, 'points': 18750},
      {'name': '09/05/2025', 'days': 2, 'points': 10000},
      {'name': '08/06/2025', 'days': 1, 'points': 4000},
    ];

    setState(() {
      ranking = dados;
      isLoading = false;
    });
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
      appBar: AppBar(
        title: const Text("Seu Ranking"),
        centerTitle: true,
        backgroundColor: const Color(0xFF0E4932),
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1, onTap: onNavTap),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            const Text(
              'Ranking',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ranking.isEmpty
                      ? const Center(child: Text("Nenhum dado disponível"))
                      : ListView.builder(
                          itemCount: ranking.length,
                          itemBuilder: (context, index) {
                            final item = ranking[index];
                            return RankingCard(
                              position: index + 1,
                              date: item['name'],
                              days: item['days'],
                              points: item['points'],
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0E4932),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.eco, color: Colors.green, size: 40),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserHeader(userName: userName, userPoints: userPoints, daysUsingApp: 0),
                const SizedBox(height: 4),
                Text(
                  'Pontos: $userPoints',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const Icon(Icons.emoji_events, color: Colors.white),
        ],
      ),
    );
  }
}

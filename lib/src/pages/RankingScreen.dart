import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  List<Map<String, dynamic>> ranking = [
    {'name': 'Daniela', 'days': 25, 'points': 30000},
    {'name': 'Carlos Henri...', 'days': 30, 'points': 27500},
    {'name': 'Giovana Muniz', 'days': 10, 'points': 18750},
    {'name': 'Julia Karoline', 'days': 5, 'points': 10000},
    {'name': 'Thalison', 'days': 2, 'points': 4000},
  ];

  void onNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
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
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: onNavTap,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0E4932), // Cor atualizada aqui
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Giovana Muniz',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Pontos: 18.750',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: const [
                      Icon(Icons.emoji_events, color: Colors.white, size: 24),
                      Text(
                        '20º',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ranking',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: ranking.length,
                itemBuilder: (context, index) {
                  final user = ranking[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0E4932),
                        ),
                      ),
                      title: Text(user['name']),
                      subtitle: Text('${user['days']} dias'),
                      trailing: Text(
                        '${user['points']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
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

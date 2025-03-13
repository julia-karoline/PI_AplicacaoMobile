import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RankingScreen(),
    );
  }
}

class RankingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> ranking = [
    {'name': 'Daniela', 'days': 25, 'points': 30000},
    {'name': 'Carlos Henri...', 'days': 30, 'points': 27500},
    {'name': 'Giovana Muniz', 'days': 10, 'points': 18750},
    {'name': 'Julia Karoline', 'days': 5, 'points': 10000},
    {'name': 'Thalison', 'days': 2, 'points': 4000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFF5E3),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green.shade900,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.green.shade900,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.eco, color: Colors.green, size: 40),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                Spacer(),
                Column(
                  children: [
                    Icon(Icons.emoji_events, color: Colors.white, size: 24),
                    Text(
                      '20º',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ranking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ranking.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                    ),
                    title: Text(ranking[index]['name']),
                    subtitle: Text('${ranking[index]['days']} dias'),
                    trailing: Text(
                      '${ranking[index]['points']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

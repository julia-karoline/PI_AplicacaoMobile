class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green[900],
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(Icons.eco, color: Colors.green[900], size: 40),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Giovana Muniz',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Pontos:',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Text(
                  '18.750',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green[100],
            width: double.infinity,
            child: const Text(
              'Recompensas',
              style: TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: const [
                RewardCard(
                  title: 'Cosméticos',
                  description: '10% off na compra de produtos de beleza',
                  points: 20000,
                ),
                RewardCard(
                  title: 'Esportes',
                  description: 'R\$10,00 off na compra de itens esportivos',
                  points: 15000,
                ),
                RewardCard(
                  title: 'Moda & Acessórios',
                  description: '15% off na compra de produtos de beleza',
                  points: 35000,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  final String title;
  final String description;
  final int points;

  const RewardCard({
    super.key,
    required this.title,
    required this.description,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$description\nPor: $points pontos'),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}

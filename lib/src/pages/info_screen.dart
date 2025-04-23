import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';



class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String userName = "Lucas";
  double carbonFootprint = 125.5; 
  double reductionPercentage = 10.0;

  List<Map<String, dynamic>> habits = [
    {
      'title': 'Consumo de Carne',
      'description': 'Seu consumo mensal de carne',
      'value': '5 Kg'
    },
    {
      'title': 'Uso de Energia',
      'description': 'Consumo médio mensal',
      'value': '120 kWh'
    },
  ];

  void editHabit(int index) {
    final habit = habits[index];
    final titleController = TextEditingController(text: habit['title']);
    final descriptionController = TextEditingController(text: habit['description']);
    final valueController = TextEditingController(text: habit['value']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Hábito'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              TextField(
                controller: valueController,
                decoration: const InputDecoration(labelText: 'Quantidade'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  habits[index]['title'] = titleController.text.trim();
                  habits[index]['description'] = descriptionController.text.trim();
                  habits[index]['value'] = valueController.text.trim();
                });
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void deleteHabit(int index) {
    setState(() {
      habits.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Hábito removido com sucesso.')),
    );
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
      bottomNavigationBar: BottomNavBar(currentIndex: 3, onTap: onNavTap),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF0E4932),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
                  ),
                  const SizedBox(width: 18),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá, $userName',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Pegada de Carbono: ${carbonFootprint.toStringAsFixed(2)} kg CO₂',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        'Redução de: ${reductionPercentage.toStringAsFixed(1)}%',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Hábitos",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(habit['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(habit['description']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(habit['value'], style: const TextStyle(fontSize: 16)),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => editHabit(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteHabit(index),
                          ),
                        ],
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

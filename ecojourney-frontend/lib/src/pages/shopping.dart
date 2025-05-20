import 'package:app_ecojourney/src/components/rewards_card.dart';
import 'package:flutter/material.dart';
import '../components/user_header.dart';
import '../components/bottom_nav_bar.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  String userName = "Lucas";
  int userPoints = 120;
  int daysUsingApp = 10;

  List<Map<String, dynamic>> dailyGoals = [
    {
      'title': 'Cosméticos',
      'description':
          '10% off na compra de produtos\nde beleza \npor 20.000 pontos',
      'completed': false,
    },
    {
      'title': 'Esportes',
      'description': '20% off na compra de itens esportivos \n 18.000 pontos',
      'completed': false,
    },
    {
      'title': 'Moda e Acessórios',
      'description': '15% off na compra de produtos de beleza\n 15.000 pontos',
      'completed': false,
    },
  ];

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: const Text('Tem certeza que deseja excluir esta meta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  dailyGoals.removeAt(index);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Meta excluída com sucesso.')),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  void editGoal(int index) {
    final goal = dailyGoals[index];
    final titleController = TextEditingController(text: goal['title']);
    final descriptionController =
        TextEditingController(text: goal['description']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Meta'),
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _confirmDelete(index);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Excluir'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedTitle = titleController.text.trim();
                final updatedDescription = descriptionController.text.trim();

                if (updatedTitle.isEmpty || updatedDescription.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Preencha todos os campos.")),
                  );
                  return;
                }

                setState(() {
                  dailyGoals[index]['title'] = updatedTitle;
                  dailyGoals[index]['description'] = updatedDescription;
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


  void toggleGoal(int index) {
    setState(() {
      dailyGoals[index]['completed'] = !dailyGoals[index]['completed'];
    });

    if (dailyGoals[index]['completed']) {
      setState(() {
        userPoints += 10;
      });
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
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: onNavTap,
      ),
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
              "Rewards",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: dailyGoals.length,
                itemBuilder: (context, index) {
                  final goal = dailyGoals[index];
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: RewardsCard(
                      key: ValueKey(goal['completed']),
                      title: goal['title'],
                      description: goal['description'],
                      isCompleted: goal['completed'],
                      onCheck: () => toggleGoal(index),
                      onEdit: () => editGoal(index),
                      onDelete: () => _confirmDelete(index),
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

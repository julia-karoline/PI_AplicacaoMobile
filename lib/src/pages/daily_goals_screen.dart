import 'package:flutter/material.dart';
import '../components/user_header.dart';
import '../components/daily_goal_card.dart';
import '../components/bottom_nav_bar.dart';
import 'package:app_ecojourney/src/pages/login.dart';
import 'package:app_ecojourney/src/services/auth_api_service.dart';

class DailyGoalsScreen extends StatefulWidget {
  const DailyGoalsScreen({super.key});

  @override
  State<DailyGoalsScreen> createState() => _DailyGoalsScreenState();
}

class _DailyGoalsScreenState extends State<DailyGoalsScreen> {
  String userName = "Lucas";
  int userPoints = 120;
  int daysUsingApp = 10;

  List<Map<String, dynamic>> dailyGoals = [
    {
      'title': 'Reciclagem',
      'description': 'Separar lixo reciclável e orgânico para coleta apropriada',
      'completed': false,
    },
    {
      'title': 'Economia de energia',
      'description': 'Desligar aparelhos da tomada quando não estiver usando',
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
  final descriptionController = TextEditingController(text: goal['description']);

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


  void _showAddGoalDialog() {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Nova Meta"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Descrição"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final newTitle = titleController.text.trim();
              final newDescription = descriptionController.text.trim();

              if (newTitle.isEmpty || newDescription.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Preencha todos os campos.")),
                );
                return;
              }

              setState(() {
                dailyGoals.add({
                  'title': newTitle,
                  'description': newDescription,
                  'completed': false,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(200, 50, 124, 96)),
            child: const Text("Adicionar"),
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
  appBar: AppBar(title: const Text(""),
  actions: [
    IconButton(
      icon: const Icon(Icons.logout),
      tooltip: "Sair",
      onPressed: () async {
        await AuthApiService.logout();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const TelaLogin()),
          (route) => false,
        );
      },
    ),
  ],
  ),
  
  bottomNavigationBar: BottomNavBar(
    currentIndex: 0,
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
          "Metas diárias",
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
                child: DailyGoalCard(
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
  floatingActionButton: FloatingActionButton(
  onPressed: _showAddGoalDialog,
  backgroundColor: Color(0xFF0E4932),
  child: const Icon(
    Icons.add,
    color: Colors.white,
  ),
),

);

  }
}
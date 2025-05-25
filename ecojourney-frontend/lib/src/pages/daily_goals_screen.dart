import 'package:app_ecojourney/src/services/api_service.dart';
import 'package:flutter/material.dart';
import '../components/user_header.dart';
import '../components/daily_goal_card.dart';
import '../components/bottom_nav_bar.dart';
import 'package:app_ecojourney/src/services/auth_api_service.dart';

class DailyGoalsScreen extends StatefulWidget {
  const DailyGoalsScreen({super.key});

  @override
  
  State<DailyGoalsScreen> createState() => _DailyGoalsScreenState();
  
}

class _DailyGoalsScreenState extends State<DailyGoalsScreen> {
  String userName = "Carregando...";
  int userPoints = 120;
  int daysUsingApp = 10;

  List<Map<String, dynamic>> dailyGoals = [];

  
void _mostrarSugestaoIA(List<String> habitos, double pegada) async {
  try {
    final sugestoes = await ApiService.fetchSuggestionsFromIA(
      habits: habitos,
      carbonFootprint: pegada,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.bolt, color: Color(0xFF0E4932)),
            SizedBox(width: 8),
            Text('Sugestões da IA'),
          ],
        ),
        content: SizedBox(
          height: 200,
          width: double.maxFinite,
          child: ListView.separated(
            itemCount: sugestoes.length,
            separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.check_circle_outline, color: Color(0xFF0E4932)),
                title: Text(
                  sugestoes[index],
                  style: TextStyle(fontSize: 16),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.check, color: Color(0xFF0E4932)),
            label: Text(
              'OK',
              style: TextStyle(color: Color(0xFF0E4932)),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  } catch (e) {
    print("Erro IA: $e");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Erro'),
        content: Text('Erro ao obter sugestões: $e'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Fechar'))
        ],
      ),
    );
  }
}

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
            onPressed: () async {
              try {
                await ApiService.deleteDailyGoal(dailyGoals[index]['id']);
                setState(() {
                  dailyGoals.removeAt(index);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Meta excluída com sucesso.')),
                );
              } catch (e) {
                print('Erro ao excluir meta: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Erro ao excluir meta')),
                );
              }
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
            onPressed: () async {
              final updatedTitle = titleController.text.trim();
              final updatedDescription = descriptionController.text.trim();

              if (updatedTitle.isEmpty || updatedDescription.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Preencha todos os campos.")),
                );
                return;
              }

              try {
                await ApiService.updateDailyGoal(
                  id: goal['id'],
                  title: updatedTitle,
                  description: updatedDescription,
                  completed: goal['completed'],
                );

                setState(() {
                  dailyGoals[index]['title'] = updatedTitle;
                  dailyGoals[index]['description'] = updatedDescription;
                });

                Navigator.pop(context);
              } catch (e) {
                print('Erro ao atualizar meta: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Erro ao atualizar meta")),
                );
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
}


  void _showAddGoalDialog() async {
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
              onPressed: () async {
                final newTitle = titleController.text.trim();
                final newDescription = descriptionController.text.trim();

                if (newTitle.isEmpty || newDescription.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Preencha todos os campos.")),
                  );
                  return;
                }

                try {
                  final novaMeta = await ApiService.createDailyGoal(
                    title: newTitle,
                    description: newDescription,
                  );

                  setState(() {
                    dailyGoals.add({
                      'id': novaMeta['id'],
                      'title': newTitle,
                      'description': newDescription,
                      'completed': false,
                    });
                  });

                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao salvar meta: $e')),
                  );
                }
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




void _mostrarFormularioIA() {
  final habitosController = TextEditingController();
  final pegadaController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Obter sugestões da IA'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: habitosController,
              decoration: InputDecoration(labelText: 'Descreva seus hábitos'),
            ),
            TextField(
              controller: pegadaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Pegada de carbono estimada (kg CO₂)'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancelar')),
          ElevatedButton(
            onPressed: () async {
              final habitosTexto = habitosController.text.trim();
              final pegadaTexto = pegadaController.text.trim();
              if (habitosTexto.isEmpty || pegadaTexto.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Preencha todos os campos')),
                );
                return;
              }

              final pegada = double.tryParse(pegadaTexto) ?? 120.0;
              final habitos = habitosTexto.split(',').map((e) => e.trim()).toList();

              Navigator.pop(context); // fecha o diálogo atual

              _mostrarSugestaoIA(habitos, pegada);
            },
            child: Text('Gerar sugestões'),
          ),
        ],
      );
    },
  );
}





@override
void initState() {
  super.initState();
  _carregarUsuario();
  _carregarMetasDoBackend();
}

void _carregarUsuario() async {
  final nome = await AuthApiService.getUserName();
  setState(() {
    userName = nome ?? 'Usuário';
  });
}
void _carregarMetasDoBackend() async {
  try {
    final metas = await ApiService.fetchDailyGoals();
    print("Metas recebidas do backend: $metas"); 
    setState(() {
      dailyGoals = metas.map((m) => {
        'id': m['id'],
        'title': m['title'],
        'description': m['description'],
        'completed': m['completed'] == true || m['completed'] == 1,
      }).toList();
    });
  } catch (e) {
    print('Erro ao carregar metas: $e');
  }
}



@override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text("")),
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

    ElevatedButton.icon(
  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0E4932)),
  onPressed: _mostrarFormularioIA, // Chama o formulário para inserir hábitos e pegada
  icon: const Icon(Icons.bolt, color: Colors.white),
  label: const Text('Obter sugestão da IA', style: TextStyle(color: Colors.white)),
),

    const SizedBox(height: 10),

    Expanded(
      child: ListView(
        children: [
          ...dailyGoals.asMap().entries.map((entry) {
            int index = entry.key;
            final goal = entry.value;
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: DailyGoalCard(
               key: ValueKey(goal['id'] ?? index),
                title: goal['title'],
                description: goal['description'],
                isCompleted: goal['completed'],
                onCheck: () => toggleGoal(index),
                onEdit: () => editGoal(index),
                onDelete: () => _confirmDelete(index),
              ),
            );
          }),
        ],
      ),
    ),
  ],
),
    ),
    
    floatingActionButton: FloatingActionButton(
      onPressed: _showAddGoalDialog,
      backgroundColor: const Color(0xFF0E4932),
      child: const Icon(Icons.add, color: Colors.white),
    ),
    
  );
  
}
}
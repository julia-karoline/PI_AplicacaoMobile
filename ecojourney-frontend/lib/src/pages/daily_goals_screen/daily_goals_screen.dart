import 'package:app_ecojourney/src/components/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_ecojourney/src/components/user_header.dart';
import 'package:app_ecojourney/src/components/bottom_nav_bar.dart';
import 'package:app_ecojourney/src/services/api_service.dart';
import 'package:app_ecojourney/src/services/auth_api_service.dart';
import 'package:app_ecojourney/src/pages/daily_goals_screen/daily_goal_list.dart';
import 'package:app_ecojourney/src/pages/daily_goals_screen/daily_goal_form_dialog.dart';
import 'package:app_ecojourney/src/pages/daily_goals_screen/delete_confirmation_dialog.dart';
import 'package:app_ecojourney/src/pages/daily_goals_screen/ia_form_dialog.dart';
import 'package:app_ecojourney/src/pages/daily_goals_screen/ia_suggestions_dialog.dart';
import 'package:provider/provider.dart';

class DailyGoalsScreen extends StatefulWidget {
  const DailyGoalsScreen({super.key});

  @override
  State<DailyGoalsScreen> createState() => _DailyGoalsScreenState();
}

class _DailyGoalsScreenState extends State<DailyGoalsScreen> {
  String userName = "Carregando...";
  double userPoints = 0;
  int daysUsingApp = 10;
  List<Map<String, dynamic>> dailyGoals = [];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadDailyGoals();
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



  Future<void> _loadDailyGoals() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final metas = await ApiService.fetchDailyGoals();
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

void _toggleGoal(int index) async {
  final goal = dailyGoals[index];
  final completed = !goal['completed'];

  final success = await ApiService.updateDailyGoal(
    id: goal['id'],
    title: goal['title'],
    description: goal['description'],
    completed: completed,
  );

  if (success) {
    if (completed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Meta concluída! +10 pontos 🎉'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      await Future.delayed(const Duration(seconds: 2)); 

      await ApiService.deleteDailyGoal(goal['id']);
      await _loadUserInfo(); 
    }

    _loadDailyGoals();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Erro ao atualizar a meta')),
    );
  }
}




  void _addOrEditGoal([int? index]) async {
  final goal = index != null ? dailyGoals[index] : null;

  final result = await showDialog<Map<String, String>>(
    context: context,
    builder: (_) => DailyGoalFormDialog(
      initialTitle: goal?['title'],
      initialDescription: goal?['description'],
    ),
  );

  if (result != null) {
    final title = result['title']!;
    final description = result['description']!;

    try {
      if (index == null) {
        final novaMeta = await ApiService.createDailyGoal(
          title: title,
          description: description,
        );
        setState(() {
          dailyGoals.add({
            'id': novaMeta['id'],
            'title': title,
            'description': description,
            'completed': false,
          });
        });
      } else {
        await ApiService.updateDailyGoal(
          id: goal!['id'],
          title: title,
          description: description,
          completed: goal['completed'],
        );
        setState(() {
          dailyGoals[index]['title'] = title;
          dailyGoals[index]['description'] = description;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar meta: $e')),
      );
    }
  }
}



  void _deleteGoal(int index) {
    showDialog(
  context: context,
  builder: (_) => DeleteConfirmationDialog(
    title: 'Confirmar exclusão',
    content: 'Tem certeza que deseja excluir esta meta?',
    onConfirm: () async {
      try {
        await ApiService.deleteDailyGoal(dailyGoals[index]['id']);
        setState(() {
          dailyGoals.removeAt(index);
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao excluir meta')),
        );
      }
    },
  ),
);

  }

void _openIaFormDialog() {
  showDialog(
    context: context,
    builder: (_) => IaFormDialog(
      onConfirm: (habits, footprint) async {
        final suggestions = await ApiService.fetchSuggestionsFromIA(
          habits: habits,
          carbonFootprint: footprint,
        );

        showIaSuggestionsDialog(
          context: context,
          suggestions: suggestions,
          onSuggestionSelected: (selected) async {
            try {
              final novaMeta = await ApiService.createDailyGoal(
                title: selected,
                description: 'Meta sugerida pela IA',
              );
              setState(() {
                dailyGoals.add({
                  'id': novaMeta['id'],
                  'title': selected,
                  'description': 'Meta sugerida pela IA',
                  'completed': false,
                });
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Meta "$selected" criada com sucesso!')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Erro ao criar meta.')),
              );
            }
          },
        );
      },
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
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: _onNavTap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditGoal(),
        backgroundColor: const Color(0xFF0E4932),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserHeader(
              userName: userName,
              userPoints: userProvider.points,
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
              onPressed: _openIaFormDialog,
              icon: const Icon(Icons.bolt, color: Colors.white),
              label: const Text('Obter sugestão da IA', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: DailyGoalList(
                goals: dailyGoals,
                onCheck: _toggleGoal,
                onEdit: _addOrEditGoal,
                onDelete: _deleteGoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

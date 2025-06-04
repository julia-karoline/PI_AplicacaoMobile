import 'package:app_ecojourney/src/components/user_provider.dart';
import 'package:app_ecojourney/src/pages/habits_screen/habit_delete_dialog.dart';
import 'package:app_ecojourney/src/pages/habits_screen/habit_form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:app_ecojourney/src/components/bottom_nav_bar.dart';
import 'package:app_ecojourney/src/components/user_header.dart';
import 'package:app_ecojourney/src/components/habit_card.dart';
import 'package:app_ecojourney/src/services/api_service.dart';
import 'package:app_ecojourney/src/services/auth_api_service.dart';
import 'package:app_ecojourney/src/utils/carbon_utils.dart';
import 'package:provider/provider.dart';



class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreen();
}

class _HabitsScreen extends State<HabitsScreen> {
  List<Map<String, dynamic>> habits = [];
  double userCarbonFootprint = 0.0;
  bool isLoading = true;
   int daysUsingApp = 10;

  @override
  void initState() {
    super.initState();

    _carregarHabitos();
  }



  Future<void> _carregarHabitos() async {
    try {
      final data = await ApiService.fetchHabits();
      final novaPegada = calcularPegadaCarbono(data);
      setState(() {
        habits = data;
        userCarbonFootprint = novaPegada;
        isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar hábitos: $e');
      setState(() => isLoading = false);
    }
  }

  void _addOrEditHabit({int? index}) {
    final habit = index != null ? habits[index] : null;
    showDialog(
      context: context,
      builder: (_) => HabitFormDialog(
        initialHabit: habit,
        onSubmit: (data) async {
          try {
            if (habit == null) {
              final novoHabito = await ApiService.createHabit(
                title: data['title'],
                description: data['description'],
                value: data['value'],
                unit: data['unit'],
              );
              setState(() => habits.add(novoHabito));
            } else {
              await ApiService.updateHabit(
                id: habit['id'],
                title: data['title'],
                description: data['description'],
                value: data['value'],
                unit: data['unit'],
              );
              setState(() {
                habits[index!] = {
                  'id': habit['id'],
                  ...data,
                };
              });
            }
            setState(() {
              userCarbonFootprint = calcularPegadaCarbono(habits);
            });
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro ao salvar hábito: $e')),
            );
          }
        },
      ),
    );
  }

  void _deleteHabit(int index) {
    showDeleteHabitDialog(
      context: context,
      onConfirm: () async {
        try {
          await ApiService.deleteHabit(habits[index]['id']);
          setState(() {
            habits.removeAt(index);
            userCarbonFootprint = calcularPegadaCarbono(habits);
          });
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao excluir hábito')),
          );
        }
      },
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
      bottomNavigationBar: BottomNavBar(currentIndex: 0, onTap: _onNavTap),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditHabit(),
        backgroundColor: const Color(0xFF0E4932),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserHeader(
                    userName: userProvider.name,
                    userPoints: userProvider.points,
                    daysUsingApp: userProvider.daysUsingApp,
                  ),

                  const SizedBox(height: 16),
                  _buildCarbonSummary(context),
                  const SizedBox(height: 20),
                  const Text(
                    "Hábitos",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: habits.isEmpty
                        ? const Center(child: Text("Nenhum hábito registrado."))
                        : ListView.builder(
                            itemCount: habits.length,
                            itemBuilder: (context, index) {
                              final habit = habits[index];
                              return HabitCard(
                                title: habit['title'],
                                description: habit['description'],
                                value: (habit['value'] as num).toDouble(),
                                unit: habit['unit'],
                                onEdit: () => _addOrEditHabit(index: index),
                                onDelete: () => _deleteHabit(index),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildCarbonSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE0FEEA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF0E4932), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pegada de carbono: ${userCarbonFootprint.toStringAsFixed(1)} Kg CO₂",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          const Text(
            "A pegada de carbono representa a quantidade de dióxido de carbono (CO₂) que você gera com seus hábitos. "
            "Quanto menor ela for, menor o impacto ambiental.",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

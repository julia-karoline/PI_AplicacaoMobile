import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';
import '../components/user_header.dart';
import 'package:app_ecojourney/src/services/api_service.dart';
import 'package:app_ecojourney/src/services/auth_api_service.dart';
import '../components/habit_card.dart';

class InfoScreen extends StatefulWidget {

  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String userName = "Lucas";
  double userCarbonFootprint = 0.0;
  double reductionPercentage = 0.0;
  List<Map<String, dynamic>> habits = [];
  bool isLoading = true;

   double calcularPegadaCarbono(List<Map<String, dynamic>> habits) {
    double total = 0.0;

    for (var habit in habits) {
      final title = habit['title'].toString().toLowerCase();
      final value = habit['value'] ?? 0.0;

      if (title.contains('carne')) {
        total += value * 27.0;
      } else if (title.contains('gasolina')) {
        total += value * 2.31;
      } else if (title.contains('energia')) {
        total += value * 0.5;
      }
    }

    return total;
  }


  void _editHabit(int index) {
  final habit = habits[index];
  final titleController = TextEditingController(text: habit['title']);
  final descriptionController = TextEditingController(text: habit['description']);
  final valueController = TextEditingController(text: habit['value'].toString());
  final unitController = TextEditingController(text: habit['unit']);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Editar Hábito"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Título")),
            TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Descrição")),
            TextField(controller: valueController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Valor")),
            TextField(controller: unitController, decoration: const InputDecoration(labelText: "Unidade")),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0E4932),
        ), 
          onPressed: () async {
            final updatedTitle = titleController.text.trim();
            final updatedDesc = descriptionController.text.trim();
            final updatedUnit = unitController.text.trim();
            final updatedValue = double.tryParse(valueController.text.trim());

            if (updatedTitle.isEmpty || updatedDesc.isEmpty || updatedUnit.isEmpty || updatedValue == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Preencha todos os campos corretamente.")),
              );
              return;
            }

            try {
              await ApiService.updateHabit(
                id: habit['id'],
                title: updatedTitle,
                description: updatedDesc,
                value: updatedValue,
                unit: updatedUnit,
              );

              setState(() {
              habits[index] = {
                'id': habit['id'],
                'title': updatedTitle,
                'description': updatedDesc,
                'value': updatedValue,
                'unit': updatedUnit,
              };

              userCarbonFootprint = calcularPegadaCarbono(habits);
            });


              Navigator.pop(context);
            } catch (e) {
              print('Erro ao atualizar hábito: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Erro ao atualizar hábito")),
              );
            }
          },
          child: const Text("Salvar"),
        ),
      ],
    ),
  );
}



  void _confirmDeleteHabit(int index) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Excluir Hábito"),
      content: const Text("Tem certeza que deseja excluir este hábito?"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () async {
            try {
              final habitId = habits[index]['id'];
              await ApiService.deleteHabit(habitId);


              setState(() => habits.removeAt(index));
              userCarbonFootprint = calcularPegadaCarbono(habits);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Hábito excluído com sucesso")),
              );
            } catch (e) {
              print("Erro ao excluir hábito: $e");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Erro ao excluir hábito")),
              );
            }
          },
          child: const Text("Excluir"),
        ),
      ],
    ),
  );
}


  void _showAddHabitDialog() {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final valueController = TextEditingController();
  final unitController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Novo Hábito"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Descrição"),
            ),
            TextField(
              controller: valueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Valor"),
            ),
            TextField(
              controller: unitController,
              decoration: const InputDecoration(labelText: "Unidade"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0E4932),
        ),
          onPressed: () async {
            final title = titleController.text.trim();
            final desc = descriptionController.text.trim();
            final unit = unitController.text.trim();
            final value = double.tryParse(valueController.text.trim());

            if (title.isEmpty || desc.isEmpty || unit.isEmpty || value == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Preencha todos os campos corretamente.")),
              );
              return;
            }

            try {
              final novoHabito = await ApiService.createHabit(
                title: title,
                description: desc,
                value: value,
                unit: unit,
              );

              setState(() {
              habits.add(novoHabito);
              userCarbonFootprint = calcularPegadaCarbono(habits); 
            });


              Navigator.pop(context);
            } catch (e) {
              print("Erro ao criar hábito: $e");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Erro ao criar hábito.")),
              );
            }
          },
          child: const Text("Adicionar"),
        ),
      ],
    ),
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
      void initState() {
        super.initState();
        _carregarHabitos();
        _carregarUsuario();
      }

      void _carregarUsuario() async {
              final nome = await AuthApiService.getUserName();
              setState(() {
                userName = nome ?? 'Usuário';
              });
            }
        void _carregarHabitos() async {
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("")),
      bottomNavigationBar: BottomNavBar(currentIndex: 3, onTap: onNavTap),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            UserHeader(
              userName:userName,
              userPoints: userCarbonFootprint.toInt(),
              daysUsingApp: 0, 
            ),
            const SizedBox(height: 16),
            Text(
              "Pegada de carbono: ${userCarbonFootprint.toStringAsFixed(1)} Kg CO₂",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              "Redução de: ${reductionPercentage.toStringAsFixed(1)}%",
              style: const TextStyle(color: Colors.green, fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hábitos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return HabitCard(
                    title: habit['title'],
                    description: habit['description'],
                    value: habit['value'],
                    unit: habit['unit'],
                    onDelete: () => _confirmDeleteHabit(index),
                    onEdit: () => _editHabit(index), 
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHabitDialog,
        backgroundColor: const Color(0xFF0E4932),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

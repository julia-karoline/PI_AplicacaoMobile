import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';
import '../components/user_header.dart';
import '../components/habit_card.dart';

class InfoScreen extends StatefulWidget {

  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String userName = "Lucas";
  double userCarbonFootprint = 85.6;
  double reductionPercentage = 12.4;

  List<Map<String, dynamic>> habits = [
    {
      'title': 'Consumo de Carne',
      'description': 'Seu consumo mensal de carne',
      'value': 5.0,
      'unit': 'Kg',
    },
    {
      'title': 'Gasto com Gasolina',
      'description': 'Seu gasto semanal com gasolina',
      'value': 22.5,
      'unit': 'Litros',
    },
  ];

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
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
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

            setState(() {
              habits[index] = {
                'title': updatedTitle,
                'description': updatedDesc,
                'value': updatedValue,
                'unit': updatedUnit,
              };
            });

            Navigator.pop(context);
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
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() => habits.removeAt(index));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Hábito excluído com sucesso")),
              );
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
                decoration: const InputDecoration(labelText: "Unidade (ex: Kg, Litros)"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
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

              setState(() {
                habits.add({
                  'title': title,
                  'description': desc,
                  'value': value,
                  'unit': unit,
                });
              });

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(200, 50, 124, 96)),
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

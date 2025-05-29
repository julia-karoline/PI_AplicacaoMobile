import 'package:flutter/material.dart';
import 'package:app_ecojourney/src/components/daily_goal_card.dart';

class DailyGoalList extends StatelessWidget {
  final List<Map<String, dynamic>> goals;
  final void Function(int index) onCheck;
  final void Function(int index) onEdit;
  final void Function(int index) onDelete;

  const DailyGoalList({
    super.key,
    required this.goals,
    required this.onCheck,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (goals.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma meta cadastrada ainda.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      itemCount: goals.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final goal = goals[index];

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: DailyGoalCard(
            key: ValueKey(goal['id']),
            title: goal['title'],
            description: goal['description'],
            isCompleted: goal['completed'],
            onCheck: () => onCheck(index),
            onEdit: () => onEdit(index),
            onDelete: () => onDelete(index),
          ),
        );
      },
    );
  }
}

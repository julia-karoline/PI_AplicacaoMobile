import 'package:flutter/material.dart';

class HabitCard extends StatelessWidget {
  final String title;
  final String description;
  final double value;
  final String unit;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const HabitCard({
    super.key,
    required this.title,
    required this.description,
    required this.value,
    required this.unit,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(description,
                      style: const TextStyle(fontSize: 14, color: Colors.black54)),
                ],
              ),
            ),
            Text("$value $unit",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            if (onEdit != null || onDelete != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onEdit != null)
                    IconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: "Editar",
                      onPressed: onEdit,
                    ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      tooltip: "Excluir",
                      onPressed: onDelete,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

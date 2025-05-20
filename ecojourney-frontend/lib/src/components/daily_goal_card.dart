import 'package:flutter/material.dart';

class DailyGoalCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isCompleted;
  final VoidCallback onCheck;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete; 

  const DailyGoalCard({
  super.key,
  required this.title,
  required this.description,
  required this.isCompleted,
  required this.onCheck,
  this.onEdit,
  this.onDelete,
});


  @override
  Widget build(BuildContext context) {
    return Card(
      
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      color: Color(0xFFC5E5D9), 

      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            IconButton(
              icon: Icon(
                isCompleted ? Icons.check_box : Icons.radio_button_unchecked,
                color: isCompleted ? Colors.green : Colors.black,
              ),
              onPressed: onCheck,
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          if (onEdit != null || onDelete != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: "Editar meta",
                    onPressed: onEdit,
                  ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: "Excluir meta",
                    color: const Color.fromARGB(255, 145, 11, 2),
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

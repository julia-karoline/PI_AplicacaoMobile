import 'package:flutter/material.dart';

class DailyGoalFormDialog extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;

  const DailyGoalFormDialog({
    super.key,
    this.initialTitle,
    this.initialDescription,
  });

  @override
  State<DailyGoalFormDialog> createState() => _DailyGoalFormDialogState();
}

class _DailyGoalFormDialogState extends State<DailyGoalFormDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _descController = TextEditingController(text: widget.initialDescription ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();
    final description = _descController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos.")),
      );
      return;
    }

    Navigator.of(context).pop({
      'title': title,
      'description': description,
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialTitle == null ? 'Nova Meta' : 'Editar Meta'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              maxLines: 2,
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0E4932),
          ),
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}

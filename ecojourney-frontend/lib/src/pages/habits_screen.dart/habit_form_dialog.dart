import 'package:flutter/material.dart';

class HabitFormDialog extends StatefulWidget {
  final Map<String, dynamic>? initialHabit;
  final void Function(Map<String, dynamic> data) onSubmit;

  const HabitFormDialog({super.key, this.initialHabit, required this.onSubmit});

  @override
  State<HabitFormDialog> createState() => _HabitFormDialogState();
}

class _HabitFormDialogState extends State<HabitFormDialog> {
  late final TextEditingController _title;
  late final TextEditingController _desc;
  late final TextEditingController _value;
  late final TextEditingController _unit;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.initialHabit?['title'] ?? '');
    _desc = TextEditingController(text: widget.initialHabit?['description'] ?? '');
    _value = TextEditingController(text: widget.initialHabit?['value']?.toString() ?? '');
    _unit = TextEditingController(text: widget.initialHabit?['unit'] ?? '');
  }

  void _submit() {
    final title = _title.text.trim();
    final description = _desc.text.trim();
    final unit = _unit.text.trim();
    final value = double.tryParse(_value.text.trim());

    if (title.isEmpty || description.isEmpty || unit.isEmpty || value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos corretamente.')),
      );
      return;
    }

    widget.onSubmit({
      'title': title,
      'description': description,
      'unit': unit,
      'value': value,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialHabit == null ? 'Novo Hábito' : 'Editar Hábito'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: _title, decoration: const InputDecoration(labelText: 'Título')),
          TextField(controller: _desc, decoration: const InputDecoration(labelText: 'Descrição')),
          TextField(controller: _value, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Valor')),
          TextField(controller: _unit, decoration: const InputDecoration(labelText: 'Unidade')),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0E4932)),
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}

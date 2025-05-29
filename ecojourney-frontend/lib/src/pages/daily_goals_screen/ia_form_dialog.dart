import 'package:flutter/material.dart';

class IaFormDialog extends StatefulWidget {
  final Function(List<String> habits, double footprint) onConfirm;

  const IaFormDialog({super.key, required this.onConfirm});

  @override
  State<IaFormDialog> createState() => _IaFormDialogState();
}

class _IaFormDialogState extends State<IaFormDialog> {
  final TextEditingController _habitsController = TextEditingController();
  final TextEditingController _footprintController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _habitsController.dispose();
    _footprintController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final habits = _habitsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final footprint = double.parse(_footprintController.text.trim());

      widget.onConfirm(habits, footprint);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Obter sugestões da IA'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _habitsController,
              decoration: const InputDecoration(
                labelText: 'Hábitos (separados por vírgula)',
                hintText: 'Ex: carne, gasolina, energia elétrica',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe ao menos um hábito';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _footprintController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Pegada de carbono (kg CO₂)',
                hintText: 'Ex: 120.5',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe a pegada de carbono';
                }
                final parsed = double.tryParse(value.trim());
                if (parsed == null || parsed < 0) {
                  return 'Valor inválido';
                }
                return null;
              },
            ),
          ],
        ),
      ),
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
          child: const Text('Gerar sugestões'),
        ),
      ],
    );
  }
}

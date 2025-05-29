import 'package:flutter/material.dart';

Future<void> showIaSuggestionsDialog({
  required BuildContext context,
  required List<String> suggestions,
}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: const [
          Icon(Icons.bolt, color: Color(0xFF0E4932)),
          SizedBox(width: 8),
          Text(
            'Sugestões da IA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
      content: SizedBox(
        height: 200,
        width: double.maxFinite,
        child: ListView.separated(
          itemCount: suggestions.length,
          separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.check_circle_outline, color: Color(0xFF0E4932)),
              title: Text(
                suggestions[index],
                style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton.icon(
          icon: const Icon(Icons.check, color: Color(0xFF0E4932)),
          label: const Text(
            'OK',
            style: TextStyle(color: Color(0xFF0E4932)),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

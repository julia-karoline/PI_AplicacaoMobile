import 'package:flutter/material.dart';

Future<void> showIaSuggestionsDialog({
  required BuildContext context,
  required List<String> suggestions,
  required void Function(String selectedSuggestion) onSuggestionSelected,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: const [
          Icon(Icons.bolt, color: Color(0xFF0E4932)),
          SizedBox(width: 8),
          Text('Sugestões da IA'),
        ],
      ),
      content: SizedBox(
        height: 200,
        width: double.maxFinite,
        child: ListView.separated(
          itemCount: suggestions.length,
          separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return ListTile(
              leading: const Icon(Icons.tips_and_updates, color: Color(0xFF0E4932)),
              title: Text(suggestion),
              onTap: () {
                Navigator.pop(context);
                onSuggestionSelected(suggestion);
              },
            );
          },
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

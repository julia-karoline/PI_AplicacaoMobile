import 'package:flutter/material.dart';

Future<void> showRewardConfirmationDialog({
  required BuildContext context,
  required String title,
  required String discountCode,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Row(
        children: [
          const Icon(Icons.card_giftcard, color: Color(0xFF0E4932)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Cupom Resgatado!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Você resgatou o cupom "$title".'),
          const SizedBox(height: 12),
          const Text('Código promocional:'),
          const SizedBox(height: 8),
          SelectableText(
            discountCode,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Color(0xFF0E4932),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Use esse código no site parceiro para aplicar seu desconto.',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fechar'),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';

class RankingCard extends StatelessWidget {
  final int position;
  final String date;
  final int days;
  final int points;

  const RankingCard({
    super.key,
    required this.position,
    required this.date,
    required this.days,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTop3 = position <= 3;
    final Color color = isTop3
        ? (position == 1 ? Colors.amber : position == 2 ? Colors.grey : Colors.brown)
        : const Color(0xFF0E4932);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.emoji_events, color: color),
        title: Text(date),
        subtitle: Text('$days dias ativos'),
        trailing: Text(
          '$points pts',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

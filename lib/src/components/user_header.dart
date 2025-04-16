import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
  final String userName;
  final int userPoints;
  final int daysUsingApp;

  const UserHeader({
    super.key,
    required this.userName,
    required this.userPoints,
    required this.daysUsingApp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: const BoxDecoration(
        color: Color(0xFF0E4932), 
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
          ),
          const SizedBox(width: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá, $userName',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Pontos: $userPoints',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.90),
                  fontSize: 18,
                ),
              ),
              Text(
                '$daysUsingApp dias ajudando a salvar o mundo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

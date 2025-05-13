import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
  final String userName;
  final dynamic userPoints;
  final int daysUsingApp;
  final bool isCarbonInfo;
  final double? carbonReduction;

  const UserHeader({
    super.key,
    required this.userName,
    required this.userPoints,
    required this.daysUsingApp,
    this.isCarbonInfo = false,
    this.carbonReduction,
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
          Expanded(
            child: Column(
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
                  isCarbonInfo
                      ? 'Pegada de carbono: ${userPoints.toString()} tCO₂'
                      : 'Pontos: $userPoints',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.90),
                    fontSize: 18,
                  ),
                ),
                if (isCarbonInfo && carbonReduction != null)
                  Text(
                    'Redução de: ${carbonReduction!.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                if (!isCarbonInfo)
                  Text(
                    '$daysUsingApp dias ajudando a salvar o mundo',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

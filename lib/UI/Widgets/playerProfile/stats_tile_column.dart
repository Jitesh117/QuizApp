import 'package:flutter/material.dart';

class StatsTileColumn extends StatelessWidget {
  const StatsTileColumn({
    super.key,
    required this.icon,
    required this.description,
    required this.number,
  });
  final IconData icon;
  final String description;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
          color: Colors.white,
        ),
        Text(
          description,
          style: TextStyle(
            color: Colors.grey.shade400,
          ),
        ),
        Text(
          number,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class StatsTileColumn extends StatelessWidget {
  const StatsTileColumn({
    super.key,
    required this.icon,
    required this.description,
  });
  final IconData icon;
  final String description;

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
        const Text(
          '590',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

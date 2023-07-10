import 'package:flutter/material.dart';

import '../../Styles/text_styles.dart';

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
          textScaleFactor: ScaleSize.textScaleFactor(context),
          description,
          style: TextStyle(
            color: Colors.grey.shade400,
          ),
        ),
        Text(
          textScaleFactor: ScaleSize.textScaleFactor(context),
          number,
          style: whiteBold,
        ),
      ],
    );
  }
}

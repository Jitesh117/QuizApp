import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/question_provider.dart';

class StreakCounter extends StatelessWidget {
  const StreakCounter({
    super.key,
    required this.streakColor,
  });

  final Color streakColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuesProvider>(
      builder: (context, quesProvider, _) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.fireFlameCurved,
            color: quesProvider.streakCount > 0
                ? streakColor
                : Colors.white,
            size: 30,
          ),
          const SizedBox(width: 10),
          Text(
            quesProvider.streakCount.toString(),
            style: TextStyle(
              color:
                  quesProvider.streakCount > 0 ? streakColor : Colors.white,
              fontSize: 24,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/question_provider.dart';
import '../../Styles/text_styles.dart';

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
          const FaIcon(
            FontAwesomeIcons.fireFlameCurved,
            color: Colors.black,
            size: 30,
          ),
          const SizedBox(width: 10),
          Text(
            textScaleFactor: ScaleSize.textScaleFactor(context),
            quesProvider.streakCount.toString(),
            style: bigBold,
          )
        ],
      ),
    );
  }
}

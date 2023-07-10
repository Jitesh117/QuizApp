import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/player_provider.dart';
import '../../../providers/question_provider.dart';
import '../../Styles/text_styles.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.description,
    required this.icon,
    required this.boxColor,
  });

  final String description;
  final IconData icon;
  final Color boxColor;

  @override
  Widget build(BuildContext context) {
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black, width: 4),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(4, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: ListTile(
            onTap: () {
              playerProvider.playTapSound();
            },
            leading: FaIcon(icon),
            title: Text(
              textScaleFactor: ScaleSize.textScaleFactor(context),
              description,
              style: regularBold,
            ),
          ),
        ),
      ),
    );
  }
}

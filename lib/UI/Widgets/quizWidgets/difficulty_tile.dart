import 'package:flutter/material.dart';

import '../../Styles/text_styles.dart';

class DifficultyTile extends StatelessWidget {
  const DifficultyTile({
    super.key,
    required this.difficulty,
    required this.cardColor,
    required this.category,
  });

  final String difficulty;
  final Color cardColor;
  final int category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 32,
              height: 100,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                border: Border.all(
                  color: Colors.black,
                  width: 4,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      difficulty,
                      style: cardTextStyle,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

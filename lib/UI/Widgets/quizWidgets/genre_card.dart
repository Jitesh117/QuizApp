import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/UI/Quiz/choose_difficulty_page.dart';
import 'package:quiz_v2/providers/player_provider.dart';

import '../../../providers/question_provider.dart';
import '../../Styles/text_styles.dart';

class GenreCard extends StatelessWidget {
  const GenreCard({
    super.key,
    required this.topicName,
    required this.category,
    required this.streakColor,
    required this.bgColor,
  });

  final String topicName;
  final int category;
  final Color streakColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => GestureDetector(
        onTap: () {
          playerProvider.playTapSound();
          quesProvider.loadQuestions();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChooseDifficultyPage(
                category: category,
                streakColor: streakColor,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: width - 32,
            height: width - 32,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: bgColor,
              border: Border.all(
                color: Colors.black,
                width: 4,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(4, 4),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    topicName,
                    textAlign: TextAlign.center,
                    style: cardTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

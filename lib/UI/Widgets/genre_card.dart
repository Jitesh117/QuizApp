import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/UI/Quiz/choose_difficulty.dart';

import '../../providers/question_provider.dart';
import '../Styles/text_styles.dart';

class GenreCard extends StatelessWidget {
  const GenreCard({
    super.key,
    required this.width,
    required this.imagePath,
    required this.topicName,
    required this.colorOne,
    required this.colorTwo,
    required this.colorThree,
    required this.category,
    required this.streakColor,
  });

  final double width;
  final String imagePath;
  final String topicName;

  final Color colorOne;
  final Color colorTwo;
  final Color colorThree;
  final int category;
  final Color streakColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuesProvider>(
      builder: (context, quesProvider, _) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChooseDifficultyPage(
                colorOne: colorOne,
                colorTwo: colorTwo,
                colorThree: colorThree,
                imagePath: imagePath,
                category: category.toString(),
                streakColor: streakColor,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              child: Container(
                width: width - 32,
                height: 150,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    gradient: LinearGradient(
                      colors: [colorOne, colorTwo, colorThree],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    )),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        topicName,
                        style: cardTextStyle,
                      )
                    ]),
              ),
            ),
            Positioned(
              top: -20,
              right: 10,
              child: Image.asset(
                imagePath,
                height: 150,
                colorBlendMode: BlendMode.colorBurn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

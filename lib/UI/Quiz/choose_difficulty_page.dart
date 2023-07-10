import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:quiz_v2/UI/Quiz/quiz_page.dart';
import 'package:quiz_v2/providers/player_provider.dart';
import 'package:quiz_v2/providers/question_provider.dart';

import '../Styles/text_styles.dart';
import '../Widgets/quizWidgets/difficulty_tile.dart';

// ignore: must_be_immutable
class ChooseDifficultyPage extends StatelessWidget {
  ChooseDifficultyPage({
    super.key,
    required this.category,
    required this.streakColor,
  });

  final int category;
  final Color streakColor;

  List<String> difficulty = ['EASY', 'MEDIUM', 'HARD'];
  List<int> difficultyNumber = [0, 1, 2];
  List<Color> diffColor = [
    Colors.green,
    Colors.orange,
    Colors.red,
  ];
  @override
  Widget build(BuildContext context) {
    log('build');
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              // background animation
              // SizedBox(
              //   height: MediaQuery.of(context).size.height,
              //   child: Lottie.asset(
              //     'assets/lottieAnimations/patternBack.zip',
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            playerProvider.playTapSound();
                            Navigator.of(context).pop();
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.circleXmark,
                            size: 40,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        textScaleFactor: ScaleSize.textScaleFactor(context),
                        'Choose your difficulty',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: difficulty.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            playerProvider.playTapSound();
                            playerProvider.fetchPlayerData();
                            quesProvider.questionNumberChanger(-1,
                                -1); // question number change only when it is changed inside the quiz page and not from the change difficulty page
                            quesProvider.fetchQuestion(
                                category, difficultyNumber[index]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizPage(
                                  category: category,
                                  streakColor: streakColor,
                                  difficulty: difficultyNumber[index],
                                ),
                              ),
                            );
                          },
                          child: DifficultyTile(
                            difficulty: difficulty[index],
                            cardColor: difficultyColorThree[index],
                            category: category,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

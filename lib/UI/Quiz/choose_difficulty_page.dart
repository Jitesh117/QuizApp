import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:quiz_v2/UI/Quiz/quiz_page.dart';
import 'package:quiz_v2/providers/question_provider.dart';

import '../Widgets/quizWidgets/difficulty_tile.dart';

// ignore: must_be_immutable
class ChooseDifficultyPage extends StatelessWidget {
  ChooseDifficultyPage({
    super.key,
    required this.imagePath,
    required this.category,
    required this.streakColor,
  });

  final String imagePath;
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
    return Consumer<QuesProvider>(
      builder: (context, quesProvider, _) => Scaffold(
        backgroundColor: Colors.yellow.shade100,
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Lottie.asset(
                  'assets/lottieAnimations/patternBack.zip',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: const BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [
                    //     colorOne,
                    //     colorTwo,
                    //     colorThree,
                    //   ],
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    // ),
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
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
                    const Center(
                      child: Text(
                        'Choose your difficulty',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: difficulty.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            quesProvider.questionNumberChanger(-1,
                                -1); // question number change only when it is changed inside the quiz page and not from the change difficulty page
                            quesProvider.fetchQuestion(
                                category, difficultyNumber[index]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizPage(
                                  imagePath: imagePath,
                                  category: category,
                                  streakColor: streakColor,
                                  difficulty: difficultyNumber[index],
                                ),
                              ),
                            );
                          },
                          child: DifficultyTile(
                            difficulty: difficulty[index],
                            colorOne: difficultyColorOne[index],
                            colorTwo: difficultyColorTwo[index],
                            colorThree: difficultyColorThree[index],
                            imagePath: imagePath,
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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/UI/Quiz/quiz_page.dart';
import 'package:quiz_v2/providers/question_provider.dart';

// ignore: must_be_immutable
class ChooseDifficultyPage extends StatelessWidget {
  ChooseDifficultyPage({
    super.key,
    required this.colorOne,
    required this.colorTwo,
    required this.colorThree,
    required this.imagePath,
    required this.category,
    required this.streakColor,
  });

  final Color colorOne;
  final Color colorTwo;
  final Color colorThree;
  final String imagePath;
  final String category;
  final Color streakColor;

  List<String> difficulty = ['EASY', 'MEDIUM', 'HARD'];
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
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorOne,
                  colorTwo,
                  colorThree,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
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
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    imagePath,
                    height: 250,
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: difficulty.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        quesProvider.fetchQuestion(
                            category, difficulty[index].toLowerCase());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizPage(
                              colorOne: colorOne,
                              colorTwo: colorTwo,
                              colorThree: colorThree,
                              imagePath: imagePath,
                              category: category.toString(),
                              streakColor: streakColor,
                              difficulty: difficulty[index].toLowerCase(),
                            ),
                          ),
                        );
                      },
                      child: DifficultyTile(
                          difficulty: difficulty[index],
                          diffColor: diffColor[index]),
                    ),
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

class DifficultyTile extends StatelessWidget {
  const DifficultyTile({
    super.key,
    required this.difficulty,
    required this.diffColor,
  });

  final String difficulty;
  final Color diffColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          // gradient: LinearGradient(
          //   colors: [
          //     diffColor,
          //     Colors.white,
          //   ],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          border: Border.all(
            color: Colors.white,
            strokeAlign: 2,
            width: 2,
          ),
        ),
        child: Text(
          difficulty,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: diffColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

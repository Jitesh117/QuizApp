import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/providers/question_provider.dart';

import '../Styles/text_styles.dart';
import '../Widgets/option_tile.dart';
import '../Widgets/shimmer_tile.dart';
import '../Widgets/streak_counter.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({
    super.key,
    required this.colorOne,
    required this.colorTwo,
    required this.colorThree,
    required this.imagePath,
    required this.category,
    required this.streakColor,
    required this.difficulty,
  });

  final Color colorOne;
  final Color colorTwo;
  final Color colorThree;
  final String imagePath;
  final String category;
  final Color streakColor;
  final String difficulty;
  @override
  Widget build(BuildContext context) {
    log('build');
    return Consumer<QuesProvider>(
      builder: (context, quesProvider, _) => Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                        // streakcounter
                        StreakCounter(
                          streakColor: streakColor,
                        ),
                        // TODO: implement countdownTimer
                        // CircularCountDownTimer(
                        //   width: 40,
                        //   height: 40,
                        //   duration: 60,
                        //   autoStart: false,
                        //   ringColor: colorThree,
                        //   controller: quesProvider.timeController,
                        //   isReverseAnimation: true,
                        //   fillColor: Colors.white,
                        //   isReverse: true,
                        //   textFormat: CountdownTextFormat.S,
                        //   textStyle: const TextStyle(
                        //     fontSize: 16,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () =>
                          quesProvider.fetchQuestion(category, difficulty),
                      child: Center(
                        child: Image.asset(
                          imagePath,
                          height: 150,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Question 1 of 10',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 20,
                      ),
                    ),
                    quesProvider.isLoading == true
                        ? const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerTile(height: 20, width: 350),
                              SizedBox(height: 10),
                              ShimmerTile(height: 20, width: 350),
                              SizedBox(height: 10),
                              ShimmerTile(height: 20, width: 300),
                            ],
                          )
                        : Text(
                            // 'In which city of Germany is the largest port?',
                            quesProvider.question,
                            style: cardTextStyle,
                          ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return OptionTile(
                              optionValue: quesProvider.rightPosition == index
                                  ? quesProvider.correctAnswer
                                  : quesProvider.incorrectAnswer[index],
                              optionColor: colorOne,
                              optionNumber: index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20,
                bottom: 40,
                child: GestureDetector(
                  onTap: () {
                    quesProvider.fetchQuestion(category, difficulty);
                  },
                  child: const Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

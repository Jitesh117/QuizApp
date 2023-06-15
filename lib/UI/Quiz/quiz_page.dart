import 'dart:math';
import 'dart:developer' as dev;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/providers/player_provider.dart';
import 'package:quiz_v2/providers/question_provider.dart';

import '../Styles/text_styles.dart';
import '../Widgets/quizWidgets/option_tile.dart';
import '../Widgets/quizWidgets/streak_counter.dart';

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
  final Color streakColor;
  final int category;
  final int difficulty;

  @override
  Widget build(BuildContext context) {
    dev.log('build');
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => Scaffold(
        body: WillPopScope(
          onWillPop: () {
            return quesProvider.popOrNot(context);
          },
          child: SafeArea(
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Lottie.asset(
                    'assets/lottieAnimations/nightAnimation.zip',
                    fit: BoxFit.fill,
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
                            onTap: () async {
                              bool shouldPop =
                                  await quesProvider.popOrNot(context);
                              if (shouldPop) {
                                Navigator.pop(context);
                              }
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
                          // SizedBox(
                          //   height: 50,
                          //   width: 50,
                          //   child: PlayerAvatar(
                          //       imagePath: playerProvider.avatarPath),
                          // ),

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
                      Center(
                        child: Image.asset(
                          imagePath,
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Question ${quesProvider.questionNumber.toString()}',
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 20,
                        ),
                      ),
                      Text(
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
                              optionNumber: index,
                              category: category,
                              difficulty: difficulty,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Visibility(
                //   visible: quesProvider.tapped,
                //   child: Positioned(
                //     right: 20,
                //     bottom: 40,
                //     child: GestureDetector(
                //       onTap: () {
                //         quesProvider.fetchQuestion(category, difficulty);
                //       },
                //       child: const Icon(
                //         Icons.arrow_circle_right_outlined,
                //         color: Colors.white,
                //         size: 70,
                //       ),
                //     ),
                //   ),
                // ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: quesProvider.confettiController,
                    blastDirection: pi / 2,
                    maxBlastForce: 20,
                    minBlastForce: 5,
                    emissionFrequency: 0.1,
                    gravity: 1,
                    // 10 paticles will pop-up at a time
                    numberOfParticles: 10,
                    shouldLoop: false,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: ConfettiWidget(
                    confettiController: quesProvider.confettiController,
                    blastDirection: 0,
                    maxBlastForce: 20,
                    minBlastForce: 5,
                    emissionFrequency: 0.1,
                    gravity: 1,
                    // 10 paticles will pop-up at a time
                    numberOfParticles: 10,
                    shouldLoop: false,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ConfettiWidget(
                    confettiController: quesProvider.confettiController,
                    blastDirection: pi,
                    maxBlastForce: 20,
                    minBlastForce: 5,
                    emissionFrequency: 0.1,
                    gravity: 1,
                    // 10 paticles will pop-up at a time
                    numberOfParticles: 10,
                    shouldLoop: false,
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

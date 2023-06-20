import 'dart:math';
import 'dart:developer' as dev;

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:quiz_v2/providers/player_provider.dart';
import 'package:quiz_v2/providers/question_provider.dart';

import '../Styles/text_styles.dart';
import '../Widgets/quizWidgets/option_tile.dart';
import '../Widgets/quizWidgets/streak_counter.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({
    super.key,
    required this.imagePath,
    required this.category,
    required this.streakColor,
    required this.difficulty,
  });

  final String imagePath;
  final Color streakColor;
  final int category;
  final int difficulty;

  @override
  Widget build(BuildContext context) {
    CountDownController timeController = CountDownController();
    dev.log('build');
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => Scaffold(
        backgroundColor: Colors.yellow.shade100,
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
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.black,
                                width: 4,
                              ),
                            ),
                            child: const Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.circleInfo,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Stats',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Center(
                      //   child: Image.asset(
                      //     imagePath,
                      //     height: 150,
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black, width: 4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.circleQuestion,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  quesProvider.questionNumber.toString(),
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            StreakCounter(
                              streakColor: streakColor,
                            ),
                            CircularCountDownTimer(
                              width: 40,
                              height: 40,
                              duration: 30,
                              autoStart: true,
                              fillColor: Colors.black,
                              ringColor: Colors.yellow.shade100,
                              controller: timeController,
                              isReverseAnimation: true,
                              isReverse: true,
                              textFormat: CountdownTextFormat.S,
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              onComplete: () async {
                                quesProvider.streakCount = 0;
                                await quesProvider.showDialogue(context,
                                    'assets/lottieAnimations/timeUp.zip');

                                playerProvider
                                    .updateMaxStreak(quesProvider.streakCount);
                                playerProvider.updatePoints(
                                    quesProvider.tappedOptionIsCorrect);
                                quesProvider.streakChanger();
                                // quesProvider.checkTappedOption(-1);
                                quesProvider.showCorrectOption = true;
                                await Future.delayed(
                                  const Duration(seconds: 1),
                                  () {
                                    quesProvider.fetchQuestion(
                                        category, difficulty);
                                    timeController.restart();
                                    quesProvider.showCorrectOption = false;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.black,
                            width: 4,
                          ),
                        ),
                        child: Text(
                          // 'In which city of Germany is the largest port?',
                          quesProvider.question,
                          textAlign: TextAlign.center,
                          style: cardTextStyle,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        flex: 2,
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                if (!quesProvider.tapped) {
                                  timeController.pause();
                                  quesProvider.checkTappedOption(index);
                                  playerProvider.updateMaxStreak(
                                      quesProvider.streakCount);
                                  playerProvider.updatePoints(
                                      quesProvider.tappedOptionIsCorrect);
                                  // correct answer tapped
                                  if (quesProvider.tappedOptionIsCorrect) {
                                    // player.play();
                                    await quesProvider.showDialogue(context,
                                        'assets/lottieAnimations/right.zip');
                                  }
                                  // wrong answer tapped
                                  else {
                                    await quesProvider.showDialogue(context,
                                        'assets/lottieAnimations/wrong.zip');
                                  }
                                  await Future.delayed(
                                    const Duration(seconds: 1),
                                    () {
                                      quesProvider.fetchQuestion(
                                          category, difficulty);
                                      timeController.restart();
                                    },
                                  );
                                }
                              },
                              child: OptionTile(
                                optionValue: quesProvider.rightPosition == index
                                    ? quesProvider.correctAnswer
                                    : quesProvider.incorrectAnswer[index],
                                optionColor: optionColor[index],
                                optionNumber: index,
                                category: category,
                                difficulty: difficulty,
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.black,
                            width: 4,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/powerups/one.png',
                              height: 50,
                            ),
                            Image.asset(
                              'assets/powerups/two.png',
                              height: 50,
                            ),
                            Image.asset(
                              'assets/powerups/three.png',
                              height: 55,
                            ),
                            Image.asset(
                              'assets/powerups/four.png',
                              height: 50,
                            ),
                          ],
                        ),
                      )
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

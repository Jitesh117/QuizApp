import 'dart:math';
import 'dart:developer' as dev;

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
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
    final advancedDrawerController = AdvancedDrawerController();
    CountDownController timeController = CountDownController();
    dev.log('build');
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.amber,
        ),
        controller: advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        // openScale: 1.0,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              child: Center(
                child: ListTileTheme(
                  textColor: Colors.black,
                  iconColor: Colors.black,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 128.0,
                        height: 128.0,
                        margin: const EdgeInsets.only(
                          top: 24.0,
                          bottom: 64.0,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent.shade100,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 4),
                        ),
                        child: Image.asset(
                          'assets/userAvatars/memojis/user_profile_4.png',
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black, width: 4),
                        ),
                        child: ListTile(
                          onTap: () {},
                          leading: const FaIcon(FontAwesomeIcons.check),
                          title: Text(
                            'Correct Answers: ${quesProvider.numberOfCorrectAnswers}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black, width: 4),
                        ),
                        child: ListTile(
                          onTap: () {},
                          leading: const FaIcon(FontAwesomeIcons.x),
                          title: Text(
                            'Incorrect Answers: ${quesProvider.numberOfInorrectAnswers}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        child: Scaffold(
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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 4),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
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
                              const SizedBox(width: 2),
                              Row(
                                children: [
                                  const FaIcon(FontAwesomeIcons.coins),
                                  const SizedBox(width: 10),
                                  Text(
                                    playerProvider.points.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  advancedDrawerController.showDrawer();
                                },
                                child: Container(
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
                                ),
                              )
                            ],
                          ),
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
                                  quesProvider.numberOfInorrectAnswers++;
                                  playerProvider.updatePoints(false);
                                  await quesProvider.showDialogue(context,
                                      'assets/lottieAnimations/timeUp.zip');

                                  playerProvider.updateMaxStreak(
                                      quesProvider.streakCount);
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
                                  optionValue:
                                      quesProvider.rightPosition == index
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
                              GestureDetector(
                                onTap: () => quesProvider.deleteWrongOption(),
                                child: Image.asset(
                                  'assets/powerups/one.png',
                                  height: 50,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => quesProvider.revealCorrectOption(),
                                child: Image.asset(
                                  'assets/powerups/two.png',
                                  height: 50,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => quesProvider.doublePoints(),
                                child: Image.asset(
                                  'assets/powerups/three.png',
                                  height: 55,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  quesProvider.fetchQuestion(
                                      category, difficulty);
                                },
                                child: Image.asset(
                                  'assets/powerups/four.png',
                                  height: 55,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
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
      ),
    );
  }
}

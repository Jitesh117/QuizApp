import 'dart:math';
import 'dart:developer' as dev;

import 'package:audioplayers/audioplayers.dart';
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
    required this.category,
    required this.streakColor,
    required this.difficulty,
  });

  final Color streakColor;
  final int category;
  final int difficulty;

  @override
  Widget build(BuildContext context) {
    final advancedDrawerController = AdvancedDrawerController();
    final timeController = CountDownController();
    dev.log('build');
    final player = AudioPlayer();
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
                          onTap: () {
                            quesProvider.playTapSound();
                          },
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
                          onTap: () {
                            quesProvider.playTapSound();
                          },
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
                  // background animation
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Lottie.asset(
                      'assets/lottieAnimations/patternBack.zip',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 08, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  quesProvider.playTapSound();
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
                                  quesProvider.playTapSound();
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
                                  player.play(
                                    AssetSource('sounds/alarm.mp3'),
                                  );
                                  await quesProvider.showDialogue(context,
                                      'assets/lottieAnimations/timeUp.zip');

                                  playerProvider.updateMaxStreak(
                                      quesProvider.streakCount);
                                  quesProvider.streakChanger();
                                  quesProvider.showCorrectOption = true;
                                  player.stop();
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
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                quesProvider.playTapSound();
                                if (playerProvider.powerDelete > 0 &&
                                    !quesProvider.deleteWrongOptionTapped) {
                                  playerProvider.powerDelete--;
                                  playerProvider.updatePowerups();
                                  quesProvider.deleteWrongOption();
                                }
                              },
                              child: PowerUp(
                                imagePath: 'assets/powerups/one.png',
                                availability:
                                    playerProvider.powerDelete.toString(),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                quesProvider.playTapSound();
                                if (playerProvider.powerReveal > 0 &&
                                    !quesProvider.revealRightOptionTapped) {
                                  playerProvider.powerReveal--;
                                  playerProvider.updatePowerups();
                                  quesProvider.revealCorrectOption();
                                }
                              },
                              child: PowerUp(
                                imagePath: 'assets/powerups/two.png',
                                availability:
                                    playerProvider.powerReveal.toString(),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                quesProvider.playTapSound();
                                if (playerProvider.powerDouble > 0 &&
                                    !quesProvider.doublePointsTapped) {
                                  playerProvider.powerDouble--;
                                  playerProvider.updatePowerups();
                                  playerProvider.shouldDoublePoints = true;
                                  quesProvider.doublePointsTapped = true;
                                }
                              },
                              child: PowerUp(
                                imagePath: 'assets/powerups/three.png',
                                availability:
                                    playerProvider.powerDouble.toString(),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                quesProvider.playTapSound();
                                if (playerProvider.powerSkip > 0) {
                                  playerProvider.powerSkip--;
                                  playerProvider.updatePowerups();
                                  quesProvider.fetchQuestion(
                                      category, difficulty);
                                }
                              },
                              child: PowerUp(
                                imagePath: 'assets/powerups/four.png',
                                availability:
                                    playerProvider.powerSkip.toString(),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
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
                            quesProvider.question,
                            textAlign: TextAlign.center,
                            style: cardTextStyle,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          flex: 2,
                          child: ListView.builder(
                            itemCount: 3, // 3 is the number of options
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () async {
                                  quesProvider.playTapSound();
                                  if (!quesProvider.tapped) {
                                    timeController.pause();
                                    quesProvider.currentTime =
                                        timeController.getTime();
                                    quesProvider.checkTappedOption(index);
                                    playerProvider.updateMaxStreak(
                                        quesProvider.streakCount);
                                    playerProvider.updatePoints(
                                        quesProvider.tappedOptionIsCorrect);
                                    // correct answer tapped
                                    if (quesProvider.tappedOptionIsCorrect) {
                                      player.play(
                                        AssetSource('sounds/rightSound.wav'),
                                      );
                                      await quesProvider.showDialogue(context,
                                          'assets/lottieAnimations/right.zip');
                                    }
                                    // wrong answer tapped
                                    else {
                                      player.play(
                                        AssetSource('sounds/wrongSound.wav'),
                                      );
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
                                    playerProvider.shouldDoublePoints = false;
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
                      numberOfParticles: 7,
                      shouldLoop: false,
                      colors: const [
                        Colors.white,
                        Colors.red,
                        Colors.green,
                        Colors.blue,
                      ],
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
                      numberOfParticles: 7,
                      shouldLoop: false,
                      colors: const [
                        Colors.white,
                        Colors.red,
                        Colors.green,
                        Colors.blue,
                      ],
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
                      numberOfParticles: 7,
                      shouldLoop: false,
                      colors: const [
                        Colors.white,
                        Colors.red,
                        Colors.green,
                        Colors.blue,
                      ],
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

class PowerUp extends StatelessWidget {
  const PowerUp({
    super.key,
    required this.imagePath,
    required this.availability,
  });

  final String imagePath;
  final String availability;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imagePath,
          height: 55,
        ),
        Positioned(
          right: 0,
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                availability,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

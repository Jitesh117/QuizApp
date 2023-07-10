import 'dart:developer' as dev;

import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:quiz_v2/providers/player_provider.dart';
import 'package:quiz_v2/providers/question_provider.dart';

import '../Styles/text_styles.dart';
import '../Widgets/playerProfile/drawer_item.dart';
import '../Widgets/quizWidgets/powerup.dart';
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
    player.setVolume(0.1);
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.pinkAccent,
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
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const SizedBox(height: 50),
                      DrawerItem(
                        boxColor: Colors.greenAccent,
                        icon: FontAwesomeIcons.check,
                        description:
                            'Correct Answers: ${quesProvider.numberOfCorrectAnswers}',
                      ),
                      DrawerItem(
                        description:
                            'Incorrect Answers: ${quesProvider.numberOfInorrectAnswers}',
                        icon: FontAwesomeIcons.x,
                        boxColor: Colors.redAccent,
                      ),
                      DrawerItem(
                        description:
                            'PowerUps Used: ${quesProvider.numberOfPowerupsUsed}',
                        icon: FontAwesomeIcons.boltLightning,
                        boxColor: Colors.blueAccent,
                      ),
                      DrawerItem(
                        description: 'Max Streak: ${playerProvider.maxStreak}',
                        icon: FontAwesomeIcons.fireFlameCurved,
                        boxColor: Colors.deepOrange,
                      ),
                      // const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: WillPopScope(
            onWillPop: () {
              return quesProvider.popOrNot(context);
            },
            child: SafeArea(
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
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(4, 4),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  playerProvider.playTapSound();
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
                                    textScaleFactor:
                                        ScaleSize.textScaleFactor(context),
                                    playerProvider.points.toString(),
                                    style: midBold,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  playerProvider.playTapSound();
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
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(2, 2),
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.circleInfo,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        textScaleFactor:
                                            ScaleSize.textScaleFactor(context),
                                        'Stats',
                                        style: regularBold,
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
                            color: Colors.deepPurple.shade300,
                            borderRadius: BorderRadius.circular(16),
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
                                    textScaleFactor:
                                        ScaleSize.textScaleFactor(context),
                                    quesProvider.questionNumber.toString(),
                                    style: midBold,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  // for (int i = 0; i < badgeName.length; i++) {
                                  //   playerProvider.showSnackBar(context, i);
                                  // }
                                  // quesProvider.confettiPlay();
                                },
                                child: StreakCounter(
                                  streakColor: streakColor,
                                ),
                              ),
                              CircularCountDownTimer(
                                width: 40,
                                height: 40,
                                duration: 30,
                                autoStart: true,
                                fillColor: Colors.black,
                                ringColor: Colors.transparent,
                                controller: timeController,
                                isReverseAnimation: true,
                                isReverse: true,
                                textFormat: CountdownTextFormat.S,
                                textStyle: midBold,
                                onComplete: () async {
                                  quesProvider.streakCount = 0;
                                  quesProvider.numberOfInorrectAnswers++;
                                  playerProvider.updatePoints(false);
                                  player.play(
                                    AssetSource('sounds/alarm.mp3'),
                                  );
                                  await quesProvider.showDialogue(context,
                                      'assets/lottieAnimations/timeUp.zip');

                                  quesProvider.streakChanger();
                                  playerProvider.updateMaxStreak(
                                      quesProvider.streakCount);
                                  quesProvider.showCorrectOption = true;
                                  player.stop();
                                  await Future.delayed(
                                    const Duration(seconds: 1),
                                    () {
                                      playerProvider.updatePowerups();
                                      quesProvider.fetchQuestion(
                                          category, difficulty);
                                      timeController.restart();
                                      quesProvider.showCorrectOption = false;
                                      playerProvider.resetPowerups();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                playerProvider.playTapSound();
                                if (playerProvider.powerDelete > 0 &&
                                    !quesProvider.deleteWrongOptionTapped) {
                                  playerProvider.deleteUsed = true;
                                  playerProvider.powerDelete--;
                                  quesProvider.numberOfPowerupsUsed++;
                                  quesProvider.deleteWrongOption();
                                  playerProvider.updatePowerups();
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
                                playerProvider.playTapSound();
                                if (playerProvider.powerReveal > 0 &&
                                    !quesProvider.revealRightOptionTapped &&
                                    quesProvider.questionsLoaded) {
                                  playerProvider.revealUsed = true;
                                  playerProvider.powerReveal--;
                                  quesProvider.numberOfPowerupsUsed++;
                                  quesProvider.revealCorrectOption();
                                  playerProvider.updatePowerups();
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
                                playerProvider.playTapSound();
                                if (playerProvider.powerDouble > 0 &&
                                    !quesProvider.doublePointsTapped) {
                                  playerProvider.powerDouble--;
                                  quesProvider.numberOfPowerupsUsed++;
                                  quesProvider.doublePointsTapped = true;
                                  playerProvider.doubleUsed = true;
                                  playerProvider.updatePowerups();
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
                                playerProvider.playTapSound();
                                if (playerProvider.powerSkip > 0) {
                                  playerProvider.skipUsed = true;
                                  playerProvider.powerSkip--;
                                  quesProvider.numberOfPowerupsUsed++;
                                  playerProvider.callAllBadgeFunctions(
                                      category,
                                      difficulty,
                                      quesProvider.tappedOptionIsCorrect,
                                      context);
                                  playerProvider.updatePowerups();
                                  quesProvider.fetchQuestion(
                                      category, difficulty);
                                  timeController.restart();
                                  playerProvider.resetPowerups();
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
                            color: Colors.cyanAccent,
                            borderRadius: BorderRadius.circular(16),
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
                          child: Text(
                            textScaleFactor: ScaleSize.textScaleFactor(context),
                            quesProvider.question,
                            textAlign: TextAlign.center,
                            style: bigBold,
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
                                  playerProvider.playTapSound();
                                  if (!quesProvider.tapped) {
                                    timeController.pause();
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
                                    String curTime =
                                        timeController.getTime() ?? '30';
                                    playerProvider.timeTaken =
                                        30 - int.parse(curTime);
                                    if (quesProvider.tappedOptionIsCorrect) {
                                      playerProvider.totalTimeTaken +=
                                          playerProvider.timeTaken;
                                    } else {
                                      playerProvider.totalTimeTaken = 0;
                                    }
                                    playerProvider.callAllBadgeFunctions(
                                        category,
                                        difficulty,
                                        quesProvider.tappedOptionIsCorrect,
                                        context);
                                    await Future.delayed(
                                      const Duration(seconds: 1),
                                      () {
                                        playerProvider.updatePowerups();
                                        quesProvider.fetchQuestion(
                                            category, difficulty);
                                        playerProvider.resetPowerups();
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
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: ConfettiWidget(
                      confettiController: quesProvider.confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      maxBlastForce: 50,
                      minBlastForce: 5,
                      emissionFrequency: 0.5,
                      numberOfParticles: 40,
                      gravity: 0.3,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: ConfettiWidget(
                      confettiController: quesProvider.confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      maxBlastForce: 50,
                      minBlastForce: 5,
                      emissionFrequency: 0.5,
                      numberOfParticles: 40,
                      gravity: 0.3,
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

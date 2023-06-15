import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/providers/player_provider.dart';
import '../../../providers/question_provider.dart';

class OptionTile extends StatefulWidget {
  const OptionTile({
    super.key,
    required this.optionValue,
    required this.optionColor,
    required this.optionNumber,
    required this.category,
    required this.difficulty,
  });

  final String optionValue;
  final Color optionColor;
  final int optionNumber;
  final int category;
  final int difficulty;

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  // AudioPlayer player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => GestureDetector(
        onTap: () async {
          // player.setAsset('assets/sounds/rightSound.wav');
          if (!quesProvider.tapped) {
            quesProvider.checkTappedOption(widget.optionNumber);
            playerProvider.updateMaxStreak(quesProvider.streakCount);
            playerProvider.updatePoints(quesProvider.tappedOptionIsCorrect);
            // correct answer tapped
            if (quesProvider.tappedOptionIsCorrect) {
              // player.play();
              showDialog(
                context: context,
                builder: (context) => SizedBox(
                  height: 150,
                  width: 150,
                  child: Lottie.asset(
                    'assets/lottieAnimations/right.zip',
                  ),
                ),
              );
              // player.stop();
              await Future.delayed(
                const Duration(seconds: 2),
                () {
                  Navigator.pop(context);
                },
              );
            }
            // wrong answer tapped
            else {
              showDialog(
                context: context,
                builder: (context) => SizedBox(
                  height: 150,
                  width: 150,
                  child: Lottie.asset(
                    'assets/lottieAnimations/wrongAnswerAnimation.zip',
                  ),
                ),
              );
              await Future.delayed(
                const Duration(seconds: 2),
                () {
                  Navigator.pop(context);
                },
              );
            }
            await Future.delayed(
              const Duration(seconds: 1),
              () {
                quesProvider.fetchQuestion(widget.category, widget.difficulty);
              },
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: quesProvider.tapped &&
                        quesProvider.rightPosition == widget.optionNumber
                    ? [
                        Colors.yellowAccent.shade700,
                        Colors.green,
                      ]
                    : [
                        Colors.white,
                        Colors.white,
                      ],
              ),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 260,
                  child: Text(
                    widget.optionValue,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: quesProvider.tapped &&
                              quesProvider.rightPosition == widget.optionNumber
                          ? Colors.white
                          : widget.optionColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                quesProvider.tapped == true &&
                        quesProvider.rightPosition == widget.optionNumber
                    ? const Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : quesProvider.correctAnswer != "Option" &&
                            quesProvider.tappedOption[widget.optionNumber] == 1
                        ? Icon(
                            quesProvider.rightPosition == widget.optionNumber
                                ? Icons.check
                                : Icons.close,
                            color: quesProvider.rightPosition ==
                                    widget.optionNumber
                                ? Colors.green
                                : Colors.red,
                          )
                        : const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

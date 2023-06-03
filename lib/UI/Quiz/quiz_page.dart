import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_v2/UI/Styles/text_styles.dart';
import 'package:quiz_v2/UI/Widgets/right_option_tile.dart';
import 'package:quiz_v2/UI/Widgets/wrong_option.dart';

import '../../Data/json_convert.dart';
import '../Widgets/option_tile.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({
    super.key,
    required this.colorOne,
    required this.colorTwo,
    required this.colorThree,
    required this.imagePath,
  });
  final Color colorOne;
  final Color colorTwo;
  final Color colorThree;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.fire,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  CircularCountDownTimer(
                    width: 40,
                    height: 40,
                    duration: 30,
                    ringColor: Colors.blue.shade200,
                    fillColor: Colors.white,
                    isReverse: true,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => printdata(),
                child: Center(
                  child: Image.asset(
                    imagePath,
                    height: 250,
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
              Text(
                'In which city of Germany is the largest port?',
                style: cardTextStyle,
              ),
              const SizedBox(height: 20),
              const OptionTile(optionValue: 'Bremen'),
              const RightOptionTile(optionValue: 'Hamburg'),
              const WrongOptionTile(optionValue: 'Norden'),
            ],
          ),
        ),
      ),
    );
  }
}

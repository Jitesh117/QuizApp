import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_v2/UI/Styles/textStyles.dart';
import 'package:quiz_v2/UI/Widgets/right_option_tile.dart';
import 'package:quiz_v2/UI/Widgets/wront_option.dart';

import '../Widgets/option_tile.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.blueAccent,
                Colors.lightBlue,
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
                  const FaIcon(
                    FontAwesomeIcons.circleXmark,
                    size: 40,
                    color: Colors.white,
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
              Center(
                child: Image.asset(
                  'assets/art.png',
                  height: 250,
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

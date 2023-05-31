import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_v2/UI/Styles/textStyles.dart';

class ContinuePage extends StatelessWidget {
  const ContinuePage({super.key});

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
              const FaIcon(
                FontAwesomeIcons.circleXmark,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Center(
                child: Image.asset(
                  'assets/art.png',
                  height: 300,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'level 2',
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 20,
                ),
              ),
              Text(
                'Continuing',
                style: cardTextStyle,
              ),
              const SizedBox(height: 20),
              Text(
                "Do you feel confident? Here you'll challenge one of our most difficult travel questions!",
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: const Text(
                  "Game",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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

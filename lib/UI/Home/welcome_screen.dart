import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_v2/UI/Home/home.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Lottie.asset(
                'assets/lottieAnimations/dayAnimation.zip',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 32,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 300,
                    width: 350,
                    child: Lottie.asset(
                      'assets/lottieAnimations/quizit.zip',
                      fit: BoxFit.fill,
                      repeat: false,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const HomePage(),
                          ),
                        );
                      },
                      child:
                          Lottie.asset('assets/lottieAnimations/continue.zip')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

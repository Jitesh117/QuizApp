import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_v2/UI/Home/home.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // height: MediaQuery.of(context).size.width,
                // width: MediaQuery.of(context).size.width,
                child: Lottie.asset(
                  'assets/lottieAnimations/welcomePattern.json',
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
              ),
              // const Text(
              //   "Welcome to our quiz app, where knowledge meets fun, and your quest for trivia begins!",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 32,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    border: Border.all(color: Colors.black, width: 5),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Text(
                    'PLAY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
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

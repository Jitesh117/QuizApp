import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/UI/Home/home.dart';
import 'package:quiz_v2/UI/Home/shop_screen.dart';

import '../../providers/player_provider.dart';
import '../../providers/question_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => Scaffold(
        backgroundColor: Colors.yellow.shade100,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        onTap: () async {},
                        child: const FaIcon(
                          FontAwesomeIcons.trophy,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          playerProvider.fetchPlayerData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShopScreen(),
                            ),
                          );
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
                                FontAwesomeIcons.cartShopping,
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Shop',
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
                SizedBox(
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
                      'PLAY!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

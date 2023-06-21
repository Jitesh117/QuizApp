import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../providers/player_provider.dart';
import '../../providers/question_provider.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => Scaffold(
        backgroundColor: Colors.yellow.shade100,
        body: SafeArea(
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
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
                              Navigator.pop(context);
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShopItem(
                          imagePath: 'assets/powerups/one.png',
                          price: 25,
                          bgColor: Colors.pinkAccent.shade200,
                        ),
                        ShopItem(
                          imagePath: 'assets/powerups/two.png',
                          price: 100,
                          bgColor: Colors.greenAccent.shade400,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShopItem(
                          imagePath: 'assets/powerups/three.png',
                          price: 50,
                          bgColor: Colors.yellow.shade200,
                        ),
                        ShopItem(
                          imagePath: 'assets/powerups/four.png',
                          price: 50,
                          bgColor: Colors.blueAccent.shade100,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopItem extends StatelessWidget {
  const ShopItem({
    super.key,
    required this.imagePath,
    required this.price,
    required this.bgColor,
  });
  final String imagePath;
  final int price;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.black, width: 4),
      ),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 90,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$price',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                const FaIcon(FontAwesomeIcons.coins)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

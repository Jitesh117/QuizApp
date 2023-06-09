import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Data/data_lists.dart';
import '../../providers/player_provider.dart';
import '../../providers/question_provider.dart';
import '../Styles/text_styles.dart';
import '../Widgets/shop/power_description.dart';
import '../Widgets/shop/shop_item.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
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
                                textScaleFactor:
                                    ScaleSize.textScaleFactor(context),
                                playerProvider.points.toString(),
                                style: regular,                             ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // remove wrong option powerup
                        GestureDetector(
                          onTap: () {
                            playerProvider.playTapSound();
                            playerProvider.buyOrNot(context, 25, 0);
                          },
                          child: ShopItem(
                            imagePath: 'assets/powerups/one.png',
                            price: 25,
                            bgColor: Colors.pinkAccent.shade200,
                            numberOfItems: playerProvider.powerDelete,
                          ),
                        ),
                        // reveal right option powerup
                        GestureDetector(
                          onTap: () {
                            playerProvider.playTapSound();
                            playerProvider.buyOrNot(context, 100, 1);
                          },
                          child: ShopItem(
                            imagePath: 'assets/powerups/two.png',
                            price: 100,
                            bgColor: Colors.greenAccent.shade400,
                            numberOfItems: playerProvider.powerReveal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // double coins powerup
                        GestureDetector(
                          onTap: () {
                            playerProvider.playTapSound();
                            playerProvider.buyOrNot(context, 50, 2);
                          },
                          child: ShopItem(
                            imagePath: 'assets/powerups/three.png',
                            price: 50,
                            bgColor: Colors.yellow.shade400,
                            numberOfItems: playerProvider.powerDouble,
                          ),
                        ),
                        // skip question powerup
                        GestureDetector(
                          onTap: () {
                            playerProvider.playTapSound();
                            playerProvider.buyOrNot(context, 50, 3);
                          },
                          child: ShopItem(
                            imagePath: 'assets/powerups/four.png',
                            price: 50,
                            bgColor: Colors.blueAccent,
                            numberOfItems: playerProvider.powerSkip,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: powerups.length,
                        itemBuilder: (context, index) => PowerDescription(
                          imagePath: powerups[index],
                          description: powerDescription[index],
                          bgColor: powerupColor[index],
                        ),
                      ),
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

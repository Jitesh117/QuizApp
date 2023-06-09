import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../providers/player_provider.dart';
import '../../providers/question_provider.dart';
import '../Styles/text_styles.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              //   child: Lottie.asset(
              //     'assets/lottieAnimations/patternBack.zip',
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! AppBar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                      ],
                    ),
                    //! appbar ends
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        itemCount: 22,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            playerProvider.playTapSound();
                            showModalBottomSheet(
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) => ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(32),
                                  topLeft: Radius.circular(32),
                                ),
                                child: Container(
                                  height: 300,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(32),
                                      topLeft: Radius.circular(32),
                                    ),
                                    border: Border.all(
                                        color: Colors.black, width: 4),
                                    // color: Colors.pink,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 170,
                                        child: AchievementBadge(
                                          imagePath: 'assets/badges/$index.png',
                                          unlocked: true,
                                        ),
                                      ),
                                      Text(
                                        textScaleFactor:
                                            ScaleSize.textScaleFactor(context),
                                        badgeName[index],
                                        textAlign: TextAlign.center,
                                        style: whiteBold,
                                      ),
                                      Text(
                                        textScaleFactor:
                                            ScaleSize.textScaleFactor(context),
                                        badgeDescription[index],
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Center(
                            child: playerProvider.badge[index]
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Shimmer(
                                      child: AchievementBadge(
                                        imagePath: 'assets/badges/$index.png',
                                        unlocked: playerProvider.badge[index],
                                      ),
                                    ),
                                  )
                                : AchievementBadge(
                                    imagePath: 'assets/badges/$index.png',
                                    unlocked: playerProvider.badge[index],
                                  ),
                          ),
                        ),
                      ),
                    )
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

class AchievementBadge extends StatelessWidget {
  const AchievementBadge({
    super.key,
    required this.imagePath,
    required this.unlocked,
  });
  final String imagePath;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          // border: Border.all(color: Colors.black, width: 3),
          // color: Colors.black,
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Center(
              child: Image.asset(
                imagePath,
              ),
            ),
            Visibility(
              visible: !unlocked,
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.lock,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

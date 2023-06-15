import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:quiz_v2/UI/Widgets/playerProfile/locked_badge.dart';
import 'package:quiz_v2/UI/Widgets/playerProfile/shimmer_badge.dart';
import 'package:quiz_v2/UI/Widgets/playerProfile/stats_tile_column.dart';
import 'package:quiz_v2/providers/question_provider.dart';

import '../../providers/player_provider.dart';
import '../Widgets/playerProfile/player_avatar.dart';

class PlayerProfilePage extends StatelessWidget {
  const PlayerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<PlayerProvider, QuesProvider>(
      builder: (context, playerProvider, quesProvider, _) => Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.circleXmark,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const FaIcon(
                      FontAwesomeIcons.gear,
                      size: 35,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        height: 600,
                        padding:
                            const EdgeInsets.only(top: 80, left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.black,
                            width: 2.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.deepPurpleAccent,
                                    Colors.deepPurpleAccent.shade400,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  StatsTileColumn(
                                    icon: Icons.star_outline_rounded,
                                    description: "POINTS",
                                    number: playerProvider.points.toString(),
                                  ),
                                  StatsTileColumn(
                                    icon: Icons.question_mark_rounded,
                                    description: "QUESTIONS",
                                    number: playerProvider.questionsPlayed
                                        .toString(),
                                  ),
                                  StatsTileColumn(
                                    icon: Icons.settings,
                                    description: "MAX STREAK",
                                    number: playerProvider.maxStreak.toString(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: categoryNames.length * 3,
                                itemBuilder: (context, index) =>
                                    quesProvider.badgesEarned[index ~/ 3]
                                                [index % 3] ==
                                            "0"
                                        ? LockedBadge(
                                            mainColor: colorThree[index ~/ 3],
                                            borderColor: colorTwo[index ~/ 3],
                                            imagePath: imagePaths[index ~/ 3])
                                        : ShimmerBadge(
                                            mainColor: colorThree[index ~/ 3],
                                            borderColor: colorTwo[index ~/ 3],
                                            imagePath: imagePaths[index ~/ 3],
                                          ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        children: [
                          PlayerAvatar(
                            imagePath: playerProvider.avatarPath,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 20, left: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Expanded(
                                      child: GridView.builder(
                                        itemCount: 24,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 30,
                                                mainAxisSpacing: 10),
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                          onTap: () => playerProvider.changeAvatar(
                                              'assets/userAvatars/memojis/user_profile_$index.png'),
                                          child: PlayerAvatar(
                                            imagePath:
                                                'assets/userAvatars/memojis/user_profile_$index.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    )),
                                child: const Icon(
                                  Icons.change_circle,
                                  color: Colors.deepPurpleAccent,
                                  size: 35,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

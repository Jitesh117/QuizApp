import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:quiz_v2/UI/Widgets/playerProfile/badge.dart';
import 'package:quiz_v2/UI/Widgets/playerProfile/stats_tile_column.dart';

import '../Widgets/playerProfile/player_avatar.dart';

class PlayerProfilePage extends StatelessWidget {
  const PlayerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StatsTileColumn(
                                    icon: Icons.star_outline_rounded,
                                    description: "POINTS"),
                                StatsTileColumn(
                                    icon: Icons.question_mark_rounded,
                                    description: "QUESTIONS"),
                                StatsTileColumn(
                                    icon: Icons.settings,
                                    description: "STREAK"),
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
                              itemCount: categoryNames.length,
                              itemBuilder: (context, index) => CategoryBadge(
                                mainColor: colorThree[index],
                                borderColor: colorTwo[index],
                                imagePath: imagePaths[index],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Align(
                      alignment: Alignment.topCenter, child: PlayerAvatar()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

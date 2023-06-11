import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:quiz_v2/UI/Player/player_profile_page.dart';
import 'package:quiz_v2/UI/Styles/text_styles.dart';
import 'package:quiz_v2/UI/Widgets/quizWidgets/genre_card.dart';

import '../../providers/ques_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<QuesProvider>(
      builder: (context, quesProvider, _) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 32, right: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //! AppBar
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.pink,
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (
                              context,
                            ) =>
                                const PlayerProfilePage(),
                          ),
                        );
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.userLarge,
                        color: Colors.deepPurpleAccent,
                      ),
                    )
                  ],
                ),
                //! appbar ends
                Text(
                  "Let's Play",
                  style: headingTextStyle,
                ),
                const SizedBox(height: 10),
                // Text(
                //   "Be the First!",
                //   style: levelTextStyle,
                // ),

                // ! Category tiles: Science, Books, Computers, VideoGames, Geography, Anime and Manga,
                Expanded(
                  child: ListView.builder(
                    itemCount: imagePaths.length,
                    itemBuilder: (context, index) => GenreCard(
                      width: width,
                      imagePath: imagePaths[index],
                      topicName: categoryNames[index],
                      colorOne: colorOne[index],
                      colorTwo: colorTwo[index],
                      colorThree: colorThree[index],
                      category: category[index],
                      streakColor: streakColor[index],
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

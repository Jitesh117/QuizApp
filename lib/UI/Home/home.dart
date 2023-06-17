import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:quiz_v2/UI/Styles/text_styles.dart';
import 'package:quiz_v2/UI/Widgets/quizWidgets/genre_card.dart';

import '../../providers/player_provider.dart';
import '../../providers/question_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Lottie.asset(
                  'assets/lottieAnimations/dayAnimation.zip',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! AppBar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // const FaIcon(
                        //   FontAwesomeIcons.solidHeart,
                        //   color: Colors.pink,
                        // ),
                        Text(
                          "Let's Play!",
                          style: headingTextStyle,
                        ),
                        const SizedBox(width: 20),
                        // GestureDetector(
                        //   onTap: () {
                        //     playerProvider.fetchPlayerData();
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (
                        //           context,
                        //         ) =>
                        //             const PlayerProfilePage(),
                        //       ),
                        //     );
                        //   },
                        //   child: SizedBox(
                        //     height: 50,
                        //     width: 50,
                        //     child: PlayerAvatar(
                        //         imagePath: playerProvider.avatarPath),
                        //   ),
                        // ),
                      ],
                    ),
                    //! appbar ends
                    const SizedBox(height: 10),
                    // Text(
                    //   "Be the First!",
                    //   style: levelTextStyle,
                    // ),

                    // ! Category tiles: Science, Books, Computers, VideoGames, Geography, Anime and Manga,
                    Expanded(
                      child: ListView.builder(
                        itemCount: genreNames.length,
                        itemBuilder: (context, index) => GenreCard(
                          width: width,
                          imagePath: imageBGPaths[index],
                          topicName: genreNames[index],
                          category: index,
                          streakColor: Colors.lightBlueAccent,
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

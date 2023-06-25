import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/Data/data_lists.dart';
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
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => Scaffold(
        backgroundColor: Colors.yellow.shade100,
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Lottie.asset(
                  'assets/lottieAnimations/patternBack.zip',
                  fit: BoxFit.cover,
                ),
              ),
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
                            quesProvider.playTapSound();
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

                    // ! Category tiles: Science, Books, Computers, VideoGames, Geography, Anime and Manga,
                    Expanded(
                      child: GridView.builder(
                        itemCount: genreNames.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: ((context, index) => GenreCard(
                              topicName: genreNames[index],
                              category: index,
                              streakColor: Colors.lightBlue,
                              bgColor: genreColor[index],
                            )),
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

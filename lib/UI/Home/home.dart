import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:quiz_v2/UI/Styles/text_styles.dart';
import 'package:quiz_v2/UI/Widgets/genre_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 32, right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! AppBar
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidHeart,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 20),
                  FaIcon(
                    FontAwesomeIcons.userLarge,
                    color: Colors.blue,
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
                    topicName: topicNames[index],
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
    );
  }
}

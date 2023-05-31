import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:quiz_v2/UI/Styles/textStyles.dart';
import 'package:quiz_v2/UI/Widgets/genre_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! AppBar
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
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
              Text(
                "Be the First!",
                style: levelTextStyle,
              ),

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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/UI/Quiz/choose_difficulty_page.dart';

import '../../../providers/question_provider.dart';
import '../../Styles/text_styles.dart';

class GenreCard extends StatelessWidget {
  const GenreCard({
    super.key,
    required this.width,
    required this.imagePath,
    required this.topicName,
    required this.category,
    required this.streakColor,
    required this.bgColor,
  });

  final double width;
  final String imagePath;
  final String topicName;

  final int category;
  final Color streakColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuesProvider>(
      builder: (context, quesProvider, _) => GestureDetector(
        onTap: () {
          quesProvider.loadQuestions();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChooseDifficultyPage(
                imagePath: imagePath,
                category: category,
                streakColor: streakColor,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Container(
                width: width - 32,
                height: 150,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  // boxshadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.8),
                  //     offset: const Offset(
                  //       0.0,
                  //       4.0,
                  //     ),
                  //     blurRadius: 4.0,
                  //   ),
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.8),
                  //     offset: const Offset(
                  //       4.0,
                  //       0.0,
                  //     ),
                  //     blurRadius: 4.0,
                  //   ),
                  // ],
                  //
                  // gradient: LinearGradient(
                  //   colors: [colorOne, colorTwo, colorThree],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),

                  // image: DecorationImage( filterQuality: FilterQuality.high,
                  //   colorFilter: const ColorFilter.srgbToLinearGamma(),
                  //   image: AssetImage(imagePath),
                  //   fit: BoxFit.fill,
                  // ),
                  color: bgColor,
                  border: Border.all(
                    color: Colors.black,
                    width: 4,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        topicName,
                        textAlign: TextAlign.center,
                        style: cardTextStyle,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Positioned(
            //   top: category == 0 ? 0 : -20,
            //   right: category == 0 ? 25 : 10,
            //   child: Image.asset(
            //     imagePath,
            //     height: category == 0 ? 100 : 150,
            //     colorBlendMode: BlendMode.colorBurn,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

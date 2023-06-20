import 'package:flutter/material.dart';

import '../../Styles/text_styles.dart';

class DifficultyTile extends StatelessWidget {
  const DifficultyTile({
    super.key,
    required this.difficulty,
    required this.colorOne,
    required this.colorTwo,
    required this.colorThree,
    required this.imagePath,
    required this.category,
  });

  final String difficulty;
  final Color colorOne;
  final Color colorTwo;
  final Color colorThree;
  final String imagePath;
  final int category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 32,
              height: 100,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                gradient: LinearGradient(
                  colors: [
                    // colorOne,
                    // colorOne,
                    // colorTwo,
                    colorThree,
                    colorThree,
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
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
                      difficulty,
                      style: cardTextStyle,
                    ),
                  )
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: category == 0 ? 0 : -20,
          //   right: category == 0 ? 20 : 10,
          //   child: Image.asset(
          //     imagePath,
          //     height: category == 0 ? 100 : 150,
          //     colorBlendMode: BlendMode.colorBurn,
          //   ),
          // ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../Styles/text_styles.dart';

class DifficultyTile extends StatelessWidget {
  const DifficultyTile({
    super.key,
    required this.difficulty,
    required this.colorOne,
    required this.colorTwo,
    required this.colorThree,
    required this.imagePath,
  });

  final String difficulty;
  final Color colorOne;
  final Color colorTwo;
  final Color colorThree;
  final String imagePath;

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
              height: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  gradient: LinearGradient(
                    colors: [
                      colorOne,
                      colorTwo,
                      colorThree,
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  )),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      difficulty,
                      style: cardTextStyle,
                    )
                  ]),
            ),
          ),
          Positioned(
            top: -20,
            right: 10,
            child: Image.asset(
              imagePath,
              height: 150,
              colorBlendMode: BlendMode.colorBurn,
            ),
          ),
        ],
      ),
    );
  }
}
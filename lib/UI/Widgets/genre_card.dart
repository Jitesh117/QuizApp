import 'package:flutter/material.dart';

import '../Styles/textStyles.dart';

class GenreCard extends StatelessWidget {
  const GenreCard({
    super.key,
    required this.width,
    required this.imagePath,
    required this.topicName,
  });

  final double width;
  final String imagePath;
  final String topicName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Container(
            width: width - 32,
            height: 150,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              gradient: LinearGradient(
                colors: [
                  Colors.pinkAccent,
                  Colors.redAccent,
                  Colors.orange,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    topicName,
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
          ),
        ),
      ],
    );
  }
}

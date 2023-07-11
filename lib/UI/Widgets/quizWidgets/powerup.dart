import 'package:flutter/material.dart';

import '../../Styles/text_styles.dart';

class PowerUp extends StatelessWidget {
  const PowerUp({
    super.key,
    required this.imagePath,
    required this.availability,
  });

  final String imagePath;
  final String availability;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imagePath,
          height: 55,
        ),
        Positioned(
          right: 0,
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                textScaleFactor: ScaleSize.textScaleFactor(context),
                availability,
                style: regularBold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

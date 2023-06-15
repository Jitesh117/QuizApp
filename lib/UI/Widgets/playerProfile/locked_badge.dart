
import 'package:flutter/material.dart';

class LockedBadge extends StatelessWidget {
  const LockedBadge({
    super.key,
    required this.mainColor,
    required this.borderColor,
    required this.imagePath,
  });
  final Color mainColor;
  final Color borderColor;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: mainColor,
              border: Border.all(
                color: borderColor,
                width: 5,
              )),
          child: Image.asset(
            imagePath,
            height: 80,
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.lock,
            color: Colors.white,
            size: 50,
          ),
        ),
      ],
    );
  }
}

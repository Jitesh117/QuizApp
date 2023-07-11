import 'package:flutter/material.dart';

import '../../Styles/text_styles.dart';

class PowerDescription extends StatelessWidget {
  const PowerDescription({
    super.key,
    required this.imagePath,
    required this.description,
    required this.bgColor,
  });
  final String imagePath;
  final String description;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13, right: 3),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black,
            width: 4,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(3, 3),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 40,
            ),
            const SizedBox(width: 10),
            Text(
              textScaleFactor: ScaleSize.textScaleFactor(context),
              description,
              overflow: TextOverflow.ellipsis,
              style: midBold,
            )
          ],
        ),
      ),
    );
  }
}

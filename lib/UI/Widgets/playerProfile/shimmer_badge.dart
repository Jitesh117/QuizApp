import 'package:flutter/material.dart';
import 'package:quiz_v2/UI/Widgets/playerProfile/badge.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerBadge extends StatelessWidget {
  const ShimmerBadge({
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Shimmer(
        color: Colors.white,
        duration: const Duration(seconds: 3),
        child: CategoryBadge(
          borderColor: borderColor,
          mainColor: mainColor,
          imagePath: imagePath,
        ),
      ),
    );
  }
}

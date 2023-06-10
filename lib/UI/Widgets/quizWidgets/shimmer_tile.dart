import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerTile extends StatelessWidget {
  const ShimmerTile({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Shimmer(
        duration: const Duration(seconds: 1),
        child:  SizedBox(
          width: width,
          height: height,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:quiz_v2/UI/Widgets/playerProfile/badge.dart';

class RotatingBadge extends StatefulWidget {
  const RotatingBadge({super.key});

  @override
  _RotatingBadgeState createState() => _RotatingBadgeState();
}

class _RotatingBadgeState extends State<RotatingBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: 
      CategoryBadge(
        borderColor: colorTwo[0],
        mainColor: colorThree[0],
        imagePath: imagePaths[0],
      ), // Replace with your badge image path
    );
  }
}

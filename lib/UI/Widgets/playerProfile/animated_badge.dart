import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
    required this.badge,
  });

  final Widget badge;

  @override
  createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  bool showFront = true;
  late AnimationController controller;
  bool shouldRotate = true;
  @override
  void initState() {
    super.initState();
    shouldRotate = true;
    // Initialize the animation controller
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300), value: 0);
    rotate();
  }

  void rotate() {
    if (shouldRotate) {
      Timer.periodic(const Duration(seconds: 1), (timer) async {
        await controller.forward();
        setState(() => showFront = !showFront);
        await controller.reverse();
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    shouldRotate = false;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.rotationY((controller.value) * pi / 2),
              alignment: Alignment.center,
              child: Container(
                height: MediaQuery.of(context).size.height - 130,
                alignment: Alignment.center,
                child: showFront ? widget.badge : widget.badge,
              ),
            );
          },
        ),
      ],
    );
  }
}

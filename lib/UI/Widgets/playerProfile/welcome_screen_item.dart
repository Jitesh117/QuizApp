import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreenButton extends StatelessWidget {
  const WelcomeScreenButton({
    required this.name,
    required this.buttonColor,
    required this.icon,
    super.key,
  });
  final String name;
  final Color buttonColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: buttonColor,
        border: Border.all(color: Colors.black, width: 5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              FaIcon(icon, size: 35),
              const Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

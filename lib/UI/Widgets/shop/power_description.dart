import 'package:flutter/material.dart';

class PowerDescription extends StatelessWidget {
  const PowerDescription({
    super.key,
    required this.imagePath,
    required this.description,
  });
  final String imagePath;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black,
            width: 4,
          ),
        ),
        child: Row(
            children: [
              Image.asset(
                imagePath,
                height: 40,
              ),
              const SizedBox(width: 10),
              Text(
                description,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
      ),
    );
  }
}

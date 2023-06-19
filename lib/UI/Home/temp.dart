import 'package:flutter/material.dart';

class WidgetCheck extends StatelessWidget {
  const WidgetCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border(
                  top: const BorderSide(color: Colors.white),
                  bottom: BorderSide(color: Colors.green.shade800),
                ),
              ),
              child: Text(
                'Easy'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GenreTile extends StatelessWidget {
  const GenreTile({
    super.key,
    required this.imagePath,
    required this.name,
  });
  final String imagePath;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width - 32,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.yellow,
          image: DecorationImage(
            // filterQuality: FilterQuality.high,
            // colorFilter: const ColorFilter.srgbToLinearGamma(),
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
          ),
        ),
        child: Text(
          name.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

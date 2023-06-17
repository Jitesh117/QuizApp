import 'package:flutter/material.dart';
import 'package:quiz_v2/Data/data_lists.dart';

class WidgetChceck extends StatelessWidget {
  const WidgetChceck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: ListView.builder(
              itemCount: genreNames.length,
              itemBuilder: (context, index) => GenreTile(
                name: genreNames[index],
                imagePath: imageBGPaths[index],
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

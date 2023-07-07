import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/providers/player_provider.dart';
import '../../../providers/question_provider.dart';

class OptionTile extends StatefulWidget {
  const OptionTile({
    super.key,
    required this.optionValue,
    required this.optionColor,
    required this.optionNumber,
    required this.category,
    required this.difficulty,
  });

  final String optionValue;
  final Color optionColor;
  final int optionNumber;
  final int category;
  final int difficulty;
  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: (quesProvider.tapped || quesProvider.showCorrectOption) &&
                      quesProvider.rightPosition == widget.optionNumber
                  ? [
                      Colors.yellowAccent.shade700,
                      Colors.green,
                    ]
                  : [
                      widget.optionColor,
                      widget.optionColor,
                    ],
            ),
            border: Border.all(
              color: Colors.black,
              width: 4,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(4, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: SizedBox(
            child: Center(
              child: Text(
                widget.optionValue,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

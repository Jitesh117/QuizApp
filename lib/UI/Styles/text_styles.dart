import 'dart:math';

import 'package:flutter/material.dart';

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

TextStyle regular = const TextStyle(
  fontSize: 20,
);

TextStyle regularBold = const TextStyle(
  fontWeight: FontWeight.w700,
);

TextStyle midBold = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
);

TextStyle bigBold = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

const TextStyle greenBold = TextStyle(
  color: Colors.green,
  fontSize: 20,
  fontWeight: FontWeight.w700,
);

const TextStyle redBold = TextStyle(
  color: Colors.red,
  fontSize: 20,
  fontWeight: FontWeight.w700,
);

const TextStyle whiteRegular = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w700,
);

const TextStyle whiteBold = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.w700,
);

import 'package:flame/extensions.dart';
import 'package:flutter/material.dart' hide Image, Gradient;

enum GameColors {
  black,
  white,
}

extension GameColorExtension on GameColors {
  Color get color {
    switch (this) {
      case GameColors.black:
        return ColorExtension.fromRGBHexString('#323231');
      case GameColors.white:
        return ColorExtension.fromRGBHexString('#FFFFFF');
    }
  }

  Paint get paint =>
      Paint()
        ..color = color;
}
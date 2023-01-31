import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PianoKey extends RectangleComponent {
  static const indicatorSize = 6.0;

  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();

  static Paint white = BasicPalette.white.paint();
  static Paint black = BasicPalette.black.paint();
  final String note;
  final bool isWhite;
  final int octave;
  PianoKey({
    required double width,
    required double height,
    required Vector2 position,
    required this.isWhite,
    required this.note,
    required int priority,
    required this.octave,
  }) : super(
          position: position,
          size: Vector2(width, height),
          paint: isWhite ? white : black,
          priority: priority,
        );

  @override
  Future<void> onLoad() async {
    if (note == "C" && octave == 4) {
      add(
        RectangleComponent(
          position: size / 2,
          size: Vector2.all(indicatorSize),
          anchor: Anchor.center,
          paint: blue,
        ),
      );
    }
    super.onLoad();
  }
}

import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piano_learn/models/piano_event.dart';
import 'package:piano_learn/piano_game.dart';
import 'package:piano_learn/piano_tile.dart';

class PianoKey extends RectangleComponent with TapCallbacks, DragCallbacks {
  static const indicatorSize = 6.0;

  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();

  static Paint white = BasicPalette.white.paint();
  static Paint black = BasicPalette.black.paint();
  static Paint grey = BasicPalette.gray.paint();
  static Paint yellow = BasicPalette.yellow.paint();
  static Paint lightPink = BasicPalette.lightPink.paint();
  final String note;
  final bool isWhite;
  PianoTile? tile;
  final int octave;

  static Paint purple = BasicPalette.purple.paint();

  static Paint green = BasicPalette.green.paint();
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
  void update(double dt) {
    super.update(dt);
  }

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

  void onKeyboardTapDown() {
    print("tap down, $note");
    paint = red;
    updateTileFromTouch(true);
    notifyTap(true);
  }

  void onKeyboardTapUp() {
    print("tap up, $note");
    paint = isWhite ? white : black;
    updateTileFromTouch(false);
    notifyTap(false);
  }

  @override
  void onTapDown(TapDownEvent event) {
    event.handled = true;
    onKeyboardTapDown();
  }

  @override
  void onTapUp(TapUpEvent event) {
    event.handled = true;
    onKeyboardTapUp();
  }

  void notifyTap(bool tapDown) {
    final parent = this.parent;
    if (parent is! MyGame) {
      return;
    }
    print("notifyTap, $note, $tapDown");

    parent.onEvent(tapDown, note, octave);
  }

  void updateTileFromTouch(bool tapDown) {
    final parent = this.parent as MyGame;
    if (parent.isPlayVariant) {
      return;
    }
    if (tapDown) {
      startTile(true);
    } else {
      endTile(true);
    }
  }

  void play(PianoEvent event) {
    bool tapDown = event.tapDown;

    if (tapDown) {
      startTile(false);
      tile?..eventDown = event;
    } else {
      endTile(false);
      tile?..eventUp = event;
    }
    tile?.recolor();
  }

  void startTile(bool isFromTouch) {
    // isFromTouch = false;

    tile?.pressed = false;
    final newTile = PianoTile()
      ..position = Vector2(position.x, isFromTouch ? position.y : 0)
      ..size = Vector2(size.x, 0)
      ..paint = isFromTouch ? paint : blue
      ..upDirection = isFromTouch
      ..priority = -1
      ..pressed = true;
    tile = newTile;
    parent?.add(newTile);
  }

  void endTile(bool isFromTouch) {
    tile?.pressed = false;
  }

  void reset() {
    tile?.removeFromParent();
    tile = null;
  }
}

import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:piano_learn/models/piano_event.dart';
import 'package:piano_learn/piano_game.dart';
import 'package:piano_learn/piano_key.dart';

class PianoTile extends RectangleComponent {
  bool pressed = false;
  bool upDirection = true;

  PianoEvent? eventDown;

  PianoEvent? eventUp;
  double get velocity => MyGame.tileVelocity;

  void updateDirectionUp(double dt) {
    final dx = velocity * dt;
    position += Vector2(0, -dx);
    if (pressed) {
      size.y += dx;
    }
    if ((position.y + size.y) < 0) {
      removeFromParent();
    }
  }

  void updateDirectionDown(double dt) {
    // position.x = 0;
    final dx = velocity * dt;

    if (pressed) {
      size.y += dx;
    } else {
      position.y += dx;
    }

    final parent = this.parent as MyGame;
    if ((position.y) > (parent.size.y)) {
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (upDirection) {
      updateDirectionUp(dt);
    } else {
      updateDirectionDown(dt);
    }
  }

  void recolor() {
    final eventDown = this.eventDown;
    final eventUp = this.eventDown;
    if (eventDown == null) {
      return;
    }
    late final Paint defaultPaint;
    if (eventDown.channel == 0) {
      defaultPaint = PianoKey.purple;
    } else if (eventDown.channel == 1) {
      defaultPaint = PianoKey.green;
    }

    if (eventUp != null && eventUp.played) {
      paint = PianoKey.grey;
    } else if (eventDown.played) {
      paint = PianoKey.yellow;
    } else {
      paint = defaultPaint;
    }
  }
}

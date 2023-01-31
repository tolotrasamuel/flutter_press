import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/audioplayer.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piano_learn/models/data.dart';
import 'package:piano_learn/models/piano_event.dart';
import 'package:piano_learn/piano_key.dart';

// import "package:math";
enum PianoMode {
  playRecord,
  freePlay,
  record,
  practiceRecord,
}

class MyGame extends FlameGame
    with HasTappableComponents, HasDraggableComponents {
  // final keyCounts = 61;
  // final startNote = "C";
  // final middleCOctaveFromLeft = 2;
  static const tileVelocity = 100.0; //unit of distance per unit of time
  static const keyHeight = 80.0;
  final int keyCounts;
  final String startNote;
  final int middleCOctaveFromLeft;
  final VoidCallback updateFlutter;
  MyGame({
    this.keyCounts = 61,
    this.startNote = "C",
    this.middleCOctaveFromLeft = 2,
    required this.updateFlutter,
  });
  final notes = [
    "C",
    "C#",
    "D",
    "D#",
    "E",
    "F",
    "F#",
    "G",
    "G#",
    "A",
    "A#",
    "B"
  ];

  List<PianoKey> pianoKeys = [];
  late final timeText = TextBoxComponent(
    text: "Time: $time",
    position: Vector2(100, 100),
  );
  @override
  Future<void> onLoad() async {
    recordings.clear();
    recordings.addAll(data.map((e) => PianoEvent.fromJson(e)).toList());
    buildPiano();
    add(timeText);
  }

  bool get isPlayVariant => {
        PianoMode.playRecord,
        PianoMode.practiceRecord,
      }.contains(pianoMode);

  int newestNoteOnViewPort = 0;
  int lastNotePlayed = -1;
  @override
  void update(double dt) {
    super.update(dt);
    if ({
      PianoMode.playRecord,
      PianoMode.record,
      PianoMode.practiceRecord,
    }.contains(pianoMode)) {
      time += dt;
      timeText.text = "Time: ${time.toStringAsFixed(2)}";
    }
    if (isPlayVariant) {
      handlePlayVariantUpdate(dt);
    }
    if (pianoMode == PianoMode.practiceRecord) {
      handlePracticeRecordUpdate(dt);
    }
  }

  int noteToIndex(String note, int musicalOctave) {
    final noteIndex = notes.indexOf(note);
    // final musicalOctave = (octaveIndex - middleCOctaveFromLeft) + 4;
    final octaveIndex = musicalOctave - 4 + middleCOctaveFromLeft;
    return noteIndex + octaveIndex * 12;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!event.handled) {
      final touchPoint = event.canvasPosition;
      // add(Square(touchPoint));
    }
  }

  final List<PianoEvent> recordings = [
    PianoEvent(note: "C", octave: 4, time: 1, tapDown: true),
    PianoEvent(note: "C", octave: 4, time: 1.5, tapDown: false),
    PianoEvent(note: "D", octave: 4, time: 1.6, tapDown: true),
    PianoEvent(note: "D", octave: 4, time: 2, tapDown: false),
    PianoEvent(note: "E", octave: 4, time: 2.1, tapDown: true),
    PianoEvent(note: "E", octave: 4, time: 2.6, tapDown: false),
  ];
  void onEvent(bool tapDown, String pitch, int octave) {
    print(
        "notifyTap parent, $pitch, $tapDown, $octave, $time, $pianoMode, $hashCode");
    final pianoEvent = PianoEvent(
      time: time,
      tapDown: tapDown,
      note: pitch,
      octave: octave,
    );
    if (pianoMode == PianoMode.record) {
      recordTouchEvent(pianoEvent);
    }
    if (pianoMode == PianoMode.practiceRecord) {
      practiceTouchEvent(pianoEvent);
    }
  }

  double time = 0;
  PianoMode pianoMode = PianoMode.freePlay;
  AudioPlayer player = AudioPlayer();
  // I don't know why the audio lagging or the tile are too fast
  double audioTimeOffset = 0.2;
  void startRecord() {
    print("start record, $hashCode");
    recordings.clear();
    time = 0;
    pianoMode = PianoMode.record;
  }

  void stopRecord() {
    print("stop record");
    pianoMode = PianoMode.freePlay;
    time = 0;
  }

  void startPracticeRecord(AudioPlayer player) {
    this.player = player;
    print("start practice record");
    pianoMode = PianoMode.practiceRecord;
    lastNotePlayed = -1;
    startPlayBack();
  }

  void startRecordPlayback(AudioPlayer player) {
    this.player = player;
    pianoMode = PianoMode.playRecord;
    startPlayBack();
  }

  void startPlayBack() {
    time = -viewPortDuration;
    newestNoteOnViewPort = 0;
  }

  void endRecordPlayback() {
    pianoMode = PianoMode.freePlay;
    time = 0;
    newestNoteOnViewPort = 0;
  }

  // weird offset
  final weirdOffset = 00;
  double get viewPortDuration =>
      (size.y - weirdOffset - keyHeight) / tileVelocity;
  void checkIfFinished() {
    final lastNote = recordings.last;
    if (time < lastNote.time) {
      return;
    }
    pianoMode = PianoMode.freePlay;
    updateFlutter();
  }

  void rewindMusic() {
    if (time < 0) {
      player.seek(Duration(seconds: 0));
      player.stop();
    } else {
      player.seek(
          Duration(milliseconds: ((time + audioTimeOffset) * 1000).toInt()));
    }
  }

  void gameOver() {
    time -= rewindGameOver;
    time = max(time, -viewPortDuration);

    rewindMusic();
    rewindTileViewPort();

    rewindPlayedNotes();

    print(
        "game over, back to $time and newestNoteOnViewPort $newestNoteOnViewPort and lastNotePlayed $lastNotePlayed");
  }

  void handlePlayVariantUpdate(double dt) {
    final isTimeToStartAudio =
        time > -audioTimeOffset && player.state != PlayerState.playing;
    if (isTimeToStartAudio) {
      print("start audio playing");
      player.resume();
    }

    final hasDisplayedLastRecord = newestNoteOnViewPort == recordings.length;
    if (hasDisplayedLastRecord) {
      checkIfFinished();
      return;
    }
    final note = recordings[newestNoteOnViewPort];
    final isTimeToShowInViewPort = time >= note.time - viewPortDuration;
    if (!isTimeToShowInViewPort) {
      return;
    }
    newestNoteOnViewPort++;
    final index = noteToIndex(note.note, note.octave);
    final key = pianoKeys[index];

    key.play(note);
  }

  final tolerance = 0.25;

  void practiceTouchEvent(PianoEvent pianoEvent) {
    final pitch = pianoEvent.note;
    final octave = pianoEvent.octave;
    final tapDown = pianoEvent.tapDown;
    for (int i = lastNotePlayed + 1; i < practiceRecording.length; i++) {
      final note = practiceRecording[i];
      final tooLateOrWrong = time > note.time + tolerance;
      final tooFast = time + tolerance < note.time;
      if (tooLateOrWrong || tooFast) {
        // game over
        print("GAME OVER, wrong note, $note, $time");
        gameOver();
        break;
      }
      if (note.time < time - tolerance) {
        continue;
      }
      final correct = note.note == pitch &&
          note.octave == octave &&
          note.tapDown == tapDown;
      if (!correct) {
        continue;
      }
      final error = (time - note.time);
      note.played = true;
      recolorTileOf(note);
      lastNotePlayed = i;
      print("correct, error: $error");
      break;
    }
  }

  List<PianoEvent> get practiceRecording =>
      recordings.where((element) => element.channel == 1).toList();
  void handlePracticeRecordUpdate(double dt) {
    final nextNoteToPlay = lastNotePlayed + 1;
    if (nextNoteToPlay == practiceRecording.length) {
      print("Congratulations, you finished the song!");
      return;
    }
    final note = practiceRecording[nextNoteToPlay];
    final isNoteMissed = time > note.time + tolerance;
    if (isNoteMissed) {
      print("GAME OVER, you missed a note");
      gameOver();
      return;
    }
  }

  void recordTouchEvent(PianoEvent pianoEvent) {
    recordings.add(pianoEvent);
  }

  void buildPiano() {
    if (!notes.contains(startNote) || startNote.endsWith("#")) {
      throw Exception("Start note must be a white key");
    }
    final startIndex = notes.indexOf(startNote);
    final leftMostOctaveKeyCount = 12 - startIndex;
    final remainingKeyCount = keyCounts - leftMostOctaveKeyCount;
    final fullOctaveCount = (remainingKeyCount / 12).floor();
    final middleKeyCount = fullOctaveCount * 12;
    final rightMostOctaveKeyCount =
        keyCounts - middleKeyCount - leftMostOctaveKeyCount;
    int leftWhites = 0;
    for (int i = startIndex; i < notes.length; i++) {
      final note = notes[i];
      // print("note left: $note");
      if (!note.endsWith("#")) {
        leftWhites++;
      }
    }
    int rightWhites = 0;
    for (int i = 0; i < rightMostOctaveKeyCount; i++) {
      final note = notes[i];
      if (!note.endsWith("#")) {
        rightWhites++;
      }
    }
    final middleWhites = fullOctaveCount * 7;
    final totalWhites = leftWhites + middleWhites + rightWhites;
    print("viewp port: $size, total whites: $totalWhites");
    final horizontalMargin = 80;
    final width = (size.x - horizontalMargin) / totalWhites;
    print("width: $width");
    print(
        "left keys: $leftMostOctaveKeyCount, middle keys: $middleKeyCount, right keys: $rightMostOctaveKeyCount");
    print(
        "left White: $leftWhites, middle whites: $middleWhites, right whites: $rightWhites");
    double previousWhiteNoteX = 0;

    int totalOctaves = middleWhites;
    if (rightMostOctaveKeyCount > 0) {
      totalOctaves++;
    }
    if (leftMostOctaveKeyCount > 0) {
      totalOctaves++;
    }

    int octaveIndex = notes[startIndex] == "C" ? -1 : 0;
    for (int i = 0; i < keyCounts; i++) {
      final note = notes[(startIndex + i) % 12];
      if (note == "C") {
        octaveIndex++;
      }
      final isWhite = !note.endsWith("#");
      final y = size.y - keyHeight;
      final blackWidth = width / 1.5;
      final position = isWhite
          ? Vector2(previousWhiteNoteX + width, y)
          : Vector2(previousWhiteNoteX + width - (blackWidth) / 2, y);
      if (isWhite) {
        previousWhiteNoteX += width + 1;
      }
      // print("note: $note, isWhite: $isWhite, position: $position");
      final musicalOctave = (octaveIndex - middleCOctaveFromLeft) + 4;
      // print("Note: $note, octave: $musicalOctave, octaveIndex: $octaveIndex");
      final key = PianoKey(
        octave: musicalOctave,
        width: isWhite ? width : blackWidth,
        height: isWhite ? keyHeight : keyHeight / 1.6,
        position: position,
        note: note,
        isWhite: isWhite,
        priority: isWhite ? 0 : 1,
      );
      add(key);
      pianoKeys.add(key);
    }
  }

  void recolorTileOf(PianoEvent note) {
    final pianokey = pianoKeys[noteToIndex(note.note, note.octave)];
    pianokey.tile?.recolor();
  }

  void rewindTileViewPort() {
    final currentIndex = min(newestNoteOnViewPort, recordings.length - 1);
    for (int i = currentIndex; i >= 0; i--) {
      final note = recordings[i];
      if ((time - viewPortDuration) < note.time) {
        newestNoteOnViewPort = i;
      } else {
        break;
      }
    }

    for (final key in pianoKeys) {
      key.reset();
    }
  }

  int rewindGameOver = 10;
  int rewindNotesSec = 5;

  void rewindPlayedNotes() {
    if (rewindNotesSec > rewindGameOver) {
      throw Exception("rewindNotesSec must be greater than rewindGameOver");
    }
    for (int i = lastNotePlayed; i >= 0; i--) {
      final note = recordings[i];
      if (time + rewindNotesSec < note.time) {
        note.played = false;
        recolorTileOf(note);
        lastNotePlayed = i - 1;
      } else {
        break;
      }
    }
  }
}

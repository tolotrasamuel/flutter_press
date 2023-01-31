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
      gameTime += dt;
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
      print("event: $pianoEvent started");
      practiceTouchEvent(pianoEvent);
      print("event: $pianoEvent ended");
    }
  }

  double time = 0;
  double graceDeadline = double.infinity;
  double gameTime = 0;
  DateTime startTime = DateTime.now();
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
    gameTime = 0;
    graceDeadline = double.infinity;
    startTime = DateTime.now();
    newestNoteOnViewPort = 0;
  }

  void stopPractice() {
    for (final note in practiceRecording) {
      note.played = false;
    }
    endRecordPlayback();
  }

  void endRecordPlayback() {
    print("end record playback");
    pianoMode = PianoMode.freePlay;
    final timeDrift = measureTimeDrift();
    print("timeDrift $timeDrift");
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
    final oldTime = time;
    time -= rewindGameOver;
    time = max(time, -viewPortDuration);
    graceDeadline = time + gracePeriod;
    print("returning to time $time from oldTime $oldTime");
    print("Your sequence: \n${notePlayedSequence.join("\n")}");
    notePlayedSequence.clear();
    rewindMusic();
    rewindTileViewPort();

    rewindPlayedNotes(oldTime);

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

  final tolerance = 0.55;

  List<PianoEvent> pianoEventQueue = [];

  void practiceTouchEventOrchestrator(PianoEvent pianoEvent) {
    pianoEventQueue.add(pianoEvent);
    notifyNewTask();
  }

  List<PianoEvent> notePlayedSequence = [];
  void practiceTouchEvent(PianoEvent pianoEvent) {
    final pitch = pianoEvent.note;
    final octave = pianoEvent.octave;
    final tapDown = pianoEvent.tapDown;
    int? beforeOldestUnplayedIndex;
    if (graceDeadline != double.infinity && time < graceDeadline) {
      print("grace period");
      return;
    }
    notePlayedSequence.add(pianoEvent);
    for (int i = lastNotePlayed + 1; i < practiceRecording.length; i++) {
      final note = practiceRecording[i];
      final isMissedNote = note.time < time - tolerance; // a missed note

      // this note is outside the tolerance window in the future zone, which is not a problem
      // but the fact that code reached here means that no note is found in the tolerance window
      // so user type wrong note.
      final noNoteFoundInToleranceWindow = time + tolerance < note.time;
      //   [ Future ]
      //   [ noNoteFound = means wrong note] => Game over
      //   [ acceptable earliness] => ok
      //   [ now ]
      //   [ acceptable lateness] => ok
      //   [ a missed note found ] => Game over
      //   [ Past ]
      if (isMissedNote || noNoteFoundInToleranceWindow) {
        // game over
        final timeDrift = measureTimeDrift();
        print("timeDrift $timeDrift");
        print("GAME OVER, wrong note, $note, $time");
        gameOver();
        break;
      }

      // by the time code reaches here, the current note in the loop is found in the tolerance window
      // however, we still need to check if it is the correct note touched
      // if not correct, it's ok, we just skip it and check the next note
      final correct = note.note == pitch &&
          note.octave == octave &&
          note.tapDown == tapDown;
      if (!correct) {
        // we are assiging only once because we want to keep the oldest unplayed note
        // and the recording is sorted by time
        // consider the following case
        // [A0, B1, C1, D2]
        // A0 is played at time 0
        // Then C1 is played before
        // oldestUnplayed is C1, and before it is A0
        beforeOldestUnplayedIndex ??= i - 1;
        continue;
      }

      // by the time code reaches here, the current note in the loop is found in the tolerance window
      // and is correct
      final error = (time - note.time);
      note.played = true;
      recolorTileOf(note);
      // some notes in the tolerance window may have been skipped before reaching this correct one
      lastNotePlayed = (beforeOldestUnplayedIndex) ?? i;
      if (beforeOldestUnplayedIndex != null) {
        lastNotePlayed = beforeOldestUnplayedIndex;
      } else {
        // we know that i is played, but are not sure if the note after is unplayed.
        // so we need to check if the note after is unplayed until we find one
        // [A0, B1, C1, D2]
        // [PA0, B1, C1, D2]
        // [PA0, B1, PC1, D2]
        // [PA0, *PB1*, PC1, D2] => lastNotePlayed = is PB1 which is i in this context,
        // but we need to check if the note after is unplayed, so we traverse until we find
        // D2 which is unplayed, so lastNotePlayed = PC1 (one before it)
        // this is complex but very efficient, especially since we dealing with a game frame

        for (int j = i + 1; j <= practiceRecording.length; j++) {
          if (j == practiceRecording.length) {
            lastNotePlayed = j - 1;
            // we are at the end of the recording, so we are done. Congrats!
            break;
          }
          final note = practiceRecording[j];
          if (note.played) {
            continue;
          }
          lastNotePlayed = j - 1;
          break;
        }
      }

      print("correct, error: $error");
      break;
    }
  }

  List<PianoEvent> get practiceRecording =>
      recordings.where((element) => element.channel == 1).toList();
  void handlePracticeRecordUpdate(double dt) {
    final nextNoteToPlay = lastNotePlayed + 1;
    final hasPlayedAllNotes = nextNoteToPlay == practiceRecording.length;
    if (hasPlayedAllNotes) {
      print("Congratulations, you finished the song!");
      return;
    }
    final note = practiceRecording[nextNoteToPlay];
    final isNoteMissed = note.time < time - tolerance;
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
  int gracePeriod = 5;

  void rewindPlayedNotes(double oldTime) {
    if (gracePeriod > rewindGameOver) {
      throw Exception("rewindNotesSec must be greater than rewindGameOver");
    }
    printThrottle("rewinding played notes from $lastNotePlayed");

    // lastNotePlayed was designed to be the marker where there is the oldest unplated note
    // it was designed for game over scenario
    // so we need to loop forward and backward the lastNotePlayed position to reset all notes
    // it is safe to assume as of now that no note was played beyound the old_time

    final lastNoteIndexPlayed = lastNotePlayed;
    //from lastNoteIndexPlayed to new Time (and taking this opportunity to mark the new
    //lastNotePlayed cursor)

    for (int i = lastNoteIndexPlayed; i >= 0; i--) {
      final note = practiceRecording[i];
      final noteIsNotBeforeNewTime = time <= note.time;
      if (noteIsNotBeforeNewTime) {
        note.played = false;
        recolorTileOf(note);
        lastNotePlayed = i - 1;
      } else {
        break;
      }
    }

    // from lastNoteIndexPlayed+1 to old_time
    for (int i = lastNoteIndexPlayed + 1; i < practiceRecording.length; i++) {
      final note = practiceRecording[i];
      final notIsNotBeyondOldTime = note.time <= oldTime;
      if (notIsNotBeyondOldTime) {
        note.played = false;
        recolorTileOf(note);
      } else {
        break;
      }
    }
    print(
        "rewind to lastNoteIndexPlayed: $lastNotePlayed from $lastNoteIndexPlayed");
  }

  double lastPrintTime = 0;
  void printThrottle(String message) {
    if (time - lastPrintTime > 1) {
      print(message);
      lastPrintTime = time;
    }
  }

  double measureTimeDrift() {
    final timeLapse =
        DateTime.now().difference(startTime).inMilliseconds / 1000;
    final timeDrift = timeLapse - gameTime;
    print("game over, time drift $timeDrift");
    return timeDrift;
  }

  void notifyNewTask() {}
}

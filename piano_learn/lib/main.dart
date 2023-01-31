import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:piano_learn/midi_setting.dart';
import 'package:piano_learn/piano_game.dart';

// void main() => runApp(VideoToImage());
void main() => runApp(MaterialApp(home: PianoApp()));
// void main() => runApp(MaterialApp(home: VideoPlayerApp()));

// void main() {
//   runApp(
//     GameWidget(
//       game: MyGame(),
//     ),
//   );
// }

/// This example simply adds a rotating white square on the screen.
/// If you press on a square, it will be removed.
/// If you press anywhere else, another square will be added.
///

class PianoApp extends StatefulWidget {
  const PianoApp({Key? key}) : super(key: key);

  @override
  State<PianoApp> createState() => _PianoAppState();
}

class GamePiano extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> gamekey;
  const GamePiano({Key? key, required this.gamekey}) : super(key: key);

  @override
  State<GamePiano> createState() => _GamePianoState();
}

class _GamePianoState extends State<GamePiano> {
  @override
  Widget build(BuildContext context) {
    return GameWidget(
      key: widget.gamekey,
      // game: game,
      game: MyGame(updateFlutter: () {
        setState(() {});
      }),
    );
  }
}

class _PianoAppState extends State<PianoApp> {
  final GlobalKey _key = GlobalKey();
  // MyGame get game => (_key.currentState as dynamic).widget.game;
  late MyGame game = MyGame(
    updateFlutter: () {
      setState(() {});
    },
  );
  bool initialized = false;
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    //  schedule post frame
    setupMidiInput();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialized = true;
      loadAudio();
      setState(() {});
    });
  }

  void dispose() {
    _rxSubscription?.cancel();
    player.release();
    super.dispose();
  }

  StreamSubscription<MidiPacket>? _rxSubscription;
  MidiCommand _midiCommand = MidiCommand();

  void setupMidiInput() {
    print('init controller in _PianoAppState');
    _rxSubscription?.cancel();
    _rxSubscription = _midiCommand.onMidiDataReceived?.listen((packet) {
      print('received packet _PianoAppState $packet');
      var data = packet.data;
      var timestamp = packet.timestamp;
      var device = packet.device;
      print(
          "data $data @ time $timestamp from device ${device.name}:${device.id}");
      var status = data[0];
      print("Status $status");

      final key = data[1];
      final touch_up = data[2] == 0; // 0 down and 127 up
      final key_range = [36, 96];
      final deviceMiddleCIndex = 60;
      final gameMiddleCindex = game.noteToIndex("C", 4);
      final note = game.pianoKeys[gameMiddleCindex + key - deviceMiddleCIndex];
      if (touch_up) {
        note.onKeyboardTapUp();
      } else {
        note.onKeyboardTapDown();
      }
      // note.onTapDown(touch_up);
      // game.onEvent(!touch_up, note.note, note.octave);
    });

    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
    player.release();
    game = MyGame(
      updateFlutter: () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.yellow),
            ),
            child: Center(
              // child: GamePiano(
              //   gamekey: _key,
              // ),
              child: GameWidget(
                key: _key,
                // game: game,
                game: game,
              ),
            ),
          ),
        ),
        if (initialized)
          Container(
            color: Colors.white,
            child: SizedBox(
              height: 100,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              await player.setSourceAsset(
                                  'audio/if-you-love-me-for-me-easy-piano-tutorial.mp3');
                              player.resume();
                            },
                            child: Text("Load audio")),
                        ElevatedButton(
                            onPressed: () async {
                              player.stop();
                            },
                            child: Text("stop audio")),
                        if (game.pianoMode == PianoMode.freePlay)
                          ElevatedButton(
                            onPressed: () {
                              print("pressed");
                              game.startRecord();
                              setState(() {});
                            },
                            child: Text("Record"),
                          ),
                      ],
                    ),
                    if (game.pianoMode == PianoMode.record)
                      ElevatedButton(
                        onPressed: () {
                          print("pressed");
                          game.stopRecord();
                          print("recording: ${game.recordings.length}");
                          setState(() {});
                        },
                        child: Text("Stop"),
                      ),
                    if (game.recordings.isNotEmpty)
                      if (!game.isPlayVariant)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: Text("Play"),
                              onPressed: () async {
                                await player.setSourceAsset(
                                    'audio/if-you-love-me-for-me-easy-piano-tutorial.mp3');
                                // player.resume();
                                print("pressed");
                                game.startRecordPlayback(player);
                                setState(() {});
                              },
                            ),
                            ElevatedButton(
                              child: Text("Setup Midi"),
                              onPressed: () async {
                                await Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => MidiSetupPage(),
                                  ),
                                );
                                print("returned. Re listening");
                                setupMidiInput();
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              child: Text("Practice Record"),
                              onPressed: () async {
                                await player.setSourceAsset(
                                    'audio/if-you-love-me-for-me-easy-piano-tutorial.mp3');
                                print("pressed");
                                game.startPracticeRecord(player);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                    if (game.pianoMode == PianoMode.practiceRecord)
                      ElevatedButton(
                        child: Text("Stop Practice"),
                        onPressed: () {
                          print("pressed");
                          game.endRecordPlayback();
                          player.stop();
                          setState(() {});
                        },
                      ),
                    if (game.pianoMode == PianoMode.playRecord)
                      ElevatedButton(
                        child: Text("Stop Playback"),
                        onPressed: () {
                          print("pressed");
                          player.stop();
                          game.endRecordPlayback();
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
      ],
    ));
  }

  Future<void> loadAudio() async {
    player.setReleaseMode(ReleaseMode.stop);
    await player.setSource(
        AssetSource('audio/if-you-love-me-for-me-easy-piano-tutorial.mp3'));
  }
}

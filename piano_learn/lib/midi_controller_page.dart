import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_midi_command/flutter_midi_command_messages.dart';

class MidiControllerPage extends StatelessWidget {
  final MidiDevice device;

  MidiControllerPage(this.device);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controls'),
      ),
      body: MidiControls(device),
    );
  }
}

class MidiControls extends StatefulWidget {
  final MidiDevice device;

  MidiControls(this.device);

  @override
  MidiControlsState createState() {
    return new MidiControlsState();
  }
}

class MidiControlsState extends State<MidiControls> {
  var _channel = 0;
  var _controller = 0;
  var _ccValue = 0;
  var _pcValue = 0;
  var _pitchValue = 0.0;

  // StreamSubscription<String> _setupSubscription;
  StreamSubscription<MidiPacket>? _rxSubscription;
  MidiCommand _midiCommand = MidiCommand();

  @override
  void initState() {
    print(
        'init controller device in MidiControllerPage ${widget.device.name} connected ${widget.device.connected}');
    _rxSubscription = _midiCommand.onMidiDataReceived?.listen((packet) {
      print('received packet from MidiControllerPage $packet');
      var data = packet.data;
      var timestamp = packet.timestamp;
      var device = packet.device;
      print(
          "data $data @ time $timestamp from device ${device.name}:${device.id}");

      var status = data[0];

      if (status == 0xF8) {
        // Beat
        return;
      }

      if (status == 0xFE) {
        // Active sense;
        return;
      }

      // I/flutter (21627): received packet Instance of 'MidiPacket'
      // I/flutter (21627): data [144, 65, 0] @ time 40656489612420 from device HOLTEK MIDI KEYBOARD:5
      // I/flutter (21627): received packet Instance of 'MidiPacket'
      // I/flutter (21627): data [144, 64, 127] @ time 40656697607727 from device HOLTEK MIDI KEYBOARD:5
      // I/flutter (21627): received packet Instance of 'MidiPacket'
      // I/flutter (21627): data [144, 64, 0] @ time 40657414168188 from device HOLTEK MIDI KEYBOARD:5
      if (data.length >= 2) {
        var rawStatus = status & 0xF0; // without channel
        var channel = (status & 0x0F);
        if (channel == _channel) {
          var d1 = data[1];
          switch (rawStatus) {
            case 0xB0: // CC
              if (d1 == _controller) {
                // CC
                var d2 = data[2];
                setState(() {
                  _ccValue = d2;
                });
              }
              break;
            case 0xC0: // PC
              setState(() {
                _pcValue = d1;
              });
              break;
            case 0xE0: // Pitch Bend
              setState(() {
                var rawPitch = d1 + (data[2] << 7);
                _pitchValue = (((rawPitch) / 0x3FFF) * 2.0) - 1;
              });
              break;
          }
        }
      }
    });

    super.initState();
  }

  void dispose() {
    // _setupSubscription?.cancel();
    _rxSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(12),
      children: <Widget>[
        Text("Channel", style: Theme.of(context).textTheme.headline6),
        SteppedSelector('Channel', _channel + 1, 1, 16, _onChannelChanged),
        Divider(),
        Text("CC", style: Theme.of(context).textTheme.headline6),
        SteppedSelector(
            'Controller', _controller, 0, 127, _onControllerChanged),
        SlidingSelector('Value', _ccValue, 0, 127, _onValueChanged),
        Divider(),
        Text("PC", style: Theme.of(context).textTheme.headline6),
        SteppedSelector('Program', _pcValue, 0, 127, _onProgramChanged),
        Divider(),
        Text("Pitch Bend", style: Theme.of(context).textTheme.headline6),
        Slider(
            value: _pitchValue,
            max: 1,
            min: -1,
            onChanged: _onPitchChanged,
            onChangeEnd: (_) {
              _onPitchChanged(0);
            }),
        Divider(),
        SizedBox(
          height: 80,
          // child: VirtualPiano(
          //   noteRange: RangeValues(48, 76),
          //   onNotePressed: (note, vel) {
          //     NoteOnMessage(note: note, velocity: 100).send();
          //   },
          //   onNoteReleased: (note) {
          //     NoteOffMessage(note: note).send();
          //   },
          // ),
        )
      ],
    );
  }

  _onChannelChanged(int newValue) {
    setState(() {
      _channel = newValue - 1;
    });
  }

  _onControllerChanged(int newValue) {
    setState(() {
      _controller = newValue;
    });
  }

  _onProgramChanged(int newValue) {
    setState(() {
      _pcValue = newValue;
    });
    PCMessage(channel: _channel, program: _pcValue).send();
  }

  _onValueChanged(int newValue) {
    setState(() {
      _ccValue = newValue;
    });
    CCMessage(channel: _channel, controller: _controller, value: _ccValue)
        .send();
  }

  _onPitchChanged(double newValue) {
    setState(() {
      _pitchValue = newValue;
    });
    PitchBendMessage(channel: _channel, bend: newValue).send();
  }
}

class SteppedSelector extends StatelessWidget {
  final String label;
  final int minValue;
  final int maxValue;
  final int value;
  final Function(int) callback;

  SteppedSelector(
      this.label, this.value, this.minValue, this.maxValue, this.callback);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(label),
        IconButton(
            icon: Icon(Icons.remove_circle),
            onPressed: (value > minValue)
                ? () {
                    callback(value - 1);
                  }
                : null),
        Text(value.toString()),
        IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: (value < maxValue)
                ? () {
                    callback(value + 1);
                  }
                : null)
      ],
    );
  }
}

class SlidingSelector extends StatelessWidget {
  final String label;
  final int minValue;
  final int maxValue;
  final int value;
  final Function(int) callback;

  SlidingSelector(
      this.label, this.value, this.minValue, this.maxValue, this.callback);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(label),
        Slider(
          value: value.toDouble(),
          divisions: maxValue,
          min: minValue.toDouble(),
          max: maxValue.toDouble(),
          onChanged: (v) {
            callback(v.toInt());
          },
        ),
        Text(value.toString()),
      ],
    );
  }
}

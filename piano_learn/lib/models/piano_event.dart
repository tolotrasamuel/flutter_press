class PianoEvent {
  final double time;
  final bool tapDown;
  final String note;
  final int octave;
  final int channel;

  // used in practice mode
  bool played = false;
  PianoEvent({
    required this.time,
    required this.tapDown,
    required this.note,
    required this.octave,
    this.channel = 0,
  });

  @override
  String toString() {
    return "PianoEvent(time: $time, tapDown: $tapDown, note: $note, octave: $octave, channel: $channel)";
  }

//  from Json
  PianoEvent.fromJson(Map<String, dynamic> json)
      : time = json['time'] / 1000,
        tapDown = json['tapDown'],
        note = json['note'],
        channel = json['channel'],
        octave = json['octave'];

  Map<String, dynamic> toJson() => {
        'time': time,
        'tapDown': tapDown,
        'channel': channel,
        'note': note,
        'octave': octave,
      };
}

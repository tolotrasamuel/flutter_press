import 'package:intl/intl.dart';

// extensions on date for formatting

extension DateFormatter on DateTime {
  static DateFormat f = DateFormat('EEE dd MMM’yy HH:mm');
  String get formatted => f.format(toLocal());
  String format(DateFormat f) => f.format(toLocal());

  String formatTime({bool useGmt = false}) {
    // val df: DateFormat =
    //     SimpleDateFormat("HH:mm", Locale.getDefault())
    // if (useGmt) df.timeZone = TimeZone.getTimeZone("GMT")
    // val text = df.format(this.time)
    // return text
    final df = DateFormat("HH:mm");
    DateTime date = this;
    if (useGmt) {
      date = toUtc();
    } else {
      date = toLocal();
    }
    final text = df.format(date);
    return text;
  }
}

extension StringToDate on String {
//  try parse, return null if not parsable
  DateTime? get toDate => DateTime.tryParse(this);
  String? get timeLeftAgo {
    final now = DateTime.now();
    final deadline = toDate;
    if (deadline == null) {
      return null;
    }
    final difference = deadline.difference(now);
    final leftOrAgo = difference.isNegative ? "ago" : "left";

    //abs

    final days = difference.inDays.abs();
    final hours = difference.inHours.abs();
    final minutes = difference.inMinutes.abs();

    if (days > 0) {
      final s = days > 1 ? 's' : '';
      return '$days day$s $leftOrAgo';
    }
    if (hours > 0) {
      final s = hours > 1 ? 's' : '';
      return '$hours hour$s  $leftOrAgo';
    }
    if (minutes > 0) {
      final s = minutes > 1 ? 's' : '';
      return '$minutes minute$s  $leftOrAgo';
    }
    return null;
  }
}

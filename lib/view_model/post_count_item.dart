import 'package:flutter_press/model/post_status.dart';

class PostCountItem {
  final String text;
  int count;
  final bool alwaysShow;
  final PostStatus? status;
  PostCountItem({
    required this.text,
    this.alwaysShow = false,
    this.count = 0,
    required this.status,
  });
}

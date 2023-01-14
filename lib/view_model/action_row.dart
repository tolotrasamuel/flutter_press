import 'dart:ui';

class RowAction {
  final String text;
  final VoidCallback onTap;
  final bool isDestructive;

  RowAction(
      {required this.text, required this.onTap, this.isDestructive = false});
}

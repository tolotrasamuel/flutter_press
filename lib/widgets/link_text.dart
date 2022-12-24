import 'package:flutter/material.dart';
import 'package:flutter_press/widgets/hover_builder.dart';

class LinkText extends StatelessWidget {
  final String text;
  final bool? isHovered;
  final FontWeight? fontWeight;
  const LinkText(
    this.text, {
    Key? key,
    this.isHovered,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(builder: (hovering) {
      final isHovered = this.isHovered ?? hovering;
      return Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontFamily: 'Recoleta',
          fontWeight: fontWeight ?? FontWeight.w200,
          color: isHovered ? Colors.blue : Colors.white,
        ),
      );
    });
  }
}

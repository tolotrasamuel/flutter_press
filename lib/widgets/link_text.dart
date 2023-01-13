import 'package:flutter/material.dart';
import 'package:flutter_press/widgets/hover_builder.dart';

class LinkTextBlue extends StatelessWidget {
  final String text;
  final bool? isHovered;
  final FontWeight? fontWeight;
  const LinkTextBlue(
    this.text, {
    Key? key,
    this.isHovered,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinkText(
      text,
      isHovered: isHovered,
      fontWeight: fontWeight,
      color: Colors.blue,
      hoveredColor: Color(0xff9DCBFE),
    );
  }
}

class LinkTextRed extends StatelessWidget {
  final String text;
  final bool? isHovered;
  final FontWeight? fontWeight;
  const LinkTextRed(
    this.text, {
    Key? key,
    this.isHovered,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinkText(
      text,
      isHovered: isHovered,
      fontWeight: fontWeight,
      underline: true,
      color: Colors.red[300]!,
      hoveredColor: Colors.red[200]!,
    );
  }
}

class LinkText extends StatelessWidget {
  final String text;
  final bool? isHovered;
  final FontWeight? fontWeight;
  final Color hoveredColor;
  final Color color;
  final bool underline;
  const LinkText(
    this.text, {
    Key? key,
    this.isHovered,
    this.fontWeight,
    this.hoveredColor = Colors.blue,
    this.color = Colors.white,
    this.underline = false,
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
          color: isHovered ? hoveredColor : color,
          decoration: underline ? TextDecoration.underline : null,
        ),
      );
    });
  }
}

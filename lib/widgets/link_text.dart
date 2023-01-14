import 'package:flutter/material.dart';
import 'package:flutter_press/widgets/hover_builder.dart';

class LinkTextBlue extends StatelessWidget {
  final String text;
  final bool? isHovered;
  final FontWeight? fontWeight;
  final double? fontSize;
  final GestureTapCallback? onTap;
  const LinkTextBlue(
    this.text, {
    Key? key,
    this.isHovered,
    this.fontWeight,
    this.onTap,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinkText(
      text,
      onTap: onTap,
      isHovered: isHovered,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: Colors.blue,
      hoveredColor: Color(0xff9DCBFE),
    );
  }
}

class LinkTextRed extends StatelessWidget {
  final String text;
  final bool? isHovered;
  final FontWeight? fontWeight;
  final GestureTapCallback? onTap;
  final bool? underline;
  const LinkTextRed(
    this.text, {
    Key? key,
    this.isHovered,
    this.fontWeight,
    this.underline,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinkText(
      text,
      isHovered: isHovered,
      fontWeight: fontWeight ?? FontWeight.w600,
      underline: underline ?? true,
      onTap: onTap,
      color: Colors.red[300]!,
      // color: Color(0xffb32d2e),
      hoveredColor: Colors.red[200]!,
    );
  }
}

class LinkText extends StatelessWidget {
  final String text;
  final bool? isHovered;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color hoveredColor;
  final Color color;
  final bool underline;
  final GestureTapCallback? onTap;
  const LinkText(
    this.text, {
    Key? key,
    this.isHovered,
    this.fontWeight,
    this.onTap,
    this.hoveredColor = Colors.blue,
    this.color = Colors.white,
    this.underline = false,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: HoverBuilder(builder: (hovering) {
        final isHovered = this.isHovered ?? hovering;
        return Text(
          text,
          style: TextStyle(
            fontSize: this.fontSize ?? 13,
            fontFamily: 'Recoleta',
            fontWeight: fontWeight ?? FontWeight.w200,
            color: isHovered ? hoveredColor : color,
            decoration: underline ? TextDecoration.underline : null,
          ),
        );
      }),
    );
  }
}

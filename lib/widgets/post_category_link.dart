import 'package:flutter/material.dart';
import 'package:flutter_press/widgets/hover_builder.dart';
import 'package:flutter_press/widgets/link_text.dart';

class PostCategoryLink extends StatelessWidget {
  final String text;
  final String description;
  const PostCategoryLink(
      {Key? key, required this.text, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(builder: (isHovering) {
      return Row(
        children: [
          LinkText(
            text,
            isHovered: isHovering,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w100,
              fontFamily: 'System',
            ),
          ),
        ],
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_press/widgets/hover_builder.dart';
import 'package:flutter_press/widgets/link_text.dart';

class PostCategoryLink extends StatelessWidget {
  final String text;
  final String description;
  final VoidCallback onTap;

  final bool isActive;
  const PostCategoryLink({
    Key? key,
    required this.text,
    required this.onTap,
    required this.description,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: HoverBuilder(builder: (isHovered) {
        return Row(
          children: [
            LinkText(
              text,
              isHovered: isHovered,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
              color: isActive ? Colors.white : Colors.blue,
              hoveredColor: Color(0xff9DCBFE),
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
      }),
    );
  }
}

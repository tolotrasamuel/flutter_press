import 'package:flutter/material.dart';
import 'package:flutter_press/widgets/hover_builder.dart';
import 'package:flutter_press/widgets/link_text.dart';

class Dropdown extends StatelessWidget {
  final List<String> items;
  const Dropdown({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 156,
      height: 28,
      child: HoverBuilder(builder: (hovering) {
        return IntrinsicWidth(
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(left: 12, top: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Color(0xff76797E)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
            value: items[0],
            items: items
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: LinkText(e, isHovered: hovering),
                    ))
                .toList(),
            onChanged: (value) {},
          ),
        );
      }),
    );
  }
}

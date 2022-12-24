import 'package:flutter/material.dart';
import 'package:flutter_press/widgets/hover_builder.dart';

class FlpOutlinedButton extends StatelessWidget {
  final String text;
  const FlpOutlinedButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(builder: (hovering) {
      return Container(
        height: 28,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            // backgroundColor: hovering ? Colors.blue : null,
            side: BorderSide(color: hovering ? Color(0xff9DCBFE) : Colors.blue),
          ),
          onPressed: () {},
          child: Text(text,
              style: TextStyle(
                fontSize: 13,
                color: hovering ? Color(0xff9DCBFE) : null,
              )),
        ),
      );
    });
  }
}

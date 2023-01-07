import 'package:flutter/material.dart';
import 'package:flutter_press/widgets/hover_builder.dart';

class FlpFilledButton extends StatelessWidget {
  final String text;
  EdgeInsets? padding;
  VoidCallback onPressed;
  final bool isLoading;
  final AxisDirection loaderPosition;
  FlpFilledButton({
    Key? key,
    required this.text,
    this.padding,
    required this.onPressed,
    this.loaderPosition = AxisDirection.up,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loaderSize = 20.0;
    final loaderOffsiteSize = loaderSize + 6;
    final map = {
      AxisDirection.up: Alignment.topCenter,
      AxisDirection.down: Alignment.bottomCenter,
      AxisDirection.left: Alignment.centerLeft,
      AxisDirection.right: Alignment.centerRight,
    };

    final offsetMap = {
      AxisDirection.up: Offset(0, -loaderOffsiteSize),
      AxisDirection.down: Offset(0, loaderOffsiteSize),
      AxisDirection.left: Offset(-loaderOffsiteSize, 0),
      AxisDirection.right: Offset(loaderOffsiteSize, 0),
    };
    final loaderAlign = map[loaderPosition]!;
    final loaderOffset = offsetMap[loaderPosition]!;
    return HoverBuilder(builder: (isHovering) {
      return Stack(
        children: [
          Container(
            child: ElevatedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: isLoading
                    ? null
                    : isHovering
                        ? Colors.blue.shade900
                        : null,
                // backgroundColor: hovering ? Colors.blue : null,
                disabledBackgroundColor: Colors.grey.shade900,
                side: BorderSide(
                  color: isLoading ? Colors.grey.shade800 : Colors.blue[200]!,
                ),
              ),
              onPressed: isLoading ? null : onPressed,
              child: Container(
                padding: padding,
                child: Container(
                  height: 28,
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Align(
                alignment: loaderAlign,
                child: Transform.translate(
                  offset: loaderOffset,
                  child: Container(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_press/services/navigator.dart';
import 'package:flutter_press/widgets/hover_builder.dart';

class NavigationItem extends StatefulWidget {
  final IconData icon;
  final String text;
  const NavigationItem({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  String get text => widget.text;
  IconData get icon => widget.icon;
  @override
  Widget build(BuildContext context) {
    return HoverBuilder(builder: (isHovered) {
      final isActive = text == NavigationService.instance.currentRouteItem.name;
      print(
          "currentRouteItem: ${NavigationService.instance.currentRouteItem.name} isActive: $isActive");
      final highlightColor = isActive
          ? null
          : isHovered
              ? Colors.blue
              : null;

      return InkWell(
        onTap: () {
          // contentKey.currentState!.pushReplacementNamed('/$text');
          setState(() {});
          NavigationService.instance.goTo(text);
          // final newRoute =
          //     ModalRoute.of(contentKey.currentContext!)!.settings.name;
          // print("newRoute: $newRoute");

          // Navigator.of(context).pushNamed('/$text');
        },
        child: Container(
          color: isActive
              ? Colors.blue
              : isHovered
                  ? Colors.black
                  : Colors.transparent,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // height: double.infinity,
                  width: 5,
                  color: highlightColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Icon(
                      icon,
                      color: highlightColor,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(color: highlightColor),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_press/services/navigator.dart';
import 'package:flutter_press/widgets/hover_builder.dart';

class NavigationItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final List<String> children;
  const NavigationItem({
    Key? key,
    required this.icon,
    required this.text,
    this.children = const [],
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
      final isOneChildActive = widget.children.any(
        (element) =>
            element == NavigationService.instance.currentRouteItem.name,
      );

      final isParentActive =
          text == NavigationService.instance.currentRouteItem.name ||
              isOneChildActive;

      return Column(
        children: [
          HoverBuilder(builder: (context) {
            final highlightColor = isParentActive
                ? null
                : isHovered
                    ? Colors.blue
                    : null;
            return InkWell(
              onTap: () {
                // contentKey.currentState!.pushReplacementNamed('/$text');
                final destination =
                    widget.children.isNotEmpty ? widget.children.first : text;
                NavigationService.instance.goTo(destination);
                setState(() {});

                // final newRoute =
                //     ModalRoute.of(contentKey.currentContext!)!.settings.name;
                // print("newRoute: $newRoute");

                // Navigator.of(context).pushNamed('/$text');
              },
              child: Container(
                color: isParentActive
                    ? Colors.blue
                    : isHovered
                        ? Colors.black
                        : Colors.transparent,
                child: IntrinsicHeight(
                  // don't delete this IntrinsicHeight, the blueBarLeftMarkerHovered will not show without it
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        key: Key("blueBarLeftMarkerHovered"),
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
          }),
          if (isParentActive && widget.children.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: widget.children
                    .map(
                      (childText) => HoverBuilder(builder: (isHovered) {
                        final isChildActive = childText ==
                            NavigationService.instance.currentRouteItem.name;
                        final leftBarIndicatorHoverColor =
                            isChildActive ? Colors.black : Colors.blue;
                        final highlightColor =
                            isHovered ? leftBarIndicatorHoverColor : null;

                        print(
                            "currentRouteItem: ${NavigationService.instance.currentRouteItem.name} isActive: $isChildActive");
                        return InkWell(
                          onTap: () {
                            NavigationService.instance.goTo(childText);
                            setState(() {});
                          },
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Container(
                                  width: 5,
                                  color: highlightColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    childText,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: isChildActive
                                          ? FontWeight.bold
                                          : FontWeight.w100,
                                      color:
                                          isChildActive ? null : highlightColor,
                                      height: 18 / 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                    .toList(),
              ),
            ),
        ],
      );
    });
  }
}

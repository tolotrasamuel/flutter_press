// library flutter_press;
//
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// class HoverBuilder extends StatefulWidget {
//   const HoverBuilder({
//     required this.builder,
//     Key? key,
//   }) : super(key: key);
//
//   final Widget Function(bool isHovered) builder;
//
//   @override
//   _HoverBuilderState createState() => _HoverBuilderState();
// }
//
// class _HoverBuilderState extends State<HoverBuilder> {
//   bool _isHovered = false;
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       onEnter: (PointerEnterEvent event) => _onHoverChanged(enabled: true),
//       onExit: (PointerExitEvent event) => _onHoverChanged(enabled: false),
//       child: widget.builder(_isHovered),
//     );
//   }
//
//   void _onHoverChanged({required bool enabled}) {
//     setState(() {
//       _isHovered = enabled;
//     });
//   }
// }
//
// class NavigationItem extends StatefulWidget {
//   final IconData icon;
//   final RouteObserver<PageRoute> routeObserver;
//   final String text;
//   final GlobalKey<NavigatorState> contentKey;
//   const NavigationItem({
//     Key? key,
//     required this.icon,
//     required this.text,
//     required this.contentKey,
//     required this.routeObserver,
//   }) : super(key: key);
//
//   @override
//   State<NavigationItem> createState() => _NavigationItemState();
// }
//
// class _NavigationItemState extends State<NavigationItem> with RouteAware {
//   GlobalKey<NavigatorState> get contentKey => widget.contentKey;
//   String get text => widget.text;
//   IconData get icon => widget.icon;
//   RouteObserver<PageRoute> get routeObserver => widget.routeObserver;
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     routeObserver.subscribe(
//         this, ModalRoute.of(contentKey.currentContext!) as PageRoute);
//   }
//
//   @override
//   void dispose() {
//     routeObserver.unsubscribe(this);
//     super.dispose();
//   }
//
//   @override
//   void didPush() {
//     final newRouteName =
//         ModalRoute.of(contentKey.currentContext!)?.settings.name;
//     print('didPush' + newRouteName!);
//     // Route was pushed onto navigator and is now topmost route.
//   }
//
//   @override
//   void didPopNext() {
//     // Covering route was popped off the navigator.
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return HoverBuilder(builder: (isHovered) {
//       final isActive =
//           ModalRoute.of(contentKey.currentContext!)!.settings.name == "/$text";
//       print(ModalRoute.of(context)!.settings.name);
//       final highlightColor = isActive
//           ? null
//           : isHovered
//               ? Colors.blue
//               : null;
//
//       return InkWell(
//         onTap: () {
//           contentKey.currentState!.pushReplacementNamed('/$text');
//           setState(() {});
//           final newRoute =
//               ModalRoute.of(contentKey.currentContext!)!.settings.name;
//           print("newRoute: $newRoute");
//
//           // Navigator.of(context).pushNamed('/$text');
//         },
//         child: Container(
//           color: isActive
//               ? Colors.blue
//               : isHovered
//                   ? Colors.black
//                   : Colors.transparent,
//           child: IntrinsicHeight(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   // height: double.infinity,
//                   width: 5,
//                   color: highlightColor,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     child: Icon(
//                       icon,
//                       color: highlightColor,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   text,
//                   style: TextStyle(color: highlightColor),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
//
// class AdminLayout extends StatefulWidget {
//   final Widget child;
//   final String title;
//   const AdminLayout({Key? key, required this.child, required this.title})
//       : super(key: key);
//
//   @override
//   State<AdminLayout> createState() => _AdminLayoutState();
// }
//
// class _AdminLayoutState extends State<AdminLayout> {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Container(
//             height: 32,
//           ),
//           // line
//           Container(
//             height: 1,
//             color: Colors.white,
//           ),
//           Expanded(
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Expanded(
//                   child: Container(
//                     child: Center(child: widget.child),
//                     color: Colors.black26,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class FlutterPressApp extends StatefulWidget {
//   const FlutterPressApp({Key? key}) : super(key: key);
//
//   @override
//   State<FlutterPressApp> createState() => _FlutterPressAppState();
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final GlobalKey<NavigatorState> _contentKey = GlobalKey<NavigatorState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Container(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     final currentRoot =
//                         ModalRoute.of(_contentKey.currentState!.context)!
//                             .settings
//                             .name;
//                     print("currentRoot: $currentRoot");
//                   },
//                   child:
//                       Text("What is the currrent root of other materialApp ?"),
//                 ),
//               ),
//               Expanded(
//                 child: MaterialApp(
//                   navigatorKey: _contentKey,
//                   title: 'Flutter Demo',
//                   theme: ThemeData(
//                     primarySwatch: Colors.blue,
//                   ),
//                   initialRoute: 'A',
//                   routes: {
//                     "A": (context) => Scaffold(
//                           body: Center(
//                             child: InkWell(
//                                 child: Text("Go to B"),
//                                 onTap: () {
//                                   Navigator.of(context).pushNamed("B");
//                                 }),
//                           ),
//                         ),
//                     "B": (context) => Scaffold(
//                           body: Center(
//                             child: InkWell(
//                                 child: Text("Go to A"),
//                                 onTap: () {
//                                   Navigator.of(context).pushNamed("A");
//                                 }),
//                           ),
//                         ),
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Global {
//   static GlobalKey<AdminNavigatorAppState> navKey = GlobalKey();
//   static GlobalKey postKey = GlobalKey();
//   static GlobalKey<NavigatorState> contentKey = GlobalKey<NavigatorState>();
//   static RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
// }
//
// class _FlutterPressAppState extends State<FlutterPressApp> {
//   GlobalKey<AdminNavigatorAppState> navKey = Global.navKey;
//   GlobalKey<NavigatorState> contentKey = Global.contentKey;
//   final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Press Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         //dark theme
//         brightness: Brightness.dark,
//       ),
//       routes: {
//         '/Admin': (context) => const AdminPost(),
//       },
//       home: Scaffold(
//         body: Stack(
//           // mainAxisSize: MainAxisSize.max,
//           // crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox.expand(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: kNavigationWidth),
//                 child: AdminApp(
//                   contentKey: contentKey,
//                   routeObserver: routeObserver,
//                   navKey: navKey,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: double.infinity,
//               width: kNavigationWidth,
//               child: AdminNavigatorApp(
//                 key: navKey,
//                 routeObserver: routeObserver,
//                 contentKey: contentKey,
//               ),
//             ),
//           ],
//         ),
//         // body: AdminLayoutCoordinator(
//         //   navigatorWidget: AdminNavigatorApp(),
//         //   content: AdminApp(),
//         // ),
//       ),
//     );
//   }
// }
//
// const kNavigationWidth = 272.0;
//
// class AdminApp extends StatefulWidget {
//   final GlobalKey<AdminNavigatorAppState> navKey;
//   final GlobalKey<NavigatorState> contentKey;
//   final RouteObserver<PageRoute<dynamic>> routeObserver;
//   const AdminApp(
//       {Key? key,
//       required this.navKey,
//       required this.contentKey,
//       required this.routeObserver})
//       : super(key: key);
//
//   @override
//   State<AdminApp> createState() => AdminAppState();
// }
//
// class AdminAppState extends State<AdminApp> with RouteAware {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     print("didChangeDependencies");
//     widget.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
//   }
//
//   @override
//   void dispose() {
//     widget.routeObserver.unsubscribe(this);
//     super.dispose();
//   }
//
//   @override
//   void didPush() {
//     final currentRouteName = ModalRoute.of(context)?.settings.name;
//     print('didPush in adminapp' + currentRouteName!);
//     // Route was pushed onto navigator and is now topmost route.
//   }
//
//   @override
//   void didPopNext() {
//     final currentRouteName = ModalRoute.of(context)?.settings.name;
//     print('didPopnext in adminapp' + currentRouteName!);
//     // Covering route was popped off the navigator.
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       key: Global.postKey,
//
//       navigatorKey: widget.contentKey,
//       debugShowCheckedModeBanner: false,
//       title: 'Admin App',
//       navigatorObservers: [widget.routeObserver],
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         //dark theme
//         brightness: Brightness.dark,
//       ),
//       routes: {
//         '/Post': (context) => AdminPost(),
//         '/Settings': (context) => AdminSettings(),
//       },
//       initialRoute: "/Post",
//       // home: Scaffold(
//       //   body: Center(
//       //     child: ElevatedButton(
//       //         onPressed: () {
//       //           navigateTo("Post");
//       //         },
//       //         child: Text("Do")),
//       //   ),
//       // ),
//     );
//   }
//
//   // void navigateTo(String text) {
//   //   final currentRoute = ModalRoute.of(context)!.settings.name;
//   //   print('currentRoute: $currentRoute');
//   //   Navigator.of(context).pushNamed('/$text');
//   //   widget.navKey.currentState!.setCurrentlySelected(text);
//   // }
// }
//
// class AdminLayoutCoordinator extends StatefulWidget {
//   final AdminNavigatorApp navigatorWidget;
//   final AdminApp content;
//   const AdminLayoutCoordinator({
//     Key? key,
//     required this.navigatorWidget,
//     required this.content,
//   }) : super(key: key);
//
//   @override
//   State<AdminLayoutCoordinator> createState() => _AdminLayoutCoordinatorState();
// }
//
// class _AdminLayoutCoordinatorState extends State<AdminLayoutCoordinator> {
//   GlobalKey<AdminNavigatorAppState> navKey = GlobalKey();
//   GlobalKey<AdminAppState> contentKey = GlobalKey();
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.max,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         widget.navigatorWidget,
//         Expanded(child: widget.content),
//       ],
//     );
//   }
// }
//
// class AdminNavigatorApp extends StatefulWidget {
//   final GlobalKey<NavigatorState> contentKey;
//
//   final RouteObserver<PageRoute> routeObserver;
//   AdminNavigatorApp(
//       {Key? key, required this.contentKey, required this.routeObserver})
//       : super(key: key);
//
//   @override
//   State<AdminNavigatorApp> createState() => AdminNavigatorAppState();
// }
//
// class AdminNavigatorAppState extends State<AdminNavigatorApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 32,
//           ),
//           // line
//           Container(
//             height: 1,
//             color: Colors.white,
//           ),
//           Expanded(
//             child: Container(
//               color: Colors.black,
//               child: Column(
//                 children: <Widget>[
//                   NavigationItem(
//                     routeObserver: widget.routeObserver,
//                     contentKey: widget.contentKey,
//                     icon: Icons.push_pin_outlined,
//                     text: 'Post',
//                   ),
//                   NavigationItem(
//                     routeObserver: widget.routeObserver,
//                     contentKey: widget.contentKey,
//                     icon: Icons.copy_all,
//                     text: 'Pages',
//                   ),
//                   NavigationItem(
//                     routeObserver: widget.routeObserver,
//                     contentKey: widget.contentKey,
//                     icon: Icons.settings,
//                     text: 'Settings',
//                   ),
//                   NavigationItem(
//                     routeObserver: widget.routeObserver,
//                     contentKey: widget.contentKey,
//                     icon: Icons.format_paint,
//                     text: 'Admin',
//                   ),
//                   NavigationItem(
//                     routeObserver: widget.routeObserver,
//                     contentKey: widget.contentKey,
//                     icon: Icons.arrow_circle_left,
//                     text: "Collapse menu",
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void setCurrentlySelected(String text) {}
// }
//
// class AdminSettings extends StatefulWidget {
//   const AdminSettings({Key? key}) : super(key: key);
//
//   @override
//   State<AdminSettings> createState() => AdminSettingsState();
// }
//
// class AdminSettingsState extends State<AdminSettings> {
//   @override
//   Widget build(BuildContext context) {
//     return AdminLayout(
//       title: 'Settings',
//       child: Text('Settings'),
//     );
//   }
// }
//
// class AdminPost extends StatefulWidget {
//   const AdminPost({Key? key}) : super(key: key);
//
//   @override
//   State<AdminPost> createState() => AdminPostState();
// }
//
// class AdminPostState extends State<AdminPost> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AdminLayout(
//       title: 'Post',
//       child: InkWell(
//         child: InkWell(
//           onTap: () {
//             final currentRoute = ModalRoute.of(context)!.settings.name;
//             print('currentRoute: $currentRoute');
//             final currentRouteByKey =
//                 ModalRoute.of(Global.navKey.currentState!.context)!
//                     .settings
//                     .name;
//             print('currentRouteByKey: $currentRouteByKey');
//             final currentRouteByPostKey =
//                 ModalRoute.of(Global.postKey.currentState!.context)!
//                     .settings
//                     .name;
//             print('currentRouteByPostKey: $currentRouteByPostKey');
//           },
//           child: Text('Post'),
//         ),
//         onTap: () {
//           Navigator.of(context).pushNamed('/Settings');
//         },
//       ),
//     );
//   }
// }

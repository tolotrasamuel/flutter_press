import 'package:flutter/material.dart';
import 'package:flutter_press/admin_layout.dart';

class AdminPost extends StatefulWidget {
  const AdminPost({Key? key}) : super(key: key);

  @override
  State<AdminPost> createState() => AdminPostState();
}

class AdminPostState extends State<AdminPost> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      child: Container(
        constraints: BoxConstraints(maxWidth: 1040),
        padding: const EdgeInsets.all(58),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Posts',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Recoleta',
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "Create, edit, and manage the posts on your site.",
                  style: TextStyle(
                    color: Color(0xff646970),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'System',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

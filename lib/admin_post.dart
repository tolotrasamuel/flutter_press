import 'package:flutter/material.dart';
import 'package:flutter_press/admin_layout.dart';
import 'package:flutter_press/widgets/dropdown.dart';
import 'package:flutter_press/widgets/hover_builder.dart';
import 'package:flutter_press/widgets/outlined_button.dart';
import 'package:flutter_press/widgets/post_category_link.dart';

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
      title: 'Post',
      child: Container(
        // constraints: BoxConstraints(maxWidth: 1040),
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Posts',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Recoleta',
                    fontWeight: FontWeight.w300,
                  ),
                ),
                //  Add new
                SizedBox(
                  width: 10,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: HoverBuilder(
                    builder: (hovering) {
                      return OutlinedButton(
                        // border blue, highlight blue, text blue
                        style: OutlinedButton.styleFrom(
                          backgroundColor: hovering ? Colors.blue : null,
                          side: BorderSide(color: Colors.blue),
                        ),
                        onPressed: () {},
                        child: Text('Add New',
                            style: TextStyle(
                              fontSize: 13,
                              color: hovering ? Colors.white : null,
                            )),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Row(
                  children: [
                    PostCategoryLink(
                      text: 'All',
                      description: "(2)",
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "|",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'System',
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    PostCategoryLink(
                      text: 'Published',
                      description: "(2)",
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "|",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'System',
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    PostCategoryLink(
                      text: 'Draft',
                      description: "(0)",
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Row(
                  children: [
                    // search post field and button
                    HoverBuilder(builder: (hovering) {
                      return Container(
                        width: 156,
                        height: 28,
                        color: Color(0xff121212),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                            fontSize: 13.0,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(left: 12, top: 0, bottom: 0),
                            suffixIcon: Icon(
                              Icons.close,
                              size: 16,
                              color:
                                  hovering ? Colors.white : Colors.transparent,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Color(0xff76797E)),
                            ),
                            hoverColor: Colors.blue,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      width: 4,
                    ),
                    FlpOutlinedButton(text: "Search Posts"),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              // bulk actions drow
              children: [
                Dropdown(items: ["Bulk Actions", "Edit", "Trash"]),
                SizedBox(
                  width: 4,
                ),
                FlpOutlinedButton(text: "Apply"),
                SizedBox(
                  width: 16,
                ),
                Dropdown(
                  items: ["All Dates", "December 2022", "February 2016"],
                ),
                SizedBox(
                  width: 4,
                ),
                Dropdown(
                  items: ["All Categories", "Uncategorized"],
                ),
                SizedBox(
                  width: 4,
                ),
                FlpOutlinedButton(text: "Filter"),
                Expanded(child: Container()),
                Text(
                  "2 items",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w200,
                    fontFamily: 'System',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            // table
            Container(
              width: double.infinity,
              color: Color(0xff121212),
              child: Column(
                children: [
                  // table header
                  Container(
                    height: 40,
                    color: Color(0xff1F1F1F),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          child: Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            "Title",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'System',
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            "Author",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'System',
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            "Categories",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'System',
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            "Tags",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'System',
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            "Comments",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'System',
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            "Date",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'System',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // table body
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 40,
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                child: Checkbox(
                                  value: false,
                                  onChanged: (value) {},
                                ),
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  "Post Title",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'System',
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  "Author",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'System',
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  "Categories",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'System',
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  "Tags",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'System',
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  "Comments",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'System',
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  "Date",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'System',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              // bulk actions drow
              children: [
                Dropdown(items: ["Bulk Actions", "Edit", "Trash"]),
                SizedBox(
                  width: 4,
                ),
                FlpOutlinedButton(text: "Apply"),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

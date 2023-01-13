import 'package:flutter/material.dart';
import 'package:flutter_press/admin_layout.dart';
import 'package:flutter_press/admin_post_new.dart';
import 'package:flutter_press/model/post.dart';
import 'package:flutter_press/services/api_service.dart';
import 'package:flutter_press/services/navigator.dart';
import 'package:flutter_press/widgets/dropdown.dart';
import 'package:flutter_press/widgets/hover_builder.dart';
import 'package:flutter_press/widgets/link_text.dart';
import 'package:flutter_press/widgets/outlined_button.dart';
import 'package:flutter_press/widgets/post_category_link.dart';

class AdminPostListController {
  late AdminPostListState view;

  List<Post> posts = [];

  void attach(AdminPostListState adminPostListState) {
    view = adminPostListState;
  }

  Future<void> init() async {
    final apiService = ApiService();

    final posts = await apiService.readPosts().catchError((e) {
      print('Error $e');
      showDialog(context: view.context, builder: (context) => Text('Error $e'));
    });
    this.posts = posts;
    view.applyState();
  }

  void onPostTap(Post post) {
    NavigationService.instance
        .goTo("Add New/${AdminPostNew.paramPostId}/${post.id}");
    // setState(() {});
  }
}

class AdminPostList extends StatefulWidget {
  const AdminPostList({Key? key}) : super(key: key);

  @override
  State<AdminPostList> createState() => AdminPostListState();
}

class AdminPostListState extends State<AdminPostList> {
  final controller = AdminPostListController();
  @override
  void initState() {
    super.initState();
    controller.attach(this);
    // add post frame

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      child: SingleChildScrollView(
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
                                color: hovering
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    BorderSide(color: Color(0xff76797E)),
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
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Color(0xff76797E)),
                ),
                child: LayoutBuilder(
                    builder: (context, BoxConstraints constraints) {
                  int datePercent = 15;
                  int authorPercent = 10;
                  double fixedWidth = 100;
                  double dateWidth = constraints.maxWidth * datePercent / 100;
                  double authorWidth =
                      constraints.maxWidth * authorPercent / 100;

                  return Column(
                    children: [
                      // table header
                      _buildHeader(
                        fixedWidth: fixedWidth,
                        dateWidth: dateWidth,
                        authorWidth: authorWidth,
                      ),
                      // table body
                      ...List<Widget>.generate(controller.posts.length,
                          (index) {
                        final post = controller.posts[index];
                        return Container(
                          color: index.isOdd ? null : Color(0xff1F1F1F),
                          child: Container(
                            // color: Colors.pink,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Container(
                                    // color: Colors.blue,
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 40,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (value) {},
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: Placeholder(),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 8),
                                                  child: InkWell(
                                                    onTap: () {
                                                      controller
                                                          .onPostTap(post);
                                                    },
                                                    child: LinkTextBlue(
                                                      post.title,
                                                      // style: TextStyle(
                                                      //   color: Colors.white,
                                                      //   fontSize: 13,
                                                      //   fontWeight: FontWeight.w200,
                                                      //   fontFamily: 'System',
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: authorWidth,
                                            child: Text(
                                              post.author,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w200,
                                                fontFamily: 'System',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: fixedWidth,
                                            child: Icon(
                                              Icons.stacked_bar_chart_outlined,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                          Container(
                                            width: fixedWidth,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.minimize,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              ],
                                            ),
                                          ),
                                          // rounded square with 0

                                          Container(
                                            width: fixedWidth,
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff787C81),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 6.0,
                                                          vertical: 4),
                                                      child: Text(
                                                        "0",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontFamily: 'System',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: dateWidth,
                                            child: Text(
                                              "Last Modified \n${post.updatedDateFormatted}",
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),

                      _buildHeader(
                        fixedWidth: fixedWidth,
                        dateWidth: dateWidth,
                        authorWidth: authorWidth,
                      ),
                    ],
                  );
                }),
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
            ],
          ),
        ),
      ),
    );
  }

  void applyState() {
    setState(() {});
  }

  Container _buildHeader({
    required double fixedWidth,
    required double dateWidth,
    required double authorWidth,
  }) {
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
          Expanded(
            flex: 1,
            child: Container(
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
          ),
          Container(
            width: authorWidth,
            child: Container(
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
          ),
          Container(
            width: fixedWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Stats",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w200,
                    fontFamily: 'System',
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: fixedWidth,
            child: Row(
              children: [
                Icon(
                  Icons.mode_comment_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),
          Container(
            width: fixedWidth,
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),
          Container(
            width: dateWidth,
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
  }
}

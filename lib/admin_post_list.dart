import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_press/admin_layout.dart';
import 'package:flutter_press/admin_post_new.dart';
import 'package:flutter_press/model/post.dart';
import 'package:flutter_press/model/post_count.dart';
import 'package:flutter_press/model/post_status.dart';
import 'package:flutter_press/model/post_status_payload.dart';
import 'package:flutter_press/services/api_service.dart';
import 'package:flutter_press/services/navigator.dart';
import 'package:flutter_press/view_model/action_row.dart';
import 'package:flutter_press/view_model/post_count_item.dart';
import 'package:flutter_press/widgets/dropdown.dart';
import 'package:flutter_press/widgets/hover_builder.dart';
import 'package:flutter_press/widgets/link_text.dart';
import 'package:flutter_press/widgets/outlined_button.dart';
import 'package:flutter_press/widgets/post_category_link.dart';

class AdminPostListController {
  late AdminPostListState view;
  PostCount postsCount = const PostCount();
  final apiService = ApiService();
  final postViewModels = [
    PostCountItem(
      text: "All",
      alwaysShow: true,
      status: null,
    ),
    PostCountItem(
      text: "Published",
      status: PostStatus.published,
    ),
    PostCountItem(
      text: "Scheduled",
      status: PostStatus.scheduled,
    ),
    PostCountItem(
      text: "Drafts",
      status: PostStatus.draft,
    ),
    PostCountItem(
      text: "Pending",
      status: PostStatus.pending,
    ),
    PostCountItem(
      text: "Private",
      status: PostStatus.private,
    ),
    PostCountItem(
      text: "Trash",
      status: PostStatus.trash,
    ),
    // scheduled
  ];

  List<Post> posts = [];

  PostStatus? postStatusFilter;

  void attach(AdminPostListState adminPostListState) {
    view = adminPostListState;
  }

  Future<void> postInit() async {
    readPostStatusFilter();
    fetchPostsCountAndStatus();
  }

  void onPostTap(Post post) {
    NavigationService.instance
        .goTo("Add New/${AdminPostNew.paramPostId}/${post.id}");
    // setState(() {});
  }

  Future<void> fetchPosts() async {
    final posts = await apiService
        .readAllPosts(postStatus: postStatusFilter)
        .catchError((e) {
      print('Error $e');
      showDialog(context: view.context, builder: (context) => Text('Error $e'));
    });
    this.posts = posts;
    view.applyState();
  }

  Future<void> fetchPostCounts() async {
    final postsCount = await apiService.fetchPostsCount().catchError((e) {
      print('Error $e');
      showDialog(context: view.context, builder: (context) => Text('Error $e'));
    });
    this.postsCount = postsCount;
    for (final postCountItem in postViewModels) {
      switch (postCountItem.status) {
        case PostStatus.published:
          postCountItem.count = postsCount.published;
          break;
        case PostStatus.scheduled:
          postCountItem.count = postsCount.scheduled;
          break;
        case PostStatus.draft:
          postCountItem.count = postsCount.draft;
          break;
        case PostStatus.pending:
          postCountItem.count = postsCount.pending;
          break;
        case PostStatus.private:
          postCountItem.count = postsCount.private;
          break;
        case PostStatus.trash:
          postCountItem.count = postsCount.trash;
          break;
        case null:
          postCountItem.count = postsCount.all;
          break;
      }
    }
    view.applyState();
  }

  void readPostStatusFilter() {
    final param = NavigationService.instance.currentRouteItem.queryParamMap;
    final postStatus = param[AdminPostList.postStatus];
    print("init postId: $postStatus");
    if (postStatus == null) {
      return;
    }
    this.postStatusFilter = PostStatus.values.asNameMap()[postStatus];
    view.applyState();
  }

  void init() {}

  void onPostCountTap(PostStatus? status) {
    this.postStatusFilter = status;
    view.applyState();
    fetchPosts();
  }

  void onEditTap(Post post) {}

  void onQuickEditTap(Post post) {}

  void onTrashTap(Post post) async {
    final payload = PostStatusPayload(
      id: post.id,
      status: PostStatus.trash,
    );
    await apiService.updatePostStatus(payload);
    fetchPostsCountAndStatus();
  }

  void onViewTap(Post post) {}

  void onCopy(Post post) {}

  void onPreviewTap(Post post) {}

  void onRestoreTap(Post post) async {
    final updateStatusPayload = PostStatusPayload(
      status: PostStatus.draft,
      id: post.id,
    );
    await apiService.updatePostStatus(updateStatusPayload).catchError((e) {
      print('Error $e');
      showDialog(context: view.context, builder: (context) => Text('Error $e'));
    });
    fetchPostsCountAndStatus();
  }

  Future<void> onDeletePermanentlyTap(Post post) async {
    await ApiService().deletePost(post.id).catchError((e) {
      print('Error $e');
      showDialog(context: view.context, builder: (context) => Text('Error $e'));
    });
    fetchPostsCountAndStatus();
  }

  void onAddNewTap() {
    NavigationService.instance.goTo("Add New");
  }

  void fetchPostsCountAndStatus() {
    fetchPosts();
    fetchPostCounts();
  }
}

class AdminPostList extends StatefulWidget {
  static const String postStatus = 'status';
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
    controller.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.postInit();
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
                          onPressed: () {
                            controller.onAddNewTap();
                          },
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
                    children: _buildAllPostsCount(),
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
                      if (controller.posts.isEmpty)
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Container(
                                // height: 100,
                                padding: EdgeInsets.all(12),
                                color: Color(0xff1F1F1F),
                                child: Text(
                                  "No posts found${_statusNoPostText()}.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'System',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                        vertical: 8.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: HoverBuilder(
                                                builder: (isHovered) {
                                              return Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: Placeholder(),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            LinkTextBlue(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              onTap: () {
                                                                controller
                                                                    .onPostTap(
                                                                        post);
                                                              },
                                                              post.title,
                                                              // style: TextStyle(
                                                              //   color: Colors.white,
                                                              //   fontSize: 13,
                                                              //   fontWeight: FontWeight.w200,
                                                              //   fontFamily: 'System',
                                                              // ),
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            if ([
                                                              PostStatus
                                                                  .scheduled,
                                                              null
                                                            ].contains(controller
                                                                .postStatusFilter) && post.status != PostStatus.published)
                                                              Text(
                                                                "— ${_getPostStatusInlineText(post)}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Recoleta',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xff50575e)),
                                                              ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        if (isHovered)
                                                          _buildRowAction(post),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
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
                                                        4,
                                                      ),
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
                        isBottom: true,
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

  List<Widget> _buildPostCount(PostCountItem postCountItem,
      [bool isLast = false]) {
    final text = postCountItem.text;
    final count = postCountItem.count;

    return [
      PostCategoryLink(
        text: text,
        isActive: controller.postStatusFilter == postCountItem.status,
        onTap: () {
          controller.onPostCountTap(postCountItem.status);
        },
        description: "($count)",
      ),
      if (!isLast) ...[
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
      ]
    ];
  }

  void applyState() {
    setState(() {});
  }

  Container _buildHeader({
    required double fixedWidth,
    required double dateWidth,
    required double authorWidth,
    bool isBottom = false,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: (!isBottom)
              ? BorderSide(
                  color: Color(0xff76797E),
                )
              : BorderSide.none,
          top: (isBottom)
              ? BorderSide(
                  color: Color(0xff76797E),
                )
              : BorderSide.none,
        ),
      ),
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

  List<Widget> _buildAllPostsCount() {
    final postsMap = <String, int>{};
    final postViewModels = controller.postViewModels;
    List<Widget> list = [];

    final postCountsShowing =
        postViewModels.where((e) => e.count > 0 || e.alwaysShow).toList();
    for (int i = 0; i < postCountsShowing.length; i++) {
      final item = postCountsShowing[i];
      if (!item.alwaysShow && item.count == 0) {
        continue;
      }
      postsMap[item.text] = item.count;
      final isLast = i == postCountsShowing.length - 1;
      list.addAll(_buildPostCount(item, isLast));
    }
    return list;
  }

  Widget _buildRowAction(Post post) {
    final copy = RowAction(
      text: "Copy",
      onTap: () {
        controller.onCopy(post);
      },
    );
    final view = RowAction(
      text: "View",
      onTap: () {
        controller.onViewTap(post);
      },
    );
    final preview = RowAction(
      text: "Preview",
      onTap: () {
        controller.onPreviewTap(post);
      },
    );
    final actions = [
      RowAction(
        text: "Edit",
        onTap: () {
          controller.onEditTap(post);
        },
      ),
      RowAction(
        text: "Quick Edit",
        onTap: () {
          controller.onQuickEditTap(post);
        },
      ),
      copy,
      RowAction(
        text: "Trash",
        isDestructive: true,
        onTap: () {
          controller.onTrashTap(post);
        },
      ),
    ];
    if ([
      PostStatus.published,
      PostStatus.private,
    ].contains(post.status)) {
      actions.add(view);
    }
    if ([
      PostStatus.draft,
      PostStatus.scheduled,
      PostStatus.pending,
    ].contains(post.status)) {
      actions.add(preview);
    }

    if (post.status == PostStatus.trash) {
      actions.clear();
      actions.add(copy);
      actions.add(RowAction(
        text: "Restore",
        onTap: () {
          controller.onRestoreTap(post);
        },
      ));
      actions.add(RowAction(
        text: "Delete Permanently",
        isDestructive: true,
        onTap: () {
          controller.onDeletePermanentlyTap(post);
        },
      ));
    }
    final List<Widget> list = [];
    for (int i = 0; i < actions.length; i++) {
      final action = actions[i];
      final isLast = i == actions.length - 1;
      final List<Widget> children = [
        if (!action.isDestructive)
          LinkTextBlue(
            action.text,
            onTap: action.onTap,
          ),
        if (action.isDestructive)
          LinkTextRed(
            action.text,
            underline: false,
            fontWeight: FontWeight.w400,
            onTap: action.onTap,
          ),
        if (!isLast) ...[
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
          SizedBox(width: 4),
        ]
      ];
      list.addAll(children);
    }
    return Wrap(
      children: list,
    );
  }

  String _statusNoPostText() {
    final status = controller.postStatusFilter;
    final postViewModel = controller.postViewModels
        .firstWhereOrNull((element) => element.status == status);
    if (postViewModel == null || status == null) {
      return "";
    }
    return " in ${postViewModel.text}";
  }

  String _getPostStatusInlineText(Post post) {
    final postViewModel = controller.postViewModels
        .firstWhereOrNull((element) => element.status == post.status);
    if (postViewModel == null) {
      // This should never happen
      return "";
    }
    return postViewModel.text;
  }
}

class ActionRowWidget extends StatelessWidget {
  const ActionRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

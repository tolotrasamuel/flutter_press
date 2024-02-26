import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_press/admin_layout.dart';
import 'package:flutter_press/model/new_post_payload.dart';
import 'package:flutter_press/model/post.dart';
import 'package:flutter_press/model/post_status.dart';
import 'package:flutter_press/model/post_status_payload.dart';
import 'package:flutter_press/services/api_service.dart';
import 'package:flutter_press/services/navigator.dart';
import 'package:flutter_press/widgets/filled_button.dart';
import 'package:flutter_press/widgets/link_text.dart';
import 'package:flutter_press/widgets/outlined_button.dart';
import 'package:flutter_press/widgets/publish_list_item.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AdminPostNewController {
  late AdminPostNewState view;
  QuillController editorController = QuillController.basic();
  final ApiService apiService = ApiService();

  final titleController = TextEditingController();

  bool isLoading = false;

  Post? post;

  bool get isEditing => post != null;

  void attach(AdminPostNewState adminPostNewState) {
    view = adminPostNewState;
  }

  void postInit() {
    final param = NavigationService.instance.currentRouteItem.queryParamMap;
    final postId = param[AdminPostNew.paramPostId];
    print("init postId: $postId");
    if (postId == null) {
      return;
    }
    loadPost(postId);
  }

  Future<void> onPublish() async {
    print("${editorController.document.toDelta()}");
    final newPost = NewPostPayload(
      title: titleController.text,
      content: json.encode(editorController.document.toDelta().toJson()),
      status: PostStatus.published,
    );
    isLoading = true;
    view.applyState();
    late Post postSaved;
    final post = this.post;
    if (post == null) {
      postSaved = await apiService.savePost(newPost).catchError((error) {
        print(error);
        throw error;
      });
    } else {
      final editedPost = post.copyWith(
        title: newPost.title,
        content: newPost.content,
      );
      postSaved = await apiService.editPost(editedPost).catchError((error) {
        print(error);
        throw error;
      });
    }
    this.post = postSaved;
    isLoading = false;
    view.applyState();
  }

  Future<void> loadPost(String postId) async {
    final post = await ApiService().readPost(postId);
    print(post);
    this.post = post;
    titleController.text = post.title;
    editorController = QuillController(
      document: Document.fromJson(json.decode(post.content)),
      selection: TextSelection.collapsed(offset: 0),
    );
    view.applyState();
  }

  Future<void> moveToTrash() async {
    print("moveToTrash tapped");
    final post = this.post;
    if (post == null) {
      return;
    }
    final updateStatusPayload = PostStatusPayload(
      status: PostStatus.trash,
      id: post.id,
    );
    await ApiService().updatePostStatus(updateStatusPayload);
    NavigationService.instance.goTo("All Posts");
  }
}

class AdminPostNew extends StatefulWidget {
  static const String paramPostId = 'post';
  const AdminPostNew({Key? key}) : super(key: key);

  @override
  State<AdminPostNew> createState() => AdminPostNewState();
}

class AdminPostNewState extends State<AdminPostNew> {
  final controller = AdminPostNewController();
  @override
  void initState() {
    super.initState();
    controller.attach(this);

    //  post frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.postInit();
    });
  }

  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          // constraints: BoxConstraints(maxWidth: 1040),
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    controller.post == null ? 'Add New Post' : 'Edit Post',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Recoleta',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.black,
                          child: TextField(
                            controller: controller.titleController,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w300),
                            decoration: InputDecoration(
                              fillColor: Colors.black,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              border: OutlineInputBorder(),
                              hintText: 'Title',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Text(
                              "Permalink:",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "https://flutterpress.com/",
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                // underline: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          // constraints: BoxConstraints(maxHeight: 600),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Quill toolbar
                              Container(
                                // SingleChildScrollView(
                                // scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                                  child: QuillSimpleToolbar(
                                    configurations: QuillSimpleToolbarConfigurations(
                                      controller: controller.editorController,
                                      multiRowsDisplay: true,
                                      toolbarIconAlignment: WrapAlignment.start,
                                      showIndent: true,
                                      showAlignmentButtons: true,
                                      sharedConfigurations: const QuillSharedConfigurations(

                                      ),
                                    ),

                                  ),
                                ),
                              ),

                              // Quill editor
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MouseRegion(
                                    cursor: SystemMouseCursors.text,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(
                                          color: Colors.grey.shade700,
                                        ),
                                        // borderRadius: BorderRadius.vertical(
                                        //   top: Radius.circular(4.0),
                                        // ),
                                      ),
                                      child: QuillEditor.basic(
                                        configurations: QuillEditorConfigurations(
                                          controller: controller.editorController,
                                          readOnly: false,
                                          scrollable: false,
                                          // focusNode: FocusNode(),
                                          autoFocus: true,
                                          // readOnly: false,
                                          minHeight: 300,

                                          scrollBottomInset: 64,
                                          expands: false,
                                          padding: EdgeInsets.all(24),
                                          keyboardAppearance: Brightness.light,
                                          onImagePaste: _onImagePaste,
                                          embedBuilders: [
                                            // ...FlutterQuillEmbeds.builders(),
                                          ],
                                          customStyles: DefaultStyles(
                                            link: TextStyle()
                                                .copyWith(color: Colors.blue),
                                            // paragraph: DefaultTextBlockStyle(
                                            //   // const TextStyle(),
                                            //   // const Tuple2(8, 16),
                                            //   // const Tuple2(0, 0),
                                            //   // null,
                                            // ),
                                          ),
                                          sharedConfigurations: const QuillSharedConfigurations(
                                            locale: Locale('de'),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      // borderRadius: BorderRadius.vertical(
                                      //   bottom: Radius.circular(4.0),
                                      // ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Word count: 0',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w100,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Draft saved at 12:53:41 am. Last edited by youngafricanetwork on January 6, 2023 at 10:53 pm',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w100,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    width: 280,
                    decoration: BoxDecoration(
                      // color: Colors.black,
                      // borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Publish',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            // borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              color: Colors.black,
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FlpOutlinedButton(text: "Save Draft"),
                                      FlpOutlinedButton(text: "Preview"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  PublishListItem(
                                    title: "Status",
                                    description: "Draft",
                                    action: "Edit",
                                    icon: Icons.key,
                                  ),
                                  PublishListItem(
                                    title: "Visibility",
                                    description: "Public",
                                    action: "Edit",
                                    icon: Icons.visibility,
                                  ),
                                  PublishListItem(
                                    title: "Revisions",
                                    description: "4",
                                    action: "Browse",
                                    icon: Icons.history,
                                  ),
                                  PublishListItem(
                                    title: "Publish",
                                    description: "Immediately",
                                    action: "Edit",
                                    icon: Icons.calendar_month,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        controller.isEditing
                                            ? LinkTextRed(
                                                "Move to Trash",
                                                onTap: controller.moveToTrash,
                                              )
                                            : SizedBox(
                                                height: 32,
                                              ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FlpFilledButton(
                                        onPressed: controller.onPublish,
                                        isLoading: controller.isLoading,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 2,
                                        ),
                                        text: controller.post == null
                                            ? 'Publish'
                                            : 'Update',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _onImagePaste(Uint8List imageBytes) async {
    // Saves the image to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final file = await File(
            '${appDocDir.path}/${basename('${DateTime.now().millisecondsSinceEpoch}.png')}')
        .writeAsBytes(imageBytes, flush: true);
    return file.path.toString();
  }

  void applyState() {
    setState(() {});
  }
}

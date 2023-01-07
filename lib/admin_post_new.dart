import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_press/admin_layout.dart';
import 'package:flutter_press/widgets/filled_button.dart';
import 'package:flutter_press/widgets/outlined_button.dart';
import 'package:flutter_press/widgets/publish_list_item.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tuple/tuple.dart';

class AdminPostNew extends StatefulWidget {
  const AdminPostNew({Key? key}) : super(key: key);

  @override
  State<AdminPostNew> createState() => AdminPostNewState();
}

class AdminPostNewState extends State<AdminPostNew> {
  @override
  void initState() {
    super.initState();
  }

  QuillController _controller = QuillController.basic();
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
                    'Add New Post',
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
                                  child: QuillToolbar.basic(
                                    toolbarIconAlignment: WrapAlignment.start,
                                    multiRowsDisplay: true,
                                    showIndent: true,
                                    controller: _controller,
                                    showAlignmentButtons: true,
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
                                      child: QuillEditor(
                                        controller: _controller,
                                        scrollController: scrollController,
                                        scrollable: false,
                                        focusNode: FocusNode(),
                                        autoFocus: true,
                                        readOnly: false,
                                        minHeight: 300,

                                        scrollBottomInset: 64,
                                        expands: false,
                                        padding: EdgeInsets.all(24),
                                        keyboardAppearance: Brightness.light,
                                        locale: null,
                                        onImagePaste: _onImagePaste,
                                        embedBuilders: [
                                          ...FlutterQuillEmbeds.builders(),
                                        ],
                                        customStyles: DefaultStyles(
                                          link: TextStyle()
                                              .copyWith(color: Colors.blue),
                                          paragraph: DefaultTextBlockStyle(
                                            const TextStyle(),
                                            const Tuple2(8, 16),
                                            const Tuple2(0, 0),
                                            null,
                                          ),
                                        ),
                                        // customStyles:
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
                                        Text(
                                          "Move to Trash",
                                          style: TextStyle(
                                            color: Colors.red[400],
                                            fontSize: 13,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FlpFilledButton(
                                        onPressed: () {},
                                        isLoading: false,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 2,
                                        ),
                                        text: 'Publish',
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
}

//json_serializable
import 'package:flutter_press/model/post_status.dart';
import 'package:flutter_press/utils/extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const Post._();
  const factory Post({
    @JsonKey() required String id,
    @JsonKey() required String title,
    @JsonKey() required String content,
    @JsonKey() required PostStatus status,
    @JsonKey() required String createdDate,
    @JsonKey() required String updatedDate,
    @JsonKey() required String publishedDate,
    @JsonKey() required String author,
  }) = _Post;
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  String? get updatedDateFormatted => updatedDate.toDate?.formatted;
}

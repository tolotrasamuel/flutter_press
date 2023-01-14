//json_serializable
import 'package:flutter_press/model/post_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'posts_read_payload.freezed.dart';
part 'posts_read_payload.g.dart';

@freezed
class PostsReadPayload with _$PostsReadPayload {
  const PostsReadPayload._();
  const factory PostsReadPayload({
    @JsonKey() PostStatus? status,
  }) = _PostsReadPayload;
  factory PostsReadPayload.fromJson(Map<String, dynamic> json) =>
      _$PostsReadPayloadFromJson(json);
}

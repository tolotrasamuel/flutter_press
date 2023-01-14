//json_serializable
import 'package:flutter_press/model/post_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_status_payload.freezed.dart';
part 'post_status_payload.g.dart';

@freezed
class PostStatusPayload with _$PostStatusPayload {
  const PostStatusPayload._();
  const factory PostStatusPayload({
    @JsonKey() required String id,
    @JsonKey() required PostStatus status,
  }) = _PostStatusPayload;
  factory PostStatusPayload.fromJson(Map<String, dynamic> json) =>
      _$PostStatusPayloadFromJson(json);
}

//json_serializable
import 'package:flutter_press/model/post_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_post_payload.freezed.dart';
part 'new_post_payload.g.dart';

@freezed
class NewPostPayload with _$NewPostPayload {
  const NewPostPayload._();
  const factory NewPostPayload({
    @JsonKey() required String title,
    @JsonKey() required String content,
    @JsonKey() required PostStatus status,
  }) = _NewPostPayload;
  factory NewPostPayload.fromJson(Map<String, dynamic> json) =>
      _$NewPostPayloadFromJson(json);
}

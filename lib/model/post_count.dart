//json_serializable
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_count.freezed.dart';
part 'post_count.g.dart';

@freezed
class PostCount with _$PostCount {
  const PostCount._();
  const factory PostCount({
    @JsonKey() @Default(0) int draft,
    @JsonKey() @Default(0) int published,
    @JsonKey() @Default(0) int private,
    @JsonKey() @Default(0) int pending,
    @JsonKey() @Default(0) int scheduled,
    @JsonKey() @Default(0) int trash,
  }) = _PostCount;
  factory PostCount.fromJson(Map<String, dynamic> json) =>
      _$PostCountFromJson(json);

  int get all => draft + published + private + pending + scheduled;
}

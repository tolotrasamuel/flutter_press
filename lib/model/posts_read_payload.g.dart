// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_read_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostsReadPayload _$$_PostsReadPayloadFromJson(Map json) =>
    _$_PostsReadPayload(
      status: $enumDecodeNullable(_$PostStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$_PostsReadPayloadToJson(_$_PostsReadPayload instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', _$PostStatusEnumMap[instance.status]);
  return val;
}

const _$PostStatusEnumMap = {
  PostStatus.published: 'published',
  PostStatus.scheduled: 'scheduled',
  PostStatus.draft: 'draft',
  PostStatus.pending: 'pending',
  PostStatus.private: 'private',
  PostStatus.trash: 'trash',
};

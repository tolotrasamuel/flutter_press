// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_post_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NewPostPayload _$$_NewPostPayloadFromJson(Map json) => _$_NewPostPayload(
      title: json['title'] as String,
      content: json['content'] as String,
      status: $enumDecode(_$PostStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$_NewPostPayloadToJson(_$_NewPostPayload instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'status': _$PostStatusEnumMap[instance.status]!,
    };

const _$PostStatusEnumMap = {
  PostStatus.draft: 'draft',
  PostStatus.pending: 'pending',
  PostStatus.private: 'private',
  PostStatus.publish: 'publish',
};

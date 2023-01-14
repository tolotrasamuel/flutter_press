// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_status_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostStatusPayload _$$_PostStatusPayloadFromJson(Map json) =>
    _$_PostStatusPayload(
      id: json['id'] as String,
      status: $enumDecode(_$PostStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$_PostStatusPayloadToJson(
        _$_PostStatusPayload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$PostStatusEnumMap[instance.status]!,
    };

const _$PostStatusEnumMap = {
  PostStatus.published: 'published',
  PostStatus.scheduled: 'scheduled',
  PostStatus.draft: 'draft',
  PostStatus.pending: 'pending',
  PostStatus.private: 'private',
  PostStatus.trash: 'trash',
};

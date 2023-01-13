// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map json) => _$_Post(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      status: $enumDecode(_$PostStatusEnumMap, json['status']),
      createdDate: json['createdDate'] as String,
      updatedDate: json['updatedDate'] as String,
      publishedDate: json['publishedDate'] as String,
      author: json['author'] as String,
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'status': _$PostStatusEnumMap[instance.status]!,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
      'publishedDate': instance.publishedDate,
      'author': instance.author,
    };

const _$PostStatusEnumMap = {
  PostStatus.draft: 'draft',
  PostStatus.pending: 'pending',
  PostStatus.private: 'private',
  PostStatus.publish: 'publish',
};

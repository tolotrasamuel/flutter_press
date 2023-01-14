// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostCount _$$_PostCountFromJson(Map json) => _$_PostCount(
      draft: json['draft'] as int? ?? 0,
      published: json['published'] as int? ?? 0,
      private: json['private'] as int? ?? 0,
      pending: json['pending'] as int? ?? 0,
      scheduled: json['scheduled'] as int? ?? 0,
      trash: json['trash'] as int? ?? 0,
    );

Map<String, dynamic> _$$_PostCountToJson(_$_PostCount instance) =>
    <String, dynamic>{
      'draft': instance.draft,
      'published': instance.published,
      'private': instance.private,
      'pending': instance.pending,
      'scheduled': instance.scheduled,
      'trash': instance.trash,
    };

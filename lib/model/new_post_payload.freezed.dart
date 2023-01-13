// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_post_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NewPostPayload _$NewPostPayloadFromJson(Map<String, dynamic> json) {
  return _NewPostPayload.fromJson(json);
}

/// @nodoc
mixin _$NewPostPayload {
  @JsonKey()
  String get title => throw _privateConstructorUsedError;
  @JsonKey()
  String get content => throw _privateConstructorUsedError;
  @JsonKey()
  PostStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewPostPayloadCopyWith<NewPostPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewPostPayloadCopyWith<$Res> {
  factory $NewPostPayloadCopyWith(
          NewPostPayload value, $Res Function(NewPostPayload) then) =
      _$NewPostPayloadCopyWithImpl<$Res, NewPostPayload>;
  @useResult
  $Res call(
      {@JsonKey() String title,
      @JsonKey() String content,
      @JsonKey() PostStatus status});
}

/// @nodoc
class _$NewPostPayloadCopyWithImpl<$Res, $Val extends NewPostPayload>
    implements $NewPostPayloadCopyWith<$Res> {
  _$NewPostPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PostStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewPostPayloadCopyWith<$Res>
    implements $NewPostPayloadCopyWith<$Res> {
  factory _$$_NewPostPayloadCopyWith(
          _$_NewPostPayload value, $Res Function(_$_NewPostPayload) then) =
      __$$_NewPostPayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey() String title,
      @JsonKey() String content,
      @JsonKey() PostStatus status});
}

/// @nodoc
class __$$_NewPostPayloadCopyWithImpl<$Res>
    extends _$NewPostPayloadCopyWithImpl<$Res, _$_NewPostPayload>
    implements _$$_NewPostPayloadCopyWith<$Res> {
  __$$_NewPostPayloadCopyWithImpl(
      _$_NewPostPayload _value, $Res Function(_$_NewPostPayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? status = null,
  }) {
    return _then(_$_NewPostPayload(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PostStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NewPostPayload extends _NewPostPayload {
  const _$_NewPostPayload(
      {@JsonKey() required this.title,
      @JsonKey() required this.content,
      @JsonKey() required this.status})
      : super._();

  factory _$_NewPostPayload.fromJson(Map<String, dynamic> json) =>
      _$$_NewPostPayloadFromJson(json);

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey()
  final PostStatus status;

  @override
  String toString() {
    return 'NewPostPayload(title: $title, content: $content, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewPostPayload &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, content, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewPostPayloadCopyWith<_$_NewPostPayload> get copyWith =>
      __$$_NewPostPayloadCopyWithImpl<_$_NewPostPayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NewPostPayloadToJson(
      this,
    );
  }
}

abstract class _NewPostPayload extends NewPostPayload {
  const factory _NewPostPayload(
      {@JsonKey() required final String title,
      @JsonKey() required final String content,
      @JsonKey() required final PostStatus status}) = _$_NewPostPayload;
  const _NewPostPayload._() : super._();

  factory _NewPostPayload.fromJson(Map<String, dynamic> json) =
      _$_NewPostPayload.fromJson;

  @override
  @JsonKey()
  String get title;
  @override
  @JsonKey()
  String get content;
  @override
  @JsonKey()
  PostStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_NewPostPayloadCopyWith<_$_NewPostPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

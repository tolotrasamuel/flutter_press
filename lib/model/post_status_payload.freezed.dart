// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_status_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostStatusPayload _$PostStatusPayloadFromJson(Map<String, dynamic> json) {
  return _PostStatusPayload.fromJson(json);
}

/// @nodoc
mixin _$PostStatusPayload {
  @JsonKey()
  String get id => throw _privateConstructorUsedError;
  @JsonKey()
  PostStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostStatusPayloadCopyWith<PostStatusPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostStatusPayloadCopyWith<$Res> {
  factory $PostStatusPayloadCopyWith(
          PostStatusPayload value, $Res Function(PostStatusPayload) then) =
      _$PostStatusPayloadCopyWithImpl<$Res, PostStatusPayload>;
  @useResult
  $Res call({@JsonKey() String id, @JsonKey() PostStatus status});
}

/// @nodoc
class _$PostStatusPayloadCopyWithImpl<$Res, $Val extends PostStatusPayload>
    implements $PostStatusPayloadCopyWith<$Res> {
  _$PostStatusPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PostStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostStatusPayloadCopyWith<$Res>
    implements $PostStatusPayloadCopyWith<$Res> {
  factory _$$_PostStatusPayloadCopyWith(_$_PostStatusPayload value,
          $Res Function(_$_PostStatusPayload) then) =
      __$$_PostStatusPayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey() String id, @JsonKey() PostStatus status});
}

/// @nodoc
class __$$_PostStatusPayloadCopyWithImpl<$Res>
    extends _$PostStatusPayloadCopyWithImpl<$Res, _$_PostStatusPayload>
    implements _$$_PostStatusPayloadCopyWith<$Res> {
  __$$_PostStatusPayloadCopyWithImpl(
      _$_PostStatusPayload _value, $Res Function(_$_PostStatusPayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
  }) {
    return _then(_$_PostStatusPayload(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
class _$_PostStatusPayload extends _PostStatusPayload {
  const _$_PostStatusPayload(
      {@JsonKey() required this.id, @JsonKey() required this.status})
      : super._();

  factory _$_PostStatusPayload.fromJson(Map<String, dynamic> json) =>
      _$$_PostStatusPayloadFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final PostStatus status;

  @override
  String toString() {
    return 'PostStatusPayload(id: $id, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostStatusPayload &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostStatusPayloadCopyWith<_$_PostStatusPayload> get copyWith =>
      __$$_PostStatusPayloadCopyWithImpl<_$_PostStatusPayload>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostStatusPayloadToJson(
      this,
    );
  }
}

abstract class _PostStatusPayload extends PostStatusPayload {
  const factory _PostStatusPayload(
      {@JsonKey() required final String id,
      @JsonKey() required final PostStatus status}) = _$_PostStatusPayload;
  const _PostStatusPayload._() : super._();

  factory _PostStatusPayload.fromJson(Map<String, dynamic> json) =
      _$_PostStatusPayload.fromJson;

  @override
  @JsonKey()
  String get id;
  @override
  @JsonKey()
  PostStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_PostStatusPayloadCopyWith<_$_PostStatusPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

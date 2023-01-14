// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_count.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostCount _$PostCountFromJson(Map<String, dynamic> json) {
  return _PostCount.fromJson(json);
}

/// @nodoc
mixin _$PostCount {
  @JsonKey()
  int get draft => throw _privateConstructorUsedError;
  @JsonKey()
  int get published => throw _privateConstructorUsedError;
  @JsonKey()
  int get private => throw _privateConstructorUsedError;
  @JsonKey()
  int get pending => throw _privateConstructorUsedError;
  @JsonKey()
  int get scheduled => throw _privateConstructorUsedError;
  @JsonKey()
  int get trash => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCountCopyWith<PostCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCountCopyWith<$Res> {
  factory $PostCountCopyWith(PostCount value, $Res Function(PostCount) then) =
      _$PostCountCopyWithImpl<$Res, PostCount>;
  @useResult
  $Res call(
      {@JsonKey() int draft,
      @JsonKey() int published,
      @JsonKey() int private,
      @JsonKey() int pending,
      @JsonKey() int scheduled,
      @JsonKey() int trash});
}

/// @nodoc
class _$PostCountCopyWithImpl<$Res, $Val extends PostCount>
    implements $PostCountCopyWith<$Res> {
  _$PostCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? published = null,
    Object? private = null,
    Object? pending = null,
    Object? scheduled = null,
    Object? trash = null,
  }) {
    return _then(_value.copyWith(
      draft: null == draft
          ? _value.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as int,
      published: null == published
          ? _value.published
          : published // ignore: cast_nullable_to_non_nullable
              as int,
      private: null == private
          ? _value.private
          : private // ignore: cast_nullable_to_non_nullable
              as int,
      pending: null == pending
          ? _value.pending
          : pending // ignore: cast_nullable_to_non_nullable
              as int,
      scheduled: null == scheduled
          ? _value.scheduled
          : scheduled // ignore: cast_nullable_to_non_nullable
              as int,
      trash: null == trash
          ? _value.trash
          : trash // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostCountCopyWith<$Res> implements $PostCountCopyWith<$Res> {
  factory _$$_PostCountCopyWith(
          _$_PostCount value, $Res Function(_$_PostCount) then) =
      __$$_PostCountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey() int draft,
      @JsonKey() int published,
      @JsonKey() int private,
      @JsonKey() int pending,
      @JsonKey() int scheduled,
      @JsonKey() int trash});
}

/// @nodoc
class __$$_PostCountCopyWithImpl<$Res>
    extends _$PostCountCopyWithImpl<$Res, _$_PostCount>
    implements _$$_PostCountCopyWith<$Res> {
  __$$_PostCountCopyWithImpl(
      _$_PostCount _value, $Res Function(_$_PostCount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? published = null,
    Object? private = null,
    Object? pending = null,
    Object? scheduled = null,
    Object? trash = null,
  }) {
    return _then(_$_PostCount(
      draft: null == draft
          ? _value.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as int,
      published: null == published
          ? _value.published
          : published // ignore: cast_nullable_to_non_nullable
              as int,
      private: null == private
          ? _value.private
          : private // ignore: cast_nullable_to_non_nullable
              as int,
      pending: null == pending
          ? _value.pending
          : pending // ignore: cast_nullable_to_non_nullable
              as int,
      scheduled: null == scheduled
          ? _value.scheduled
          : scheduled // ignore: cast_nullable_to_non_nullable
              as int,
      trash: null == trash
          ? _value.trash
          : trash // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostCount extends _PostCount {
  const _$_PostCount(
      {@JsonKey() this.draft = 0,
      @JsonKey() this.published = 0,
      @JsonKey() this.private = 0,
      @JsonKey() this.pending = 0,
      @JsonKey() this.scheduled = 0,
      @JsonKey() this.trash = 0})
      : super._();

  factory _$_PostCount.fromJson(Map<String, dynamic> json) =>
      _$$_PostCountFromJson(json);

  @override
  @JsonKey()
  final int draft;
  @override
  @JsonKey()
  final int published;
  @override
  @JsonKey()
  final int private;
  @override
  @JsonKey()
  final int pending;
  @override
  @JsonKey()
  final int scheduled;
  @override
  @JsonKey()
  final int trash;

  @override
  String toString() {
    return 'PostCount(draft: $draft, published: $published, private: $private, pending: $pending, scheduled: $scheduled, trash: $trash)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostCount &&
            (identical(other.draft, draft) || other.draft == draft) &&
            (identical(other.published, published) ||
                other.published == published) &&
            (identical(other.private, private) || other.private == private) &&
            (identical(other.pending, pending) || other.pending == pending) &&
            (identical(other.scheduled, scheduled) ||
                other.scheduled == scheduled) &&
            (identical(other.trash, trash) || other.trash == trash));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, draft, published, private, pending, scheduled, trash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostCountCopyWith<_$_PostCount> get copyWith =>
      __$$_PostCountCopyWithImpl<_$_PostCount>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostCountToJson(
      this,
    );
  }
}

abstract class _PostCount extends PostCount {
  const factory _PostCount(
      {@JsonKey() final int draft,
      @JsonKey() final int published,
      @JsonKey() final int private,
      @JsonKey() final int pending,
      @JsonKey() final int scheduled,
      @JsonKey() final int trash}) = _$_PostCount;
  const _PostCount._() : super._();

  factory _PostCount.fromJson(Map<String, dynamic> json) =
      _$_PostCount.fromJson;

  @override
  @JsonKey()
  int get draft;
  @override
  @JsonKey()
  int get published;
  @override
  @JsonKey()
  int get private;
  @override
  @JsonKey()
  int get pending;
  @override
  @JsonKey()
  int get scheduled;
  @override
  @JsonKey()
  int get trash;
  @override
  @JsonKey(ignore: true)
  _$$_PostCountCopyWith<_$_PostCount> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guide_title.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GuideTitle {
  String get title => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GuideTitleCopyWith<GuideTitle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuideTitleCopyWith<$Res> {
  factory $GuideTitleCopyWith(
          GuideTitle value, $Res Function(GuideTitle) then) =
      _$GuideTitleCopyWithImpl<$Res, GuideTitle>;
  @useResult
  $Res call({String title, String desc});
}

/// @nodoc
class _$GuideTitleCopyWithImpl<$Res, $Val extends GuideTitle>
    implements $GuideTitleCopyWith<$Res> {
  _$GuideTitleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? desc = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GuideTitleImplCopyWith<$Res>
    implements $GuideTitleCopyWith<$Res> {
  factory _$$GuideTitleImplCopyWith(
          _$GuideTitleImpl value, $Res Function(_$GuideTitleImpl) then) =
      __$$GuideTitleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String desc});
}

/// @nodoc
class __$$GuideTitleImplCopyWithImpl<$Res>
    extends _$GuideTitleCopyWithImpl<$Res, _$GuideTitleImpl>
    implements _$$GuideTitleImplCopyWith<$Res> {
  __$$GuideTitleImplCopyWithImpl(
      _$GuideTitleImpl _value, $Res Function(_$GuideTitleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? desc = null,
  }) {
    return _then(_$GuideTitleImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GuideTitleImpl implements _GuideTitle {
  _$GuideTitleImpl({this.title = '', this.desc = ''});

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String desc;

  @override
  String toString() {
    return 'GuideTitle(title: $title, desc: $desc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuideTitleImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GuideTitleImplCopyWith<_$GuideTitleImpl> get copyWith =>
      __$$GuideTitleImplCopyWithImpl<_$GuideTitleImpl>(this, _$identity);
}

abstract class _GuideTitle implements GuideTitle {
  factory _GuideTitle({final String title, final String desc}) =
      _$GuideTitleImpl;

  @override
  String get title;
  @override
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$GuideTitleImplCopyWith<_$GuideTitleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

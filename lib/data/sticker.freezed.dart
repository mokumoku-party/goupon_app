// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sticker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Sticker {
  String get title => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StickerCopyWith<Sticker> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StickerCopyWith<$Res> {
  factory $StickerCopyWith(Sticker value, $Res Function(Sticker) then) =
      _$StickerCopyWithImpl<$Res, Sticker>;
  @useResult
  $Res call({String title, String desc, String url});
}

/// @nodoc
class _$StickerCopyWithImpl<$Res, $Val extends Sticker>
    implements $StickerCopyWith<$Res> {
  _$StickerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? desc = null,
    Object? url = null,
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
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StickerImplCopyWith<$Res> implements $StickerCopyWith<$Res> {
  factory _$$StickerImplCopyWith(
          _$StickerImpl value, $Res Function(_$StickerImpl) then) =
      __$$StickerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String desc, String url});
}

/// @nodoc
class __$$StickerImplCopyWithImpl<$Res>
    extends _$StickerCopyWithImpl<$Res, _$StickerImpl>
    implements _$$StickerImplCopyWith<$Res> {
  __$$StickerImplCopyWithImpl(
      _$StickerImpl _value, $Res Function(_$StickerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? desc = null,
    Object? url = null,
  }) {
    return _then(_$StickerImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StickerImpl implements _Sticker {
  _$StickerImpl({this.title = '', this.desc = '', this.url = ''});

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String desc;
  @override
  @JsonKey()
  final String url;

  @override
  String toString() {
    return 'Sticker(title: $title, desc: $desc, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StickerImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, desc, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StickerImplCopyWith<_$StickerImpl> get copyWith =>
      __$$StickerImplCopyWithImpl<_$StickerImpl>(this, _$identity);
}

abstract class _Sticker implements Sticker {
  factory _Sticker({final String title, final String desc, final String url}) =
      _$StickerImpl;

  @override
  String get title;
  @override
  String get desc;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$StickerImplCopyWith<_$StickerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

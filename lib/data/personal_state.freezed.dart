// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PersonalState {
  UserType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get uuid => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<int> get stickers => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PersonalStateCopyWith<PersonalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalStateCopyWith<$Res> {
  factory $PersonalStateCopyWith(
          PersonalState value, $Res Function(PersonalState) then) =
      _$PersonalStateCopyWithImpl<$Res, PersonalState>;
  @useResult
  $Res call(
      {UserType type,
      String name,
      String uuid,
      double latitude,
      double longitude,
      String? nickname,
      String? description,
      List<int> stickers});
}

/// @nodoc
class _$PersonalStateCopyWithImpl<$Res, $Val extends PersonalState>
    implements $PersonalStateCopyWith<$Res> {
  _$PersonalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? name = null,
    Object? uuid = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? nickname = freezed,
    Object? description = freezed,
    Object? stickers = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      stickers: null == stickers
          ? _value.stickers
          : stickers // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonalStateImplCopyWith<$Res>
    implements $PersonalStateCopyWith<$Res> {
  factory _$$PersonalStateImplCopyWith(
          _$PersonalStateImpl value, $Res Function(_$PersonalStateImpl) then) =
      __$$PersonalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserType type,
      String name,
      String uuid,
      double latitude,
      double longitude,
      String? nickname,
      String? description,
      List<int> stickers});
}

/// @nodoc
class __$$PersonalStateImplCopyWithImpl<$Res>
    extends _$PersonalStateCopyWithImpl<$Res, _$PersonalStateImpl>
    implements _$$PersonalStateImplCopyWith<$Res> {
  __$$PersonalStateImplCopyWithImpl(
      _$PersonalStateImpl _value, $Res Function(_$PersonalStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? name = null,
    Object? uuid = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? nickname = freezed,
    Object? description = freezed,
    Object? stickers = null,
  }) {
    return _then(_$PersonalStateImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      stickers: null == stickers
          ? _value._stickers
          : stickers // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$PersonalStateImpl extends _PersonalState {
  _$PersonalStateImpl(
      {this.type = UserType.none,
      this.name = '',
      this.uuid = '',
      this.latitude = 0.0,
      this.longitude = 0.0,
      this.nickname,
      this.description,
      final List<int> stickers = const []})
      : _stickers = stickers,
        super._();

  @override
  @JsonKey()
  final UserType type;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String uuid;
  @override
  @JsonKey()
  final double latitude;
  @override
  @JsonKey()
  final double longitude;
  @override
  final String? nickname;
  @override
  final String? description;
  final List<int> _stickers;
  @override
  @JsonKey()
  List<int> get stickers {
    if (_stickers is EqualUnmodifiableListView) return _stickers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stickers);
  }

  @override
  String toString() {
    return 'PersonalState(type: $type, name: $name, uuid: $uuid, latitude: $latitude, longitude: $longitude, nickname: $nickname, description: $description, stickers: $stickers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalStateImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._stickers, _stickers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      name,
      uuid,
      latitude,
      longitude,
      nickname,
      description,
      const DeepCollectionEquality().hash(_stickers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalStateImplCopyWith<_$PersonalStateImpl> get copyWith =>
      __$$PersonalStateImplCopyWithImpl<_$PersonalStateImpl>(this, _$identity);
}

abstract class _PersonalState extends PersonalState {
  factory _PersonalState(
      {final UserType type,
      final String name,
      final String uuid,
      final double latitude,
      final double longitude,
      final String? nickname,
      final String? description,
      final List<int> stickers}) = _$PersonalStateImpl;
  _PersonalState._() : super._();

  @override
  UserType get type;
  @override
  String get name;
  @override
  String get uuid;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String? get nickname;
  @override
  String? get description;
  @override
  List<int> get stickers;
  @override
  @JsonKey(ignore: true)
  _$$PersonalStateImplCopyWith<_$PersonalStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

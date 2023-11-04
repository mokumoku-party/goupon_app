import 'dart:core';

import 'package:app/data/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_state.freezed.dart';

@freezed
class PersonalState with _$PersonalState {
  factory PersonalState({
    @Default(UserType.none) UserType type,
    @Default('') String name,
    @Default('') String uuid,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
    String? nickname,
    String? description,
    @Default([]) List<int> stickers,
    @Default(false) bool isLoading,
  }) = _PersonalState;

  PersonalState._();

  bool get isLoggedIn => !type.isNone && name.isNotEmpty && uuid.isNotEmpty;
}

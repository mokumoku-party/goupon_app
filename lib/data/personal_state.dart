import 'package:app/data/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_state.freezed.dart';

@freezed
class PersonalState with _$PersonalState {
  factory PersonalState({
    @Default(UserType.none) UserType type,
    @Default('') String name,
    @Default('') String uuid,
  }) = _PersonalState;

  PersonalState._();

  bool get isLoggedIn => !type.isNone && name.isNotEmpty && uuid.isNotEmpty;
}

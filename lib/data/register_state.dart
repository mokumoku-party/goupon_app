import 'dart:typed_data';

import 'package:app/data/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  factory RegisterState({
    @Default(UserType.none) UserType type,
    @Default('') String name,
    XFile? iconPath,
  }) = _RegisterState;
}

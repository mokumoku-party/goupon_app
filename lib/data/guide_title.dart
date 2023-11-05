import 'dart:typed_data';

import 'package:app/data/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'guide_title.freezed.dart';

@freezed
class GuideTitle with _$GuideTitle {
  factory GuideTitle({
    @Default('') String title,
    @Default('') String desc,
  }) = _GuideTitle;
}

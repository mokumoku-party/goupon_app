import 'package:freezed_annotation/freezed_annotation.dart';

part 'sticker.freezed.dart';

@freezed
class Sticker with _$Sticker {
  factory Sticker({
    @Default('') String title,
    @Default('') String desc,
    @Default('') String url,
  }) = _Sticker;
}

import 'package:flutter/foundation.dart';

enum UserType {
  guide,
  traveller,
  none;

  bool get isGuide => this == UserType.guide;
  bool get isTraveller => this == UserType.traveller;
  bool get isNone => this == UserType.none;

  @override
  String toString() => describeEnum(this);
}

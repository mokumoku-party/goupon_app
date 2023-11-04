import 'package:flutter/foundation.dart';

enum UserType {
  guide,
  traveller,
  none;

  bool get isGuide => this == UserType.guide;
  bool get isNone => this == UserType.none;
  bool get isTraveller => this == UserType.traveller;

  UserType toggle() =>
      switch (this) { guide => traveller, traveller => guide, _ => none };

  @override
  String toString() => describeEnum(this);
}

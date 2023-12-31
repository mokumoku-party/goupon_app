import 'package:app/data/user_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final typeProvider = NotifierProvider<TypeNotifer, UserType>(TypeNotifer.new);

class TypeNotifer extends Notifier<UserType> {
  @override
  UserType build() {
    return UserType.none;
  }

  void setType(UserType type) {
    state = type;
  }

  void toggle() {
    // noneなら何もしない
    if (state == UserType.none) return;

    if (state == UserType.guide) {
      state = UserType.traveller;
    } else {
      state = UserType.guide;
    }
  }
}

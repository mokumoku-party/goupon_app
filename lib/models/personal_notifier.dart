import 'package:app/data/personal_state.dart';
import 'package:app/data/user_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final personalProvider =
    NotifierProvider<PersonalNotifier, PersonalState>(PersonalNotifier.new);

class PersonalNotifier extends Notifier<PersonalState> {
  @override
  PersonalState build() {
    init();
    return PersonalState();
  }

  Future init() async {
    final pref = await SharedPreferences.getInstance();
    final name = pref.getString('name') ?? '';
    final type = pref.getString('type') ?? '';
    final uuid = pref.getString('uuid') ?? '';

    state = state.copyWith(
      name: name,
      type: type.isEmpty ? UserType.none : UserType.values.byName(type),
      uuid: uuid,
    );
  }
}

import 'package:app/data/personal_state.dart';
import 'package:app/data/user_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final personalProvider =
    NotifierProvider<PersonalNotifier, PersonalState>(PersonalNotifier.new);

class PersonalNotifier extends Notifier<PersonalState> {
  final client = Supabase.instance.client;
  @override
  PersonalState build() {
    fetch();
    return PersonalState();
  }

  Future<void> fetch() async {
    final pref = await SharedPreferences.getInstance();
    final localUuid = pref.getString('uuid');

    final uuid = (state.uuid.isEmpty) ? localUuid : state.uuid;
    final result = (await client.from('users').select().match({"uuid": uuid}));

    final user = List<Map<String, dynamic>>.from(result).first;

    state = state.copyWith(
      uuid: uuid!,
      name: user['name'],
      type: UserType.values.byName(user['type']),
    );
  }

  void toggle() async {
    await client.from('users').update({'type': state.type.toggle().name}).match(
      {'uuid': state.uuid},
    );

    print('${state.type}, ${state.uuid}');
    fetch();
  }
}

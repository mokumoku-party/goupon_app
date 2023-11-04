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
    return PersonalState(isLoading: true);
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
      isLoading: false,
    );
  }

  Future<List<Map<String, dynamic>>> getGuides() async {
    final client = Supabase.instance.client;

    final results = await client
        .from('users')
        .select()
        .not('latitude', 'is', null)
        .match({'type': UserType.guide});

    ref.read(personalProvider.notifier).build();
    print(results);
    return List<Map<String, dynamic>>.from(results);
  }

  Future<List<Map<String, dynamic>>> getTraveler() async {
    final client = Supabase.instance.client;

    final pref = await SharedPreferences.getInstance();

    final uuid = pref.get('uuid');

    final results = await client
        .from('users')
        .select()
        .not('traveler_uuid', 'is', null)
        .match({'type': UserType.guide, 'uuid': uuid});

    ref.read(personalProvider.notifier).build();
    print(results);
    return List<Map<String, dynamic>>.from(results);
  }

  Future<void> setGuide(String guideUuid) async {
    final client = Supabase.instance.client;

    final pref = await SharedPreferences.getInstance();

    final uuid = pref.get('uuid');

    await client.from('users').update({
      'traveler_uuid': uuid,
    }).match({
      'uuid': guideUuid,
    });

    ref.read(personalProvider.notifier).build();
  }

  Future<void> setLocation(double latitude, double longitude) async {
    final client = Supabase.instance.client;

    final pref = await SharedPreferences.getInstance();

    final uuid = pref.get('uuid');

    await client.from('users').update({
      'latitude': latitude,
      'longitude': longitude,
    }).match({'uuid': uuid});

    ref.read(personalProvider.notifier).build();
  }

  void toggle() async {
    await client.from('users').update({'type': state.type.toggle().name}).match(
      {'uuid': state.uuid},
    );

    print('${state.type}, ${state.uuid}');
    fetch();
  }
}

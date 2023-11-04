import 'package:app/data/register_state.dart';
import 'package:app/data/user_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

final registerNotifier =
    NotifierProvider<RegisterNotifier, RegisterState>(RegisterNotifier.new);

class RegisterNotifier extends Notifier<RegisterState> {
  @override
  RegisterState build() {
    return RegisterState();
  }

  void setType(UserType type) {
    state = state.copyWith(type: type);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  Future<void> insert() async {
    final client = Supabase.instance.client;

    final uuid = const Uuid().v4();
    await client.from('users').insert(
      {
        'name': state.name,
        'type': state.type.toString(),
        'uuid': uuid,
      },
    );
  }
}

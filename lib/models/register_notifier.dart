import 'package:app/data/register_state.dart';
import 'package:app/data/user_type.dart';
import 'package:app/models/personal_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  void setIcon(XFile file) {
    state = state.copyWith(iconPath: file);
  }

  Future<void> insert() async {
    final client = Supabase.instance.client;
    final uuid = const Uuid().v4();

    String iconUrl = '';
    if (state.iconPath != null) {
      final fileType = state.iconPath!.name.split('.').last;
      print(fileType);
      await client.storage.from('goupon-development').uploadBinary(
            'icon-$uuid.$fileType',
            await state.iconPath!.readAsBytes(),
          );

      iconUrl = client.storage
          .from('goupon-development')
          .getPublicUrl('icon-$uuid.$fileType');
    }

    await client.from('users').insert(
      {
        'name': state.name,
        'type': state.type.toString(),
        'uuid': uuid,
        'profile_img_url': iconUrl,
      },
    );

    final pref = await SharedPreferences.getInstance();
    await pref.setString('name', state.name);
    await pref.setString('type', state.type.toString());
    await pref.setString('uuid', uuid);

    ref.read(personalProvider.notifier).build();
  }
}

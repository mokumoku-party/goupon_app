import 'package:app/data/sticker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final stickerNotifier =
    NotifierProvider<StickerNotifier, List<Sticker>>(StickerNotifier.new);

class StickerNotifier extends Notifier<List<Sticker>> {
  @override
  List<Sticker> build() {
    return [];
  }

  Future<void> fetch() async {
    final client = Supabase.instance.client;

    final resp = await client.from('sticker').select(
          'name, discription, sticker_img_url',
        );
    final stickers = (resp as List<dynamic>).map((e) {
      final v = e as Map<String, dynamic>;
      return Sticker(
        title: v['name'],
        desc: v['discription'],
        url: v['sticker_img_url'],
      );
    }).toList();

    state = [...stickers];
  }
}

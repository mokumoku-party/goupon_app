import 'package:app/data/guide_title.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final guideTitleNotifier =
    NotifierProvider<GuideTitleNotifier, List<GuideTitle>>(
        GuideTitleNotifier.new);

class GuideTitleNotifier extends Notifier<List<GuideTitle>> {
  @override
  List<GuideTitle> build() {
    return [];
  }

  Future<void> fetch() async {
    final client = Supabase.instance.client;

    final resp = await client.from('guide_title').select('name, discription');
    final titles = (resp as List<dynamic>).map((e) {
      final v = e as Map<String, dynamic>;
      return GuideTitle(title: v['name'], desc: v['discription']);
    }).toList();

    state = [...titles];
  }
}

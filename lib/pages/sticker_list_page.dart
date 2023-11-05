import 'package:app/app.dart';
import 'package:app/models/sticker_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StickerListPage extends HookConsumerWidget {
  const StickerListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stickers = ref.watch(stickerNotifier);

    useEffect(() {
      Future.microtask(() async {
        await ref.read(stickerNotifier.notifier).fetch();
      });
    }, const []);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'ぐーぽんっ！',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'シール一覧 (仮)',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            sliver: SliverList.builder(
              itemBuilder: (context, index) {
                final sticker = stickers[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      top: const BorderSide(color: surfaceBorderColor),
                      bottom: index == stickers.length - 1
                          ? const BorderSide(color: surfaceBorderColor)
                          : BorderSide.none,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.network(sticker.url, width: 80),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sticker.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              sticker.desc,
                              style: const TextStyle(
                                fontSize: 14,
                                color: subTextColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: stickers.length,
            ),
          ),
        ],
      ),
    );
  }
}

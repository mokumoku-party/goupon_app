import 'package:app/app.dart';
import 'package:app/models/guide_title_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GuideTitleListPage extends HookConsumerWidget {
  const GuideTitleListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titles = ref.watch(guideTitleNotifier);

    useEffect(() {
      Future.microtask(() async {
        await ref.read(guideTitleNotifier.notifier).fetch();
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
                '称号一覧 (仮)',
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
                final title = titles[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      top: const BorderSide(color: surfaceBorderColor),
                      bottom: index == titles.length - 1
                          ? const BorderSide(color: surfaceBorderColor)
                          : BorderSide.none,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title.desc,
                        style: const TextStyle(
                          fontSize: 14,
                          color: subTextColor,
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: titles.length,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:app/app.dart';
import 'package:app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GuidePage extends HookConsumerWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        title: const Text(
          '案内人を探す',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 32, bottom: 16),
                child: Row(
                  children: [
                    Icon(Icons.person),
                    Text('近くにいる案内人'),
                  ],
                ),
              ),
            ),
            ...List.generate(
              10,
              (index) => SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _ProfileCard(
                    onTap: () {
                      ref.read(appRouterProvider).go('/map');
                    },
                    medals: const ["a", "a", "a", "a", "a", "a"],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// プロフィールカード
class _ProfileCard extends HookConsumerWidget {
  final List<String> medals;
  final VoidCallback? onTap;

  const _ProfileCard({required this.medals, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/imgs/kani.png'),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: medals
                        .map((medal) =>
                            SvgPicture.asset('assets/icons/medal.svg'))
                        .toList(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'ユーザー名最大１０字',
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'ふたつ名は最大１５文字ですよ！',
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'ユーザーのプロフィール文とかあったほうがいいと思ったんです。2行くらい。あああああああああああああ',
                      style: TextStyle(
                        fontSize: 12,
                        color: subTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

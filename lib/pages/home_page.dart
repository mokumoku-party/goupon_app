// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/app.dart';
import 'package:app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final isGuideProvider = StateProvider((ref) => false);

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: GestureDetector(
          onTap: () async {
            final pref = await SharedPreferences.getInstance();
            await pref.clear();

            const snackBar = SnackBar(
              content: Text("ユーザー情報を削除しました"),
            );
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: const Text(
            'ぐーぽんっ！',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        actions: [_ToggleButton()],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: GestureDetector(
                  onTap: () {
                    ref.read(appRouterProvider).go('/contact');
                  },
                  child: _ProfileCard()),
            ),
          ),
          SliverToBoxAdapter(
            child: _Title(
              icon: SvgPicture.asset('assets/icons/crown.svg', width: 32),
              text: Row(
                children: [
                  const SizedBox(width: 8),
                  Text('案内ランキング'),
                  const SizedBox(width: 8),
                  Text(
                    'N',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('位'),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _ListItem(
                date: '2023年12月32日',
                desc: '履歴は最大3件表示',
              ),
              _ListItem(
                date: '2023年10月01日',
                desc: '夜ご飯食べた✨',
              ),
              _ListItem(
                date: '2023年08月32日',
                desc: '人類社会のすべての構成員の固有の尊厳と平等で譲ることのできない権利とを承認することは、',
                isLast: true,
              ),
            ]),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 24),
            sliver: SliverToBoxAdapter(
              child: _Title(
                icon: SvgPicture.asset('assets/icons/medal.svg', width: 32),
                text: Row(
                  children: [
                    const SizedBox(width: 8),
                    Text('称号'),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _ListItem(
                date: '2023年12月32日',
                desc: '大田区の賢者',
              ),
              _ListItem(
                date: '2023年10月01日',
                desc: 'ベテラン大田区案内人',
              ),
              _ListItem(
                date: '2023年08月32日',
                desc: 'かけだし大田区案内人',
                isLast: true,
              ),
            ]),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 24, bottom: 8),
            sliver: SliverToBoxAdapter(
              child: _Title(
                icon: SvgPicture.asset('assets/icons/star.svg', width: 32),
                text: Row(
                  children: [
                    const SizedBox(width: 8),
                    Text('シール'),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 84 + 16,
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/imgs/kani.png',
                          width: 84,
                          height: 84,
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          child: Text(
                            '大田区名物のかに',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 編集するボタン
class _EditButton extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100,
      height: 20,
      padding: EdgeInsets.zero,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: subSubColor,
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit, size: 10, color: Colors.white),
            Text(
              '編集する',
              style: TextStyle(fontSize: 8, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListItem extends HookConsumerWidget {
  final String date;
  final String desc;
  final bool isLast;

  const _ListItem({
    required this.date,
    required this.desc,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTextStyle(
      style: TextStyle(color: subTextColor, fontSize: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: surfaceBorderColor),
              bottom: isLast
                  ? BorderSide(color: surfaceBorderColor)
                  : BorderSide.none,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16.0),
              Text(date),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  desc,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// プロフィールカード
class _ProfileCard extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/imgs/kani.png'),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/medal.svg', width: 32),
                    SvgPicture.asset('assets/icons/medal.svg', width: 32),
                    SvgPicture.asset('assets/icons/medal.svg', width: 32),
                    SvgPicture.asset('assets/icons/medal.svg', width: 32),
                    SvgPicture.asset('assets/icons/medal.svg', width: 32),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'ユーザー名最大１０字',
                  style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ふたつ名は最大１５文字ですよ！',
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ユーザーのプロフィール文とかあったほうがいいと思ったんです。2行くらい。',
                  style: TextStyle(
                    fontSize: 12,
                    color: subSubColor,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.topRight,
                  child: _EditButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends HookConsumerWidget {
  final Widget icon;
  final Widget text;

  const _Title({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DefaultTextStyle(
        style: TextStyle(color: textColor, fontSize: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [icon, text],
        ),
      ),
    );
  }
}

class _ToggleButton extends HookConsumerWidget {
  const _ToggleButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGuide = ref.watch(isGuideProvider);

    return GestureDetector(
      onTap: () {
        ref.read(isGuideProvider.notifier).update((state) => !state);
      },
      child: Container(
        width: 88,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isGuide ? primaryColor : subSubColor),
              width: 20,
              height: 20,
              child: Center(
                child: Text(
                  '案',
                  style: TextStyle(color: Colors.white, height: 1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/icon-double-sided arrow.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(subSubColor, BlendMode.srcIn),
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isGuide ? subSubColor : primaryColor),
              width: 20,
              height: 20,
              child: Center(
                child: Text(
                  '旅',
                  style: TextStyle(color: Colors.white, height: 1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

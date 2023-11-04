// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:app/app.dart';
import 'package:app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GuideHomePage extends HookConsumerWidget {
  const GuideHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canGoupon = useState(true);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'Let\'s Trip!!',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: [
                  Text(
                    '＼ 私が案内します！ ／',
                    style: TextStyle(fontSize: 16, color: subTextColor),
                  ),
                  const SizedBox(height: 8),
                  _ProfileCard(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _Title(
              icon: SvgPicture.asset(
                'assets/icons/icon-thumbs-up.svg',
                width: 32,
                colorFilter: ColorFilter.mode(
                  Color(0xff4b4b4b),
                  BlendMode.srcIn,
                ),
              ),
              text: Row(
                children: [
                  const SizedBox(width: 8),
                  Text('ぐーぽんっ！した場所'),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _ListItem(
                date: '09時',
                desc: '羽田空港',
              ),
              _ListItem(
                date: '10時',
                desc: 'PiO PARK',
              ),
              _ListItem(
                date: '12時',
                desc: 'ニイハオ',
                isLast: true,
              ),
            ]),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 24, bottom: 8),
            sliver: SliverToBoxAdapter(
              child: _Title(
                icon: SvgPicture.asset('assets/icons/ticket.svg', width: 32),
                text: Row(
                  children: [
                    const SizedBox(width: 8),
                    Text('獲得クーポン'),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 84 + 30 + 16,
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
          SliverPadding(
            padding: EdgeInsets.only(top: 24, bottom: 8),
            sliver: SliverToBoxAdapter(
              child: _Title(
                icon: SvgPicture.asset('assets/icons/star.svg', width: 32),
                text: Row(
                  children: [
                    const SizedBox(width: 8),
                    Text('獲得シール'),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 84 + 16 + 30,
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
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
        child: Container(
          height: 56,
          color: backgroundColor,
          child: ElevatedButton(
            onPressed: () {
              if (!canGoupon.value) return;

              ref.read(appRouterProvider).go('/guide_home/contact');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  !canGoupon.value ? backgroundColor : primaryColor,
              surfaceTintColor: Colors.transparent,
              shape: const StadiumBorder(
                side: BorderSide(color: primaryColor, width: 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/icon-thumbs-up-outlined.svg',
                  width: 40,
                ),
                const SizedBox(width: 8),
                Text(
                  'ぐーぽんっ！する！',
                  style: TextStyle(
                    fontSize: 16,
                    color: !canGoupon.value ? primaryColor : Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                SvgPicture.asset(
                  'assets/icons/icon-thumbs-up-outlined-reverse.svg',
                  width: 40,
                ),
              ],
            ),
          ),
        ),
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
              const SizedBox(width: 32),
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

import 'dart:convert';
import 'dart:math';

import 'package:app/app.dart';
import 'package:app/models/personal_notifier.dart';
import 'package:app/routes/app_router.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final completeGoupon = StateProvider.autoDispose((ref) => false);

final stickers =
    StateProvider<List<(String name, String desc, String url)>>((ref) => []);

var _gouponNumber = -1;

class ResultPage extends HookConsumerWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController();
    final animation = ColorTween(begin: Colors.grey, end: Colors.white)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(controller);

    useEffect(() {
      Future.microtask(() async {
        final client = Supabase.instance.client;

        final res = await client.from('sticker').select();
        final data = List<Map<String, dynamic>>.from(res);

        ref.read(stickers.notifier).state = data
            .map((e) => (
                  e['name'] as String,
                  e['discription'] as String,
                  e['sticker_img_url'] as String
                ))
            .toList();

        _gouponNumber = Random().nextInt(data.length);

        final uuid = ref.read(personalProvider).uuid;
        final idRes = await client.from('users').select().match({'uuid': uuid});
        final idData = List<Map<String, dynamic>>.from(idRes).first['stickers'];
        final currentList =
            const JsonDecoder().convert(idData ?? '[]') as List<dynamic>;
        currentList.add(_gouponNumber.toString());

        final nextList = const JsonEncoder().convert(currentList);

        await client
            .from('users')
            .update({'stickers': nextList.toString()}).match({'uuid': uuid});
      });

      return null;
    });

    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.arrow_back_ios),
        title: const Text(
          'ぐーぽんっ！結果',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Container(
              color: animation.value,
              child: ref.watch(completeGoupon)
                  ? const _ResultSeel()
                  : _Goupon(controller),
            );
          },
        ),
      ),
    );
  }
}

class _Goupon extends HookConsumerWidget {
  final AnimationController controller;

  const _Goupon(this.controller);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
        child: DotLottieLoader.fromAsset(
      "assets/imgs/goupon.lottie",
      frameBuilder: (ctx, dotlottie) {
        if (dotlottie != null) {
          return Lottie.memory(
            dotlottie.animations.values.single,
            controller: controller,
            onLoaded: (composition) {
              controller
                ..duration = composition.duration
                ..forward().whenComplete(() {
                  ref.read(completeGoupon.notifier).state = true;
                });
            },
          );
        } else {
          return Container();
        }
      },
    ));
  }
}

class _ResultCoupon extends HookConsumerWidget {
  const _ResultCoupon();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          const Text('🎉🎉 当たり 🎉🎉'),
          const Text('クーポンゲット！'),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
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
                const Column(
                  children: [
                    Text('【クーポンの名前】'),
                    Text('使える店名'),
                    Text('有効期限'),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7E7E7E),
              foregroundColor: Colors.white,
              elevation: 0,
              side: const BorderSide(
                color: Color(0xFF7E7E7E),
              ),
            ),
            child: const Text('ホームに戻る'),
            onPressed: () {
              ref.read(appRouterProvider).go('/guide_home');
            },
          ),
        ],
      ),
    );
  }
}

class _ResultSeel extends HookConsumerWidget {
  const _ResultSeel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (name, desc, url) = ref.watch(stickers)[_gouponNumber];
    return Container(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '🎉 シールゲット！ 🎉',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Center(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(url),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(color: textColor, fontSize: 16),
                      ),
                      Text(
                        desc,
                        style: const TextStyle(color: textColor, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7E7E7E),
              foregroundColor: Colors.white,
              elevation: 0,
              side: const BorderSide(
                color: Color(0xFF7E7E7E),
              ),
            ),
            child: const Text('ホームに戻る'),
            onPressed: () {
              ref.read(appRouterProvider).go('/guide_home');
            },
          ),
        ],
      ),
    );
  }
}

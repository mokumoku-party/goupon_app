import 'package:app/routes/app_router.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

final completeGoupon = StateProvider((ref) => false);

class ResultPage extends HookConsumerWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: ref.watch(completeGoupon) ? const _Result() : const _Goupon(),
    );
  }
}

class _Goupon extends HookConsumerWidget {
  const _Goupon();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController();

    return Center(
      child: Container(
        color: Colors.white,
        child: DotLottieLoader.fromAsset("assets/imgs/goupon.lottie",
            frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
          if (dotlottie != null) {
            return Lottie.memory(dotlottie.animations.values.single,
                controller: controller, onLoaded: (composition) {
              controller
                ..duration = composition.duration
                ..forward().whenComplete(() {
                  ref.read(completeGoupon.notifier).state = true;
                });
            });
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}

class _Result extends HookConsumerWidget {
  const _Result();

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
              ref.read(appRouterProvider).go('/home');
            },
          ),
        ],
      ),
    );
  }
}

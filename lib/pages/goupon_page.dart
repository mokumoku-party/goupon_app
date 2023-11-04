// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/app.dart';
import 'package:app/routes/app_router.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class GouponPage extends HookConsumerWidget {
  const GouponPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(appRouterProvider).go('/home');
        return false;
      },
      child: Scaffold(
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
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: DotLottieLoader.fromAsset("assets/imgs/trans.lottie",
                  frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(dotlottie.animations.values.single);
                } else {
                  return Container();
                }
              }),
            ),
            TextButton(
              onPressed: () {
                ref.read(appRouterProvider).go('/result');
              },
              child: Text('リザルと'),
            )
          ],
        ),
      ),
    );
  }
}

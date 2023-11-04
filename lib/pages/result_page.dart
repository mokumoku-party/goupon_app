import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      body: Container(
        child: Column(
          children: [
            Text('🎉🎉 当たり 🎉🎉'),
            Text('クーポンゲット！'),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40)),
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
                  Column(
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
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

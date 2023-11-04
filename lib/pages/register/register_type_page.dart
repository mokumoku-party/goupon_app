import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterTypePage extends HookConsumerWidget {
  const RegisterTypePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text(
          'あなたはどっち？',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),
          const _GuideOrTraveller(),
          const SizedBox(height: 32),
          const Text(
            '※後ほど変更できます',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: subSubColor,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 228,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                '次へ',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuideOrTraveller extends HookConsumerWidget {
  const _GuideOrTraveller();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/person_filled.svg',
                width: 80,
              ),
              const SizedBox(height: 8),
              const Text(
                '案内人',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: subSubColor,
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 24),
        const Text(
          'or',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: subTextColor,
          ),
        ),
        const SizedBox(width: 24),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/person_filled.svg',
                width: 80,
              ),
              const SizedBox(height: 8),
              const Text(
                '旅人',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: subSubColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

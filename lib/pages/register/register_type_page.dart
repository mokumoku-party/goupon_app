import 'package:app/app.dart';
import 'package:app/data/user_type.dart';
import 'package:app/models/register_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svgp;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterTypePage extends HookConsumerWidget {
  const RegisterTypePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType =
        ref.watch(registerNotifier.select((state) => state.type));

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
              onPressed: () {
                if (selectedType.isNone) return;

                context.push('/register_profile');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedType.isNone ? backgroundColor : primaryColor,
                surfaceTintColor: Colors.transparent,
                shape: const StadiumBorder(
                  side: BorderSide(color: primaryColor, width: 2),
                ),
              ),
              child: Text(
                '次へ',
                style: TextStyle(
                  fontSize: 16,
                  color: selectedType.isNone ? primaryColor : Colors.white,
                ),
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
    final selectedType =
        ref.watch(registerNotifier.select((state) => state.type));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _TypeCard(UserType.guide, isSelected: selectedType.isGuide),
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
        _TypeCard(UserType.traveller, isSelected: selectedType.isTraveller)
      ],
    );
  }
}

class _TypeCard extends HookConsumerWidget {
  final UserType type;
  final bool isSelected;
  const _TypeCard(
    this.type, {
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(registerNotifier.notifier).setType(type);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: subSubColor,
                border: isSelected
                    ? Border.all(color: primaryColor, width: 4)
                    : null,
                image: const DecorationImage(
                  image: svgp.Svg(
                    'assets/icons/person_filled.svg',
                    size: Size(80, 80),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              type.isTraveller ? '旅人' : '案内人',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: isSelected ? primaryColor : subSubColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

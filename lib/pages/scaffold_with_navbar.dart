import 'package:app/app.dart';
import 'package:app/models/personal_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScaffoldWithNavbar extends HookConsumerWidget {
  final StatefulNavigationShell navigationShell;

  final bool hide;
  const ScaffoldWithNavbar(this.navigationShell, this.hide, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGuide =
        ref.watch(personalProvider.select((value) => value.type.isGuide));

    return Scaffold(
      backgroundColor: backgroundColor,
      body: navigationShell,
      bottomNavigationBar: hide
          ? null
          : BottomNavigationBar(
              backgroundColor: backgroundColor,
              currentIndex: navigationShell.currentIndex,
              type: BottomNavigationBarType.shifting,
              selectedItemColor: Colors.amber,
              unselectedItemColor: Colors.grey,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'ホーム',
                  backgroundColor: backgroundColor,
                ),
                if (!isGuide)
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: '案内',
                    backgroundColor: backgroundColor,
                  ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.note),
                  label: '記録',
                  backgroundColor: backgroundColor,
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: '設定',
                  backgroundColor: backgroundColor,
                ),
              ],
              onTap: _onTap,
            ),
    );
  }

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      //initialLocation: index == navigationShell.currentIndex,
    );
  }
}

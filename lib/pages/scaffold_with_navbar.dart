import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar(this.navigationShell, {super.key});

  /// ブランチ・ナビゲーターのナビゲーション・シェルとコンテナ。
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell, // body: navigationShellは、IndexedStackをラップしています。
      bottomNavigationBar: BottomNavigationBar(
        // bottomNavigationBar: BottomNavigationBarは、ボトムナビゲーションバーを実装しています。
        currentIndex: navigationShell
            .currentIndex, // currentIndex: navigationShell.currentIndexは、現在のインデックスを取得しています。
        items: const [
          // BottomNavigationBarItemは、ボトムナビゲーションバーのアイテムを実装しています。
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shope'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: _onTap,
      ),
    );
  }

  // _onTapメソッドは、ボトムナビゲーションバーのアイテムをタップしたときに、
  // そのアイテムのインデックスを取得して、そのインデックスに対応するブランチにナビゲートします。
  void _onTap(index) {
    navigationShell.goBranch(
      index,
      // ボトムナビゲーションバーを使用する際の一般的なパターンは、次のようなものです。
      // 既にアクティブになっているアイテムをタップしたときに、最初の場所に移動することをサポートすることです。
      // この例では、この動作をサポートする方法を示します。この例では、この動作をサポートする方法を示します、
      // goBranchのinitialLocationパラメータを使用します。
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

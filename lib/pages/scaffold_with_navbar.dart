import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        currentIndex: navigationShell.currentIndex,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
            backgroundColor: backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '案内',
            backgroundColor: backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: '記録',
            backgroundColor: backgroundColor,
          ),
          BottomNavigationBarItem(
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

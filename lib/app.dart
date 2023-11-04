import 'package:app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const backgroundColor = Color(0xfff1f1f1);
const textColor = Color(0xff525252);
const subTextColor = Color(0xffc9c9c9);

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      theme: ThemeData(
        colorSchemeSeed: Colors.amber,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}

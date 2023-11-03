import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'pages/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter with Mediapipe',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0.0,
            color: Colors.transparent,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}

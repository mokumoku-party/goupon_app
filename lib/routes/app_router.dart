import 'package:app/pages/home_page.dart';
import 'package:app/pages/map_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appRouterProvider = Provider(
  (ref) => GoRouter(
    initialLocation: '/map',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/map',
        builder: (context, state) => const MapPage(),
      )
    ],
  ),
);

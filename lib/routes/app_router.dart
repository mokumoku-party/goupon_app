import 'package:app/data/personal_state.dart';
import 'package:app/models/personal_notifier.dart';
import 'package:app/pages/contact_page.dart';
import 'package:app/pages/goupon_page.dart';
import 'package:app/pages/guide/guide_home_page.dart';
import 'package:app/pages/guide_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/loading_page.dart';
import 'package:app/pages/map_page.dart';
import 'package:app/pages/register/register_profile_page.dart';
import 'package:app/pages/register/register_type_page.dart';
import 'package:app/pages/result_page.dart';
import 'package:app/pages/scaffold_with_navbar.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appRouterProvider = Provider((ref) {
  final isLogin =
      ref.watch(personalProvider.select((value) => value.isLoggedIn));
  final isLoading =
      ref.watch(personalProvider.select((value) => value.isLoading));

  return GoRouter(
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/loading',
          builder: (context, state) => const LoadingPage(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              ScaffoldWithNavbar(navigationShell),
          branches: [
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/home',
                  builder: (context, state) {
                    return const HomePage();
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              initialLocation: '/guide',
              routes: <RouteBase>[
                GoRoute(
                  path: '/guide',
                  builder: (context, state) {
                    return const GuidePage();
                  },
                  routes: [
                    GoRoute(
                      path: 'map',
                      builder: (context, state) => MapPage(
                        personalState: state.extra! as PersonalState,
                      ),
                    ),
                  ],
                ),
                GoRoute(
                    path: '/guide_home',
                    builder: (context, state) => const GuideHomePage(),
                    routes: [
                      GoRoute(
                        path: 'contact',
                        builder: (context, state) => const ContactPage(),
                      ),
                      GoRoute(
                        path: 'goupon',
                        builder: (context, state) => const GouponPage(),
                      ),
                      GoRoute(
                        path: 'result',
                        builder: (context, state) {
                          return const ResultPage();
                        },
                      )
                    ]),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/logs',
                  builder: (context, state) {
                    return const HomePage();
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/settings',
                  builder: (context, state) {
                    return const HomePage();
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/register_type',
          builder: (context, state) => const RegisterTypePage(),
        ),
        GoRoute(
          path: '/register_profile',
          builder: (context, state) => const RegisterProfilePage(),
        ),
      ],
      redirect: (context, state) {
        // コンタクトページだけ横固定
        if (state.fullPath == '/guide_home/contact') {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight
          ]);
        } else {
          // 他ページへ遷移前に解除
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
        }

        if (isLoading) {
          return '/loading';
        }

        final isResister = state.fullPath?.contains('register') ?? false;
        if (!isLogin && !isResister) {
          return '/register_type';
        }

        return null;
      });
});

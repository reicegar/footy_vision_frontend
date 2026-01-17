// --- router_config.dart ---
import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/features/home/views/home_page.dart';
import 'package:footy_vision_frontend/router/routes.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        final initialSection = state.uri.path;

        return HomePage(initialSection: initialSection);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => const NoTransitionPage(key: ValueKey('HomePageRoot'), child: SizedBox.shrink()),
        ),

        GoRoute(
          path: Routes.services,
          pageBuilder: (context, state) => const NoTransitionPage(key: ValueKey('HomePageSection'), child: SizedBox.shrink()),
        ),
        GoRoute(
          path: Routes.contactUs,
          pageBuilder: (context, state) => const NoTransitionPage(key: ValueKey('HomePageSection'), child: SizedBox.shrink()),
        ),
        GoRoute(
          path: Routes.players,
          pageBuilder: (context, state) => const NoTransitionPage(key: ValueKey('HomePageSection'), child: SizedBox.shrink()),
        ),
      ],
    ),
  ],
);

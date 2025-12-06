// --- router_config.dart ---
import 'package:footy_vision_frontend/features/home/views/home_page.dart';
import 'package:go_router/go_router.dart';

// Assume your sections have a default first section, e.g., 'home'
const String defaultFragment = 'inicio';

final GoRouter appRouter = GoRouter(
  // initialLocation: '/?section=$defaultFragment',
  routes: [
    GoRoute(path: '/', redirect: (_, __) => '/inicio'),
    GoRoute(
      path: '/:section',
      builder: (context, state) {
        // --- READING URL STATE (Query Parameter) ---
        final initialSection = state.pathParameters['section']!;

        // Pass the extracted section name to the HomePage
        return HomePage(initialSection: initialSection);
      },
    ),
  ],
);

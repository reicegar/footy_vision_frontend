// --- router_config.dart ---
import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/features/home/views/home_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // ⭐️ ShellRoute: El contenedor que mantiene el estado (HomePage)
    ShellRoute(
      // ⚠️ Usaremos el builder para construir la HomePage.
      // El builder recibe el 'child' que es la ruta activa anidada.
      builder: (context, state, child) {
        // En un ShellRoute típico, aquí se pondría un Scaffold con una Navbar
        // y el 'child' sería el cuerpo.

        // Dado que HomePage es toda la vista, podemos simplificar:

        // Determinar la sección inicial de la URL.
        // Si el estado tiene parámetros de ruta (es decir, una sección activa),
        // lo usamos. Si no, es la raíz '/'.
        final initialSection = state.pathParameters['section'] ?? '';

        // Construimos HomePage una sola vez dentro del Shell.
        // GoRouter reutilizará esta instancia.
        return HomePage(initialSection: initialSection);
      },
      routes: <RouteBase>[
        // ⭐️ 1. Ruta Raíz (Fragmento vacío: '/')
        GoRoute(
          path: '/',
          // No necesitamos builder aquí, ya que el ShellRoute maneja el build.
          // Solo necesitamos la ruta para que sea una coincidencia válida.
          pageBuilder: (context, state) => const NoTransitionPage(key: ValueKey('HomePageRoot'), child: SizedBox.shrink()),
        ),

        // ⭐️ 2. Ruta con Parámetro (Fragmento: '/inicio', '/acerca-de')
        GoRoute(
          path: '/:inicio',
          // No necesitamos builder aquí, el ShellRoute manejará el build.
          pageBuilder: (context, state) => const NoTransitionPage(key: ValueKey('HomePageSection'), child: SizedBox.shrink()),
        ),
        GoRoute(
          path: '/:acerca-de',
          // No necesitamos builder aquí, el ShellRoute manejará el build.
          pageBuilder: (context, state) => const NoTransitionPage(key: ValueKey('HomePageSection'), child: SizedBox.shrink()),
        ),
        GoRoute(
          path: '/:contacto',
          // No necesitamos builder aquí, el ShellRoute manejará el build.
          pageBuilder: (context, state) => const NoTransitionPage(key: ValueKey('HomePageSection'), child: SizedBox.shrink()),
        ),
      ],
    ),
  ],
);

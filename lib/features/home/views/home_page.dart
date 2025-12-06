import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/features/home/controllers/home_controller.dart';
import 'package:go_router/go_router.dart';
import 'widgets/top_menu.dart';
import 'widgets/page_section.dart';

class HomePage extends StatefulWidget {
  final String initialSection;
  const HomePage({super.key, required this.initialSection});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double scrollAccelerationFactor = 2.0;
  late HomeController controller;
  bool _listenerInitialized = false;

  @override
  void initState() {
    controller = HomeController();
    controller.addListener(_onControllerChange);
    super.initState();
  }

  // @override
  // void didUpdateWidget(HomePage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   // CRUCIAL: If the URL changes while the widget is mounted (e.g., Back button pressed)
  //   if (widget.initialSection != oldWidget.initialSection) {
  //     controller.scrollToSection(widget.initialSection);
  //   }
  // }

  @override
  void dispose() {
    controller.removeListener(_onControllerChange);
    controller.dispose();
    super.dispose();
  }

  void _onControllerChange() {}

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      // 1. Obtener el desplazamiento de la rueda
      final double scrollDelta = event.scrollDelta.dy;

      // 2. Aplicar el factor de aceleración
      // Multiplicamos el delta de scroll por el factor (ej: 2.0)
      final double newScrollOffset = controller.scrollController.offset + (scrollDelta * scrollAccelerationFactor);

      // 3. Animar suavemente a la nueva posición acelerada
      controller.scrollController.animateTo(newScrollOffset, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    controller.sectionHeight = screenHeight;
    const String homeSectionPath = 'inicio';

    // 2. Obtener la sección actual de la URL
    final currentSectionFromUrl = GoRouter.of(context).state.uri.queryParameters['section'] ?? homeSectionPath;

    // 3. Determinar la altura expandida según la sección
    final bool isHome = currentSectionFromUrl == homeSectionPath;

    final double appBarExpandedHeight = isHome ? 200.0 : 60.0;

    // Lógica crucial: Inicializar el listener solo después de la primera construcción
    if (!_listenerInitialized) {
      // 1. Configurar el listener del scroll
      controller.setupScrollListener(context);

      // 2. Ejecutar el scroll inicial (que ahora puede usar la altura correcta)
      // Se utiliza addPostFrameCallback para asegurar que el widget ya esté dibujado
      // antes de intentar hacer el scroll.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.scrollToSection(widget.initialSection);
      });

      _listenerInitialized = true;
    }

    return Listener(
      onPointerSignal: _handlePointerSignal,
      child: Scaffold(
        body: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              collapsedHeight: 60,
              pinned: true,
              title: TopMenuTitle(currentSection: controller.currentFragment, sections: controller.sections, onTap: controller.scrollToSection),
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final currentHeight = constraints.biggest.height;
                  final double minHeight = 60.0;
                  final double maxHeight = isHome ? 200.0 : 60.0; // Usar la altura dinámica

                  final collapseFactor = (currentHeight - minHeight) / (maxHeight - minHeight);
                  final opacity = !isHome ? 1.0 : clampDouble(collapseFactor, 0.0, 1.0);

                  const Color startColor = Colors.blueGrey;
                  const Color endColor = Colors.blue;
                  final Color backgroundColor = !isHome ? startColor : Color.lerp(startColor, endColor, opacity)!;
                  return Container(
                    color: backgroundColor,
                    child: FlexibleSpaceBar(
                      title: Opacity(
                        opacity: opacity,
                        child: const Text('Bienvenido', style: TextStyle(color: Colors.white)),
                      ),
                      centerTitle: true,
                    ),
                  );
                },
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(controller.sections.map((s) => PageSection(title: s.title, color: s.color, height: screenHeight)).toList()),
            ),
          ],
        ),
      ),
    );
  }

  double clampDouble(double value, double min, double max) {
    return value < min ? min : (value > max ? max : value);
  }
}

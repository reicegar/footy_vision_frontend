import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/features/home/controllers/home_controller.dart';
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
  static const String assetImagePath = 'images/footy-logo.jpg';
  static const String assetBackgroundPath = 'images/background_1.jpg';

  @override
  void initState() {
    controller = HomeController();
    controller.addListener(_onControllerChange);
    super.initState();
  }

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
    controller.expandedHeight = screenHeight;
    //const String homeSectionPath = 'inicio';

    final currentSectionFromUrl = widget.initialSection;
    final bool isPresentation = currentSectionFromUrl.isEmpty;

    //final bool isHome = currentSectionFromUrl == homeSectionPath;

    // Lógica crucial: Inicializar el listener solo después de la primera construcción
    if (!_listenerInitialized) {
      // 1. Configurar el listener del scroll
      controller.setupScrollListener(context);

      // 2. Ejecutar el scroll inicial (que ahora puede usar la altura correcta)
      // Se utiliza addPostFrameCallback para asegurar que el widget ya esté dibujado
      // antes de intentar hacer el scroll.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.scrollToSection(widget.initialSection, context);
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
              expandedHeight: isPresentation ? controller.expandedHeight : controller.collapsedHeight,
              collapsedHeight: controller.collapsedHeight,

              pinned: true,
              leading: !isPresentation ? Image.asset(assetImagePath, fit: BoxFit.contain, height: controller.collapsedHeight) : null,
              title: TopMenuTitle(currentSection: controller.currentFragment, sections: controller.sections, onTap: (value) => controller.scrollToSection(value, context)),
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final currentHeight = constraints.biggest.height;
                  final double minHeight = controller.collapsedHeight;
                  final double maxHeight = isPresentation ? controller.expandedHeight : controller.collapsedHeight;

                  final collapseFactor = (currentHeight - minHeight) / (maxHeight - minHeight);
                  final opacity = !isPresentation ? 1.0 : clampDouble(collapseFactor, 0.0, 1.0);

                  const Color startColor = Colors.white;
                  const Color endColor = Colors.white;
                  final Color backgroundColor = !isPresentation ? startColor : Color.lerp(startColor, endColor, opacity)!;
                  return FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: isPresentation ? Image.asset(assetBackgroundPath, fit: BoxFit.cover) : null,
                    title: Center(
                      child: Opacity(
                        opacity: opacity,
                        child: Image.asset(assetImagePath, fit: BoxFit.contain, alignment: Alignment.center, height: 400),
                      ),
                    ),
                    centerTitle: true,
                  );
                },
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                controller.sections.where((s) => s.fragment.isNotEmpty).map((s) => PageSection(title: s.title, color: s.color, height: screenHeight)).toList(),
              ),
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

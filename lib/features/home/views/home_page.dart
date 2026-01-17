import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/features/home/controllers/home_controller.dart';
import 'package:footy_vision_frontend/router/routes.dart';
import 'package:footy_vision_frontend/shared/colors.dart';
import 'package:footy_vision_frontend/shared/top_menu.dart';

// Control all pages to display in the website.
class HomePage extends StatefulWidget {
  final String initialSection;
  const HomePage({super.key, required this.initialSection});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double scrollAccelerationFactor = 0.5;
  late HomeController controller;
  bool _listenerInitialized = false;
  static const String assetImagePath = 'images/footy-logo.jpg';
  static const String assetBackgroundPath = 'images/background_1.jpg';

  bool isHome = false;

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

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialSection != widget.initialSection) {
      isHome = [Routes.home, Routes.contactUs, Routes.services].contains(widget.initialSection);
    }
  }

  void _onControllerChange() {}

  // Control the animation speed of scrolling.
  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      final double scrollDelta = event.scrollDelta.dy;

      final double newScrollOffset = controller.scrollController.offset + (scrollDelta * scrollAccelerationFactor);

      controller.scrollController.animateTo(newScrollOffset, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void _navigationHandler(String fragment) {
    if ([Routes.home, Routes.contactUs, Routes.services].contains(fragment)) {
      controller.menuHandler.updateRoute(fragment);
      controller.scrollToSection(fragment, context);
      return;
    }
    controller.menuHandler.navigateTo(fragment);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    controller.sectionHeight = screenHeight;
    controller.expandedHeight = screenHeight;

    final currentSectionFromUrl = widget.initialSection;
    final bool isPresentation = currentSectionFromUrl.isEmpty || currentSectionFromUrl == Routes.home;
    isHome = [Routes.home, Routes.contactUs, Routes.services].contains(currentSectionFromUrl);

    if (!_listenerInitialized) {
      controller.setupScrollListener(context);
      _listenerInitialized = true;
    }

    return Listener(
      onPointerSignal: _handlePointerSignal,
      child: Scaffold(
        body: Stack(
          children: [
            IndexedStack(index: isHome ? 0 : 1, children: [homeSectionsPage(isPresentation, context, screenHeight), _buildStaticPage(currentSectionFromUrl)]),
            Positioned(top: 0, left: 0, right: 0, child: _buildPersistentHeader(currentSectionFromUrl, isHome, (value) => _navigationHandler(value))),
          ],
        ),
      ),
    );
  }

  CustomScrollView homeSectionsPage(bool isPresentation, BuildContext context, double screenHeight) {
    return CustomScrollView(
      controller: controller.scrollController,
      slivers: [
        SliverAppBar(
          expandedHeight: controller.expandedHeight,
          collapsedHeight: controller.collapsedHeight,
          pinned: true,
          backgroundColor: FColors.black,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final currentHeight = constraints.biggest.height;
              final double minHeight = controller.collapsedHeight;
              final double maxHeight = isPresentation ? controller.expandedHeight : controller.collapsedHeight;

              final collapseFactor = (currentHeight - minHeight) / (maxHeight - minHeight);
              final opacity = !isPresentation ? 1.0 : clampDouble(collapseFactor, 0.0, 1.0);

              bool collapsed = currentHeight <= minHeight + 20;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                controller.isCollapsed.value = collapsed;
              });

              return FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: isPresentation ? Opacity(opacity: 0.4, child: Image.asset(assetBackgroundPath, fit: BoxFit.cover)) : null,
                title: isPresentation
                    ? Opacity(
                        opacity: opacity,
                        child: Center(
                          child: Image.asset(assetImagePath, fit: BoxFit.contain, alignment: Alignment.center, height: 400),
                        ),
                      )
                    : null,
                centerTitle: true,
              );
            },
          ),
        ),
        SliverList(delegate: SliverChildListDelegate(controller.getPages(screenHeight))),
      ],
    );
  }

  double clampDouble(double value, double min, double max) {
    return value < min ? min : (value > max ? max : value);
  }

  Widget _buildPersistentHeader(String path, bool isHome, Function(String value) onTap) {
    return ValueListenableBuilder(
      valueListenable: controller.isCollapsed,
      builder: (context, isCollapsed, child) {
        return Container(
          height: controller.collapsedHeight,
          color: isHome ? Colors.transparent : FColors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            spacing: 10,
            children: [
              if (isCollapsed)
                Image.asset(
                  assetImagePath,
                  height: 40, // Logo pequeño para el header colapsado
                  fit: BoxFit.contain,
                ),
              Align(
                alignment: Alignment.centerLeft,
                child: TopMenu(
                  currentSection: path,
                  goTo: (value) {
                    onTap(value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildStaticPage(String section) {
  return Container(
    color: Colors.white, // O el color de fondo que prefieras
    child: Center(child: Text("Contenido de la sección: $section")),
  );
}

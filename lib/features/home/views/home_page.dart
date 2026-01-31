import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/features/home/controllers/home_controller.dart';
import 'package:footy_vision_frontend/router/routes.dart';
import 'package:footy_vision_frontend/shared/constants.dart';
import 'package:footy_vision_frontend/shared/top_menu.dart';

import 'about_us_page.dart';
import 'contact_us_page.dart';
import 'services_page.dart';

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

  bool isHome = false;

  @override
  void initState() {
    controller = HomeController();
    controller.addListener(_onControllerChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialSection.isNotEmpty && widget.initialSection != Routes.home) {
        controller.scrollToSection(widget.initialSection, context);
      }
    });
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
      // 1. Calculate the target offset
      final double scrollDelta = event.scrollDelta.dy;
      final double currentOffset = controller.scrollController.offset;

      // We increase the multiplier slightly for a "faster" feel
      // or keep your 0.5 for more precision.
      final double targetOffset = currentOffset + (scrollDelta * 1.2);

      // 2. Clamp the value so we don't try to scroll into the abyss
      final double maxScroll = controller.scrollController.position.maxScrollExtent;
      final double clampedOffset = targetOffset.clamp(0.0, maxScroll);

      // 3. Animate with a 'decelerate' or 'easeOutCubic' curve.
      // This makes the start of the scroll feel responsive and the end feel soft.
      controller.scrollController.animateTo(clampedOffset, duration: const Duration(milliseconds: 200), curve: Curves.easeOutCubic);
    }
    // if (event is PointerScrollEvent) {
    //   // 1. Calculate the new position based on how much you turned the wheel
    //   final double scrollDelta = event.scrollDelta.dy;
    //   final double newScrollOffset = controller.scrollController.offset + (scrollDelta * scrollAccelerationFactor);

    //   // 2. Use a very short duration (100ms-150ms).
    //   // If it's too long (300ms), the wheel feels "heavy" and stops.
    //   controller.scrollController.animateTo(
    //     newScrollOffset.clamp(0, controller.scrollController.position.maxScrollExtent),
    //     duration: const Duration(milliseconds: 200),
    //     curve: Curves.easeOutCubic, // Much smoother for mouse wheels
    //   );
    // }
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
        drawer: TopMenu(currentSection: currentSectionFromUrl, goTo: (value) => _navigationHandler(value), drawer: true),
        body: Stack(
          children: [
            IndexedStack(index: isHome ? 0 : 1, children: [homeSectionsPage(isPresentation, context, screenHeight), _buildStaticPage(currentSectionFromUrl)]),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Material(color: Colors.transparent, elevation: 0, child: _buildPersistentHeader(currentSectionFromUrl, isHome, (value) => _navigationHandler(value))),
            ),
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
          automaticallyImplyLeading: false,
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
                // Move the background image here to keep it behind the logo
                background: isPresentation
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background photo
                          Opacity(
                            opacity: 0.4,
                            child: Image.asset(FImage.assetBackgroundPath, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                          ),

                          // Responsive Logo
                          if (isPresentation)
                            Opacity(
                              opacity: opacity,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                // Use LayoutBuilder or Mediaquery to scale the logo
                                width: MediaQuery.of(context).size.width * 0.6, // 60% of screen width
                                constraints: const BoxConstraints(maxWidth: 600, minWidth: 200),
                                child: Image.asset(FImage.assetImagePath, fit: BoxFit.contain),
                              ),
                            ),
                        ],
                      )
                    : null,
              );
            },
          ),
        ),
        SliverList(delegate: SliverChildListDelegate(getPages(screenHeight))),
      ],
    );
  }

  List<Widget> getPages(double height) {
    return [AboutUsPage(height: height, scrollController: controller.scrollController), ServicesPage(height: height), ContactUsPage(height: height)];
  }

  double clampDouble(double value, double min, double max) {
    return value < min ? min : (value > max ? max : value);
  }

  Widget _buildPersistentHeader(String path, bool isHome, Function(String value) onTap) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = MediaQuery.of(context).size.width < 850;
        return ValueListenableBuilder(
          valueListenable: controller.isCollapsed,
          builder: (context, isCollapsed, child) {
            // LOGIC FIX: Show logo if header is collapsed OR if we are NOT on a home-related section
            // This ensures that when you click "Players", the logo appears immediately.
            final bool shouldShowLogo = isCollapsed || ![Routes.home, Routes.contactUs, Routes.services].contains(path);

            return Container(
              height: controller.collapsedHeight,
              // Match your logic: transparent on home/services/contact, black on static pages
              color: isHome ? Colors.transparent : FColors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  if (shouldShowLogo)
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Image.asset(FImage.assetImagePath, height: 40, fit: BoxFit.contain),
                    ),
                  if (isMobile)
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                        splashRadius: 25,
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    )
                  else
                    Expanded(
                      // Use Expanded to ensure menu fills space correctly
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TopMenu(currentSection: path, goTo: (value) => onTap(value)),
                      ),
                    ),
                ],
              ),
            );
          },
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

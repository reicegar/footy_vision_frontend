// home_controller.dart

import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/core/models/option_model.dart';
import 'package:footy_vision_frontend/router/app_router.dart';
import 'package:footy_vision_frontend/router/routes.dart';
import 'package:footy_vision_frontend/shared/menu_handler.dart';

class HomeController with ChangeNotifier {
  final scrollController = ScrollController();

  // section height populating in homePage view
  double sectionHeight = 0.0;
  double expandedHeight = 0.0;
  double collapsedHeight = 60;
  String _currentFragment = '';
  String get currentFragment => _currentFragment;

  late MenuHandler menuHandler;

  List<OptionModel> get menuOptions => menuHandler.options.where((o) => [Routes.home, Routes.services, Routes.contactUs].contains(o.fragment)).toList();

  final ValueNotifier<bool> isCollapsed = ValueNotifier<bool>(false);

  HomeController() {
    menuHandler = MenuHandler();
  }

  void scrollToSection(String sectionPath, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      if (sectionPath.isEmpty) {
        _currentFragment = sectionPath;
        scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOutQuart);
        return;
      }

      final index = menuOptions.indexWhere((s) => s.fragment == sectionPath);

      if (index != -1 && sectionHeight > 0) {
        double offset = 0.0;

        final double appBarContraction = expandedHeight - collapsedHeight;

        final double precedingContentHeight = index * sectionHeight;

        offset = appBarContraction + precedingContentHeight;

        _currentFragment = sectionPath;
        final newPath = sectionPath.isEmpty ? '/' : sectionPath;

        scrollController.animateTo(offset, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut).then((_) {
          if (scrollController.hasClients) {
            appRouter.replace(newPath);
            notifyListeners();
          }
        });
      }
    });
  }

  void setupScrollListener(BuildContext context) {
    if (scrollController.hasListeners) return;

    scrollController.addListener(() {
      final currentOffset = scrollController.offset;

      // We calculate the 'center' of the viewport
      // This ensures the menu only changes when the new section
      // crosses the middle of the screen (50% visibility)
      final double viewportCenter = currentOffset + (sectionHeight / 2);

      // Subtract the AppBar expansion space to align the math
      final double appBarContraction = expandedHeight - collapsedHeight;
      final double adjustedCenter = viewportCenter - appBarContraction;

      int targetSectionIndex = (adjustedCenter / sectionHeight).floor();

      // Bounds checking
      if (targetSectionIndex < 0) targetSectionIndex = 0;
      if (targetSectionIndex >= menuOptions.length) targetSectionIndex = menuOptions.length - 1;

      final visibleSectionPath = menuOptions[targetSectionIndex].fragment;

      if (visibleSectionPath != _currentFragment) {
        _currentFragment = visibleSectionPath;
        final path = visibleSectionPath.isEmpty ? '/' : visibleSectionPath;

        // Use replace only if necessary to avoid constant URL jumping
        appRouter.replace(path);
        notifyListeners(); // This triggers the TopMenu to update its selectionRect
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

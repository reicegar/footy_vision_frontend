import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/config/l10n/app_localizations.dart';
import 'package:footy_vision_frontend/core/models/option_model.dart';
import 'package:footy_vision_frontend/router/app_router.dart';
import 'package:footy_vision_frontend/router/routes.dart';

class MenuHandler {
  static final MenuHandler _instance = MenuHandler._internal();

  MenuHandler._internal();

  factory MenuHandler() => _instance;

  String _currentRoute = Routes.home;
  String get currentRoute => _currentRoute;

  List<OptionModel> options = [
    OptionModel(titleBuilder: (context) => 'Home', fragment: Routes.home, navigationType: NavigationType.scroll),
    OptionModel(titleBuilder: (context) => AppLocalizations.of(context)!.services, fragment: Routes.services, navigationType: NavigationType.scroll),
    OptionModel(titleBuilder: (context) => AppLocalizations.of(context)!.contactUs, fragment: Routes.contactUs, navigationType: NavigationType.scroll),
    OptionModel(titleBuilder: (context) => 'Players', fragment: Routes.players),
  ];

  List<String> get getScrollableFragments => options.where((o) => o.navigationType == NavigationType.scroll).map((o) => o.fragment).toList();

  void navigateTo(String route) {
    updateRoute(route);
    appRouter.go(_currentRoute);
  }

  void updateRoute(String route) {
    if (_currentRoute != route) {
      _currentRoute = route;
    }
  }
}

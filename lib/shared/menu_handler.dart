import 'package:footy_vision_frontend/core/models/option_model.dart';
import 'package:footy_vision_frontend/router/app_router.dart';
import 'package:footy_vision_frontend/router/routes.dart';

class MenuHandler {
  static final MenuHandler _instance = MenuHandler._internal();

  MenuHandler._internal() {
    initialise();
  }

  factory MenuHandler() => _instance;

  String _currentRoute = Routes.home;
  String get currentRoute => _currentRoute;

  final options = <OptionModel>[];

  void initialise() {
    options.addAll([
      OptionModel(title: 'Home', fragment: Routes.home),
      OptionModel(title: 'Services', fragment: Routes.services),
      OptionModel(title: 'Contact Us', fragment: Routes.contactUs),
      OptionModel(title: 'Players', fragment: Routes.players),
    ]);
  }

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

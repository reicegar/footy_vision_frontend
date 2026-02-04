// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get home => 'Inicio';

  @override
  String get aboutUs => 'Sobre nosotros';

  @override
  String get services => 'Servicios';

  @override
  String get contactUs => 'Contáctanos';

  @override
  String ourVision(String paragraph) {
    String _temp0 = intl.Intl.selectLogic(paragraph, {
      'n': 'Nuestra\nVisión',
      'other': 'Nuestra Visión',
    });
    return '$_temp0';
  }

  @override
  String get getInTouch => 'Descubre más';
}

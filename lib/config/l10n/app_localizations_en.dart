// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get aboutUs => 'About us';

  @override
  String get services => 'Services';

  @override
  String get contactUs => 'Contact us';

  @override
  String ourVision(String paragraph) {
    String _temp0 = intl.Intl.selectLogic(paragraph, {
      'n': 'Our\nVision',
      'other': 'Our Vision',
    });
    return '$_temp0';
  }

  @override
  String get getInTouch => 'Get in touch';
}

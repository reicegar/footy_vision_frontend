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

  @override
  String get smartAICoverage => 'Smart A.I. Coverage';

  @override
  String get subSmartAICoverage =>
      'Our state-of-the-art AI cameras act as the primary lens, tracking the action automatically and with precision.';

  @override
  String get multiAnglePerspective => 'Multi-Angle Perspective';

  @override
  String get subMultiAnglePerspective =>
      'Experience the match from every vantage point with our dedicated behind-the-goal cameras.';

  @override
  String get customHighlights => 'Custom Highlights';

  @override
  String get subCustomHighligths =>
      'Take control of your performance. Use the VEO platform to create, edit, and download your own personal highlight reels.';

  @override
  String get onDemandAccess => 'On-Demand Access';

  @override
  String get subOnDemandAccess =>
      'Relive the glory anytime. Full matches and curated highlights are hosted directly on our website for easy viewing.';
}

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

  @override
  String get smartAICoverage => 'Cobertura de IA Inteligente';

  @override
  String get subSmartAICoverage => 'Análisis avanzado impulsado por IA';

  @override
  String get multiAnglePerspective => 'Perspectiva de Múltiples Ángulos';

  @override
  String get subMultiAnglePerspective =>
      'Visualiza el partido desde diferentes perspectivas';

  @override
  String get customHighlights => 'Destacados Personalizados';

  @override
  String get subCustomHighligths => 'Crea tus propios momentos destacados';

  @override
  String get onDemandAccess => 'Acceso Bajo Demanda';

  @override
  String get subOnDemandAccess =>
      'Accede a cualquier contenido en cualquier momento';
}

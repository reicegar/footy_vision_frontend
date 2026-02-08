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

  @override
  String get ourServices => 'Nuestros Servicios';

  @override
  String get subOurServices =>
      'Cada paquete incluye: \n● Configuración profesional de equipos, cobertura completa de partidos y entrega digital sin interrupciones';

  @override
  String get bronzePackage => 'Paquete Bronze';

  @override
  String get silverPackage => 'Paquete Plata';

  @override
  String get goldPackage => 'Paquete Oro';

  @override
  String get platinumPackage => 'Paquete Platino';

  @override
  String get bronzeSubtitle => 'Inicio';

  @override
  String get bronzePrice => 'Contactar';

  @override
  String get bronzeFeat1 => '1 cámara';

  @override
  String get bronzeFeat2 => 'Cobertura básica';

  @override
  String get bronzeFeat3 => 'Análisis estándar';

  @override
  String get bronzeFeat4 => 'Entrega en 48 horas';

  @override
  String get bronzeFeat5 => 'Soporte básico';

  @override
  String get bronzeFeat6 => '1 edición';

  @override
  String get silverSubtitle => 'Profesional';

  @override
  String get silverPrice => 'Contactar';

  @override
  String get silverFeat1 => '2 cámaras';

  @override
  String get silverFeat2 => 'Cobertura estándar';

  @override
  String get silverFeat3 => 'Análisis avanzado';

  @override
  String get silverFeat4 => 'Entrega en 24 horas';

  @override
  String get silverFeat5 => 'Soporte prioritario';

  @override
  String get goldSubtitle => 'Premium';

  @override
  String get goldPrice => 'Contactar';

  @override
  String get goldFeat1 => '4 cámaras';

  @override
  String get goldFeat2 => 'Cobertura 360°';

  @override
  String get goldFeat3 => 'Análisis IA completo';

  @override
  String get goldFeat4 => 'Entrega inmediata';

  @override
  String get goldFeat5 => 'Soporte 24/7';

  @override
  String get goldFeat6 => 'Ediciones ilimitadas';

  @override
  String get platinumSubtitle => 'Empresarial';

  @override
  String get platinumPrice => 'Precio personalizado';

  @override
  String get platinumFeat1 => 'Cobertura ilimitada';

  @override
  String get platinumFeat2 => 'Análisis IA avanzado';

  @override
  String get platinumFeat3 => 'Equipo dedicado';

  @override
  String get platinumFeat4 => 'Entrega en tiempo real';

  @override
  String get platinumFeat5 => 'Soporte concierge';

  @override
  String get platinumFeat6 => 'Generador personalizado de destacados';

  @override
  String get enquireNow => 'Consultar Ahora';

  @override
  String get corporateEventsTitle => 'Eventos Corporativos';

  @override
  String get corporateEventsSub =>
      'Soluciones personalizadas para eventos grandes';
}

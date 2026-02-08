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

  @override
  String get ourServices => 'Our Services';

  @override
  String get subOurServices =>
      'Every package includes: \nProfessional equipment setup, full match coverage and seamless digital delivery';

  @override
  String get bronzePackage => 'Bronze Package';

  @override
  String get silverPackage => 'Silver Package';

  @override
  String get goldPackage => 'Gold Package';

  @override
  String get platinumPackage => 'Platinum Package';

  @override
  String get bronzeSubtitle => 'Raw Footage Only';

  @override
  String get bronzePrice => '£130';

  @override
  String get bronzeFeat1 => 'Match filmed using VEO 2 (A.I. sports camera)';

  @override
  String get bronzeFeat2 => 'Single-camera recording';

  @override
  String get bronzeFeat3 =>
      'Raw match footage (no edits, overlays, or replays)';

  @override
  String get bronzeFeat4 => 'Suitable for training & review';

  @override
  String get bronzeFeat5 => 'Suitable for training & review';

  @override
  String get bronzeFeat6 => 'Local coverage (London & surrounding areas)';

  @override
  String get silverSubtitle => 'Standard Highlights & Match Edits';

  @override
  String get silverPrice => '£250';

  @override
  String get silverFeat1 => '3 camera recording (VEO 2 + 2 goal cameras)';

  @override
  String get silverFeat2 => 'Edited full match + 2 goal video';

  @override
  String get silverFeat3 => 'Highlights video included';

  @override
  String get silverFeat4 => 'Team lineups & scoreboard overlay';

  @override
  String get silverFeat5 => 'Multi-angle replays & goalscorer graphics';

  @override
  String get goldSubtitle => 'Premium Multi-Cam + Commentary';

  @override
  String get goldPrice => '£350';

  @override
  String get goldFeat1 => '4/5-camera recording (VEO 2 video)';

  @override
  String get goldFeat2 => 'Edited full match (4 cams + camcorder)';

  @override
  String get goldFeat3 => 'Highlights video included';

  @override
  String get goldFeat4 => 'Team lineups, scoreboard & replays';

  @override
  String get goldFeat5 => 'Goalscorer graphics & match visuals';

  @override
  String get goldFeat6 => 'Highlights commentary included';

  @override
  String get platinumSubtitle => 'Full Media & Player Analytics';

  @override
  String get platinumPrice => '£450';

  @override
  String get platinumFeat1 => '4/5 camera premium recording setup';

  @override
  String get platinumFeat2 => 'Edited full video included';

  @override
  String get platinumFeat3 => 'Highlights video included';

  @override
  String get platinumFeat4 => 'Full player statistics & replays';

  @override
  String get platinumFeat5 => 'Full player statistics & analytics';

  @override
  String get platinumFeat6 => 'Player profile videos & personalised playlists';

  @override
  String get enquireNow => 'Enquire Now';

  @override
  String get corporateEventsTitle => 'Corporate & Company Football Events';

  @override
  String get corporateEventsSub =>
      'We also support company tournaments, internal leagues and corporate football events, including match filming, highlights and brand media delivery.';
}

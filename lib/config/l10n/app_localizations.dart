import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// Title for home page
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Title for about us
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutUs;

  /// Title for services
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// Title for Contact us
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// Title of section for about us page
  ///
  /// In en, this message translates to:
  /// **'{paragraph, select, n{Our\nVision} other{Our Vision}}'**
  String ourVision(String paragraph);

  /// Title of section for about us page
  ///
  /// In en, this message translates to:
  /// **'Get in touch'**
  String get getInTouch;

  /// Title of section for about us page
  ///
  /// In en, this message translates to:
  /// **'Smart A.I. Coverage'**
  String get smartAICoverage;

  /// Subtitle of Smart A.I. Coverage
  ///
  /// In en, this message translates to:
  /// **'Our state-of-the-art AI cameras act as the primary lens, tracking the action automatically and with precision.'**
  String get subSmartAICoverage;

  /// Title of section for about us page
  ///
  /// In en, this message translates to:
  /// **'Multi-Angle Perspective'**
  String get multiAnglePerspective;

  /// Subtitle of Multi-Angle Perspective
  ///
  /// In en, this message translates to:
  /// **'Experience the match from every vantage point with our dedicated behind-the-goal cameras.'**
  String get subMultiAnglePerspective;

  /// Title of section for about us page
  ///
  /// In en, this message translates to:
  /// **'Custom Highlights'**
  String get customHighlights;

  /// Subtitle of Custom Highlights
  ///
  /// In en, this message translates to:
  /// **'Take control of your performance. Use the VEO platform to create, edit, and download your own personal highlight reels.'**
  String get subCustomHighligths;

  /// Title of section for about us page
  ///
  /// In en, this message translates to:
  /// **'On-Demand Access'**
  String get onDemandAccess;

  /// Subtitle of On-Demand Access
  ///
  /// In en, this message translates to:
  /// **'Relive the glory anytime. Full matches and curated highlights are hosted directly on our website for easy viewing.'**
  String get subOnDemandAccess;

  /// Title of section for services page
  ///
  /// In en, this message translates to:
  /// **'Our Services'**
  String get ourServices;

  /// Subtitle of Our Services
  ///
  /// In en, this message translates to:
  /// **'Every package includes: \nProfessional equipment setup, full match coverage and seamless digital delivery'**
  String get subOurServices;

  /// Title of Bronze Package
  ///
  /// In en, this message translates to:
  /// **'Bronze Package'**
  String get bronzePackage;

  /// Title of Silver Package
  ///
  /// In en, this message translates to:
  /// **'Silver Package'**
  String get silverPackage;

  /// Title of Gold Package
  ///
  /// In en, this message translates to:
  /// **'Gold Package'**
  String get goldPackage;

  /// Title of Platinum Package
  ///
  /// In en, this message translates to:
  /// **'Platinum Package'**
  String get platinumPackage;

  /// No description provided for @bronzeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Raw Footage Only'**
  String get bronzeSubtitle;

  /// No description provided for @bronzePrice.
  ///
  /// In en, this message translates to:
  /// **'£130'**
  String get bronzePrice;

  /// No description provided for @bronzeFeat1.
  ///
  /// In en, this message translates to:
  /// **'Match filmed using VEO 2 (A.I. sports camera)'**
  String get bronzeFeat1;

  /// No description provided for @bronzeFeat2.
  ///
  /// In en, this message translates to:
  /// **'Single-camera recording'**
  String get bronzeFeat2;

  /// No description provided for @bronzeFeat3.
  ///
  /// In en, this message translates to:
  /// **'Raw match footage (no edits, overlays, or replays)'**
  String get bronzeFeat3;

  /// No description provided for @bronzeFeat4.
  ///
  /// In en, this message translates to:
  /// **'Suitable for training & review'**
  String get bronzeFeat4;

  /// No description provided for @bronzeFeat5.
  ///
  /// In en, this message translates to:
  /// **'Suitable for training & review'**
  String get bronzeFeat5;

  /// No description provided for @bronzeFeat6.
  ///
  /// In en, this message translates to:
  /// **'Local coverage (London & surrounding areas)'**
  String get bronzeFeat6;

  /// No description provided for @silverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Standard Highlights & Match Edits'**
  String get silverSubtitle;

  /// No description provided for @silverPrice.
  ///
  /// In en, this message translates to:
  /// **'£250'**
  String get silverPrice;

  /// No description provided for @silverFeat1.
  ///
  /// In en, this message translates to:
  /// **'3 camera recording (VEO 2 + 2 goal cameras)'**
  String get silverFeat1;

  /// No description provided for @silverFeat2.
  ///
  /// In en, this message translates to:
  /// **'Edited full match + 2 goal video'**
  String get silverFeat2;

  /// No description provided for @silverFeat3.
  ///
  /// In en, this message translates to:
  /// **'Highlights video included'**
  String get silverFeat3;

  /// No description provided for @silverFeat4.
  ///
  /// In en, this message translates to:
  /// **'Team lineups & scoreboard overlay'**
  String get silverFeat4;

  /// No description provided for @silverFeat5.
  ///
  /// In en, this message translates to:
  /// **'Multi-angle replays & goalscorer graphics'**
  String get silverFeat5;

  /// No description provided for @goldSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Premium Multi-Cam + Commentary'**
  String get goldSubtitle;

  /// No description provided for @goldPrice.
  ///
  /// In en, this message translates to:
  /// **'£350'**
  String get goldPrice;

  /// No description provided for @goldFeat1.
  ///
  /// In en, this message translates to:
  /// **'4/5-camera recording (VEO 2 video)'**
  String get goldFeat1;

  /// No description provided for @goldFeat2.
  ///
  /// In en, this message translates to:
  /// **'Edited full match (4 cams + camcorder)'**
  String get goldFeat2;

  /// No description provided for @goldFeat3.
  ///
  /// In en, this message translates to:
  /// **'Highlights video included'**
  String get goldFeat3;

  /// No description provided for @goldFeat4.
  ///
  /// In en, this message translates to:
  /// **'Team lineups, scoreboard & replays'**
  String get goldFeat4;

  /// No description provided for @goldFeat5.
  ///
  /// In en, this message translates to:
  /// **'Goalscorer graphics & match visuals'**
  String get goldFeat5;

  /// No description provided for @goldFeat6.
  ///
  /// In en, this message translates to:
  /// **'Highlights commentary included'**
  String get goldFeat6;

  /// No description provided for @platinumSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Full Media & Player Analytics'**
  String get platinumSubtitle;

  /// No description provided for @platinumPrice.
  ///
  /// In en, this message translates to:
  /// **'£450'**
  String get platinumPrice;

  /// No description provided for @platinumFeat1.
  ///
  /// In en, this message translates to:
  /// **'4/5 camera premium recording setup'**
  String get platinumFeat1;

  /// No description provided for @platinumFeat2.
  ///
  /// In en, this message translates to:
  /// **'Edited full video included'**
  String get platinumFeat2;

  /// No description provided for @platinumFeat3.
  ///
  /// In en, this message translates to:
  /// **'Highlights video included'**
  String get platinumFeat3;

  /// No description provided for @platinumFeat4.
  ///
  /// In en, this message translates to:
  /// **'Full player statistics & replays'**
  String get platinumFeat4;

  /// No description provided for @platinumFeat5.
  ///
  /// In en, this message translates to:
  /// **'Full player statistics & analytics'**
  String get platinumFeat5;

  /// No description provided for @platinumFeat6.
  ///
  /// In en, this message translates to:
  /// **'Player profile videos & personalised playlists'**
  String get platinumFeat6;

  /// Label for enquire now button
  ///
  /// In en, this message translates to:
  /// **'Enquire Now'**
  String get enquireNow;

  /// No description provided for @corporateEventsTitle.
  ///
  /// In en, this message translates to:
  /// **'Corporate & Company Football Events'**
  String get corporateEventsTitle;

  /// No description provided for @corporateEventsSub.
  ///
  /// In en, this message translates to:
  /// **'We also support company tournaments, internal leagues and corporate football events, including match filming, highlights and brand media delivery.'**
  String get corporateEventsSub;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

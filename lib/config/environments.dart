class Environments {
  static const String projectId = String.fromEnvironment('PROJECT_ID');
  static const String storageBucket = String.fromEnvironment('STORAGE_BUCKET');
  static const String messagingSenderId = String.fromEnvironment('MESSAGING_SENDER_ID');

  // ONLY WEB
  static const String apiKeyWeb = String.fromEnvironment('API_KEY_WEB');
  static const String appIdWeb = String.fromEnvironment('APP_ID_WEB');
  static const String authDomain = String.fromEnvironment('AUTH_DOMAIN');
  static const String measurementId = String.fromEnvironment('MEASUREMENT_ID');

  // ONLY ANDROID
  static const String apiKeyAndroid = String.fromEnvironment('API_KEY_ANDROID');
  static const String appIdAndroid = String.fromEnvironment('APP_ID_ANDROID');

  // ONLY IOS
  static const String apiKeyIos = String.fromEnvironment('APP_KEY_IOS');
  static const String appIdIos = String.fromEnvironment('APP_ID_IOS');
  static const String iosBundleId = String.fromEnvironment('IOS_BUNDLE_ID');
}

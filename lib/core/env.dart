/// Static configuration for the NilaiQ mobile app.
class Env {
  /// Base URL of the Laravel API.
  ///
  /// Override at build/run time with:
  /// `flutter run --dart-define=API_BASE_URL=http://192.168.1.10:8000/api`
  ///
  /// Defaults to the Android emulator loopback host.
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://nilaiq.online/api',
  );

  /// Number of days before unsynced offline data triggers a warning banner.
  static const int offlineWarningDays = 5;

  /// App display name.
  static const String appName = 'NilaiQ';
}

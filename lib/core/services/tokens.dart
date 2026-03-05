import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ACCESS AND REFRESH TOKEN
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class Tokens {
  static String? _refreshToken;
  static String? _accessToken;

  static String? get accessToken => _accessToken;

  static Future<String?> get refreshToken async {
    if (_refreshToken != null) return _refreshToken;

    final storage = FlutterSecureStorage();
    _refreshToken = await storage.read(key: "refreshToken");

    return _refreshToken;
  }

  static Future<void> save({
    required String accessToken,
    required String refreshToken,
  }) async {
    _refreshToken = refreshToken;
    _accessToken = accessToken;
    final storage = FlutterSecureStorage();
    await storage.write(key: "refreshToken", value: refreshToken);
    await storage.write(key: "accessToken", value: accessToken); // 🔥 ADD THIS
  }

  static Future<void> init() async {
    final storage = FlutterSecureStorage();
    _refreshToken = await storage.read(key: "refreshToken");
    _accessToken = await storage.read(key: "accessToken"); // 🔥 RESTORE
  }

  static Future<void> clear() async {
    _refreshToken = null;
    _accessToken = null;

    final storage = FlutterSecureStorage();
    await storage.delete(key: "refreshToken");
    await storage.delete(key: "accessToken");
  }
}

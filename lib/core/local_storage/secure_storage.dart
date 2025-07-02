import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCache {
  static final _storage = const FlutterSecureStorage();

  static Future<void> saveBool({
    required String key,
    required bool value,
  }) async {
    await _storage.write(key: key, value: value.toString());
  }

  static Future<bool> readBool({required String key}) async {
    final result = await _storage.read(key: key);
    return result == 'true';
  }

  static Future<void> deleteKey(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}

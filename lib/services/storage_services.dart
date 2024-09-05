import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const sharedPrefLastCacheTimeKey = 'cache_time_url_key';
  static const sharedPrefUserData = 'UserData';
  static const sharedPrefTokenData = 'TokenData';

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token =
        await Future<String>.value(prefs.getString(sharedPrefTokenData) ?? '');

    return token;
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(sharedPrefTokenData);
  }

  Future<String> getData(String key) async {
    String data = await _getStringFromPreferences(key);
    return data;
  }

  Future<void> cacheData(String data, String key) async {
    _saveToPreferences(key, data);
  }

  Future<void> removeCacheData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> _saveToPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> _getStringFromPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Future<String>.value(prefs.getString(key) ?? '');
  }
}

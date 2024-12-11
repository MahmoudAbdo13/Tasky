import 'package:shared_preferences/shared_preferences.dart';

class AppReference {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // ****** set & get and delete  user data ******
  static Future<void> setData(
      {required String key, required dynamic data}) async {
    if (data is String) {
      await sharedPreferences.setString(key, data);
    } else if (data is bool) {
      await sharedPreferences.setBool(key, data);
    } else if (data is int) {
      await sharedPreferences.setInt(key, data);
    } else {
      await sharedPreferences.setDouble(key, data);
    }
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<void> removeData({
    required String key,
  }) async {
    await sharedPreferences.remove(key);
  }
}
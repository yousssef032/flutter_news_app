import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(
      {required String key, required bool value}) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static Future<bool> getData({required String key}) async {
    return sharedPreferences!.getBool(key) ?? false;
  }
}

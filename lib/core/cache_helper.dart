import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveIfNotFirstTime() async {
    return await prefs.setBool("IfFirstTime", false);
  }

  static bool getIfFirstTime() {
    return prefs.getBool("IfFirstTime") ?? true;
  }

  static Future<bool> saveToken(String token) async {
    return await prefs.setString("token", token);
  }

  static String getToken() {
    return prefs.getString("token") ?? "";
  }

  static Future<bool> removeToken() {
    return prefs.remove("token");
  }

  static Future<bool> saveId(String id) async {
    return await prefs.setString("id", id);
  }

  static String getId() {
    return prefs.getString("id") ?? "";
  }

  static Future<bool> removeId() {
    return prefs.remove("id");
  }

  // static Future<bool> saveEmail(String email) async {
  //   return await prefs.setString("email", email);
  // }
  //
  // static String getEmail() {
  //   return prefs.getString("email") ?? "";
  // }
  //
  // static Future<bool> savePass(String pass) async {
  //   return await prefs.setString("pass", pass);
  // }
  //
  // static String getPass() {
  //   return prefs.getString("pass") ?? "";
  // }

  static Future<bool> clear() {
    return prefs.clear();
  }
}

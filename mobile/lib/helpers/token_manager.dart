
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager{

  
  static Future<String> get token async {
    final prefs = (await SharedPreferences.getInstance());
    return prefs.getString("token") ?? "";
  }

  static Future<void> setToken(token) async {
    final prefs = (await SharedPreferences.getInstance());
    await prefs.setString("token", token);
  }

  static Future<void> deleteToken() async {
    final prefs = (await SharedPreferences.getInstance());
    await prefs.remove('token');
  }

}
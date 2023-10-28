import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static Future<void> storeUsername(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  static Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<void> removeUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }
}

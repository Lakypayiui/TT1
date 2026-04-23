import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const _keyStudentId = 'studentId';

  static Future<void> saveSession(int studentId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyStudentId, studentId);
  }

  static Future<int?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyStudentId);
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyStudentId);
  }
}
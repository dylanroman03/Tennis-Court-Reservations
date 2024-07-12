import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis/database/database_provider.dart';

class SessionRepository {
  final DatabaseProvider databaseProvider;

  SessionRepository({required this.databaseProvider});

  Future<void> createDatabase() async {
    await databaseProvider.createTables();
  }

  Future<void> updateIsLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogged', true);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLogged') ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogged', false);
  }
}

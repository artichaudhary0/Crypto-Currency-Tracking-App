import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> saveTheme(String theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString("theme", theme);
    return result;
  }

  static Future<String?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? currenTheme = sharedPreferences.getString("theme");
    return currenTheme;
  }

  static Future<bool> saveFav(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> fav = sharedPreferences.getStringList("fav") ?? [];
    fav.add(id);
    return await sharedPreferences.setStringList("fav", fav);
  }

  static Future<bool> removefav(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> fav = sharedPreferences.getStringList("fav") ?? [];
    fav.remove(id);
    return await sharedPreferences.setStringList("fav", fav);
  }

  static Future<List<String>> fetchfav() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList("fav") ?? [];
  }
}

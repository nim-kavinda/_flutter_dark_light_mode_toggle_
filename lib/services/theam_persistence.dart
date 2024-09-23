import 'package:shared_preferences/shared_preferences.dart';

class TheamPersistence {
  //Store the users saved theams in shared preference

  Future<void> storeTheam(bool isDark) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool("isDark", isDark);
    print("Theam Stored");
  }

  //load the users saved theam from shared prefrences
  Future<bool> loadtheam() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("Theam Loaded");
    return preferences.getBool("isDark") ?? false;
  }
}

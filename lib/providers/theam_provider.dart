import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wether_app/services/theam_persistence.dart';
import 'package:wether_app/utils/teams.dart';

class TheamProvider extends ChangeNotifier {
  ThemeData _themeData = ThemeDataModes().lightTheme;

  TheamProvider() {
    _loadTheam();
  }

  final TheamPersistence _theamPersistence = TheamPersistence();

  //getter
  ThemeData get getThemeData => _themeData;

  //setter
  set setTheamData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  //load the theam from shared prefrnces
  Future<void> _loadTheam() async {
    bool isDark = await _theamPersistence.loadtheam();
    setTheamData =
        isDark ? ThemeDataModes().darkTheme : ThemeDataModes().lightTheme;
  }

  //toggle theme
  Future<void> togleTheme(bool isDark) async {
    setTheamData =
        isDark ? ThemeDataModes().darkTheme : ThemeDataModes().lightTheme;

    await _theamPersistence.storeTheam(isDark);
    notifyListeners();
  }
}

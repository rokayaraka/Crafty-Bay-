import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider extends ChangeNotifier {
  Locale _currentLocal = Locale('en');

  final List<Locale> _locals = [Locale('en'), Locale('bn')];

  List<Locale> get supportedLocales => _locals;
  Locale get currentLocale => _currentLocal;

  void changeThemeMode(Locale locale) {
    _currentLocal = locale;
    _saveLocale(locale);
    notifyListeners();
  }

  Future<void> _saveLocale(Locale locale) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('locale-mode', locale.languageCode);
  }

  Future<void> setDefaultLocale() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? locale = sharedPreferences.getString('locale-mode');
    if (locale != null) {
      _currentLocal = Locale(locale);
    }
  }
}

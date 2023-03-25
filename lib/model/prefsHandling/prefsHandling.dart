import 'package:shared_preferences/shared_preferences.dart';

class PrefsHandling {
  PrefsHandling._privateConstructor();
  static final PrefsHandling _instance = PrefsHandling._privateConstructor();
  late SharedPreferences _sharedPreferences;
  void setSharedPreferences(SharedPreferences prefs) {
    _sharedPreferences = prefs;
  }

  SharedPreferences getSharedPreferences() {
    return _sharedPreferences;
  }

  factory PrefsHandling() {
    return _instance;
  }

  Future setPublicAndPrivateKey(String publicKey, String privateKey) async {
    await _sharedPreferences.setString("publicKey", publicKey);
    await _sharedPreferences.setString("privateKey", privateKey);
  }

  Future setIsDarkMode(bool isDarkMode) async {
    await _sharedPreferences.setBool("isDarkMode", isDarkMode);
  }

  Future setIsIntroComplete(bool isIntroComplete) async {
    await _sharedPreferences.setBool("isIntroComplete", isIntroComplete);
  }

  bool getIsDarkMode() {
    if (_sharedPreferences.getBool("isDarkMode") == null ||
        !_sharedPreferences.getBool("isDarkMode")!) {
      return false;
    }
    return true;
  }

  bool getIsIntroComplete() {
    if (_sharedPreferences.getBool("isIntroComplete") == null ||
        _sharedPreferences.getBool("isIntroComplete")! == false) {
      return false;
    }
    return true;
  }
}

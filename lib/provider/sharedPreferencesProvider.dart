import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;

  SharedPreferencesProvider(this.sharedPreferences);

  SharedPreferences get prefs => sharedPreferences;
}

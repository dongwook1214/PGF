import 'package:context_menus/context_menus.dart';
import 'package:cryptofile/screen/Introduction/IntroScreen.dart';
import 'package:cryptofile/controller/provider/accountProvider.dart';
import 'package:cryptofile/controller/provider/darkModeProvider.dart';
import 'package:cryptofile/controller/provider/localDatabaseProvider.dart';
import 'package:cryptofile/controller/provider/sharedPreferencesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/mainPage/mainPage.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSharedPreference(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AccountProvider()),
              ChangeNotifierProvider(
                  create: (_) => SharedPreferencesProvider(snapshot.data!)),
              ChangeNotifierProvider(
                  create: (_) => DarkModeProvider(isDarkMode(snapshot.data!))),
              //ChangeNotifierProvider(create: (_) => LocalDatabaseProvider())
            ],
            child: Consumer<DarkModeProvider>(
              builder: (context, value, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'PGF',
                  theme: FlexThemeData.light(scheme: FlexScheme.brandBlue),
                  darkTheme: FlexThemeData.dark(scheme: FlexScheme.brandBlue),
                  themeMode:
                      value.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                  home: snapshot.data!.getBool('isIntroComplete') != true
                      ? IntroScreen()
                      : ContextMenuOverlay(child: const MainPage()),
                );
              },
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  bool isDarkMode(SharedPreferences pref) {
    if (pref.getBool("isDarkMode") == null || !pref.getBool("isDarkMode")!) {
      return false;
    }
    return true;
  }

  Future<SharedPreferences> getSharedPreference() async {
    print("load prefs...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}

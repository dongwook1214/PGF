import 'package:context_menus/context_menus.dart';
import 'package:cryptofile/view/Introduction/IntroScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/prefsHandling/prefsHandling.dart';
import 'view/mainPage/mainPage.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:cryptofile/view_model/getx/from_model/accountGetX.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSharedPreference(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          PrefsHandling prefsHandling = PrefsHandling();
          prefsHandling.setSharedPreferences(snapshot.data!);
          Get.put(AccountGetX());
          Get.find<AccountGetX>().login();
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'PGF',
            theme: FlexThemeData.light(scheme: FlexScheme.brandBlue),
            darkTheme: FlexThemeData.dark(scheme: FlexScheme.brandBlue),
            themeMode: prefsHandling.getIsDarkMode()
                ? ThemeMode.dark
                : ThemeMode.light,
            home: prefsHandling.getIsIntroComplete()
                ? ContextMenuOverlay(child: const MainPage())
                : IntroScreen(),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<SharedPreferences> getSharedPreference() async {
    print("load prefs...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}

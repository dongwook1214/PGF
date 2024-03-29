import 'package:cryptofile/model/prefsHandling/prefsHandling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slidable_button/slidable_button.dart';
import '../designClass/titleAndDescriptionFormat.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late ColorScheme scheme;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: scheme.onBackground,
          ),
        ),
        title: Text(
          "setting",
          style: TextStyle(color: scheme.onBackground),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: width * 0.025, right: width * 0.025),
        child: Column(
          children: [
            darkModeListTile(),
          ],
        ),
      ),
    );
  }

  Widget darkModeListTile() {
    return TitleAndDescriptionFormat(
      iconData: Icons.dark_mode_outlined,
      title: "dark mode",
      description: "Slide right to launch dark mode",
      actionWidget: _darkModeButton(),
    );
  }

  Widget _darkModeButton() {
    PrefsHandling prefsHandling = PrefsHandling();

    return HorizontalSlidableButton(
      initialPosition: prefsHandling.getIsDarkMode()
          ? SlidableButtonPosition.end
          : SlidableButtonPosition.start,
      width: MediaQuery.of(context).size.width * 0.15,
      buttonWidth: MediaQuery.of(context).size.width * 0.075,
      height: 30,
      border: Border.all(
        width: 1.5,
        color: scheme.onBackground,
      ),
      buttonColor: scheme.onBackground,
      onChanged: (position) async {
        if (position == SlidableButtonPosition.end) {
          PrefsHandling prefsHandling = PrefsHandling();
          await prefsHandling.setIsDarkMode(true);
          Get.changeThemeMode(ThemeMode.dark);
        } else {
          PrefsHandling prefsHandling = PrefsHandling();
          await prefsHandling.setIsDarkMode(false);
          Get.changeThemeMode(ThemeMode.light);
        }
      },
    );
  }
}

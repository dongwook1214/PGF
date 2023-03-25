import 'package:cryptofile/model/prefsHandling/prefsHandling.dart';
import 'package:cryptofile/view/mainPage/mainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  // 1. Define a `GlobalKey` as part of the parent widget's state
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    ColorScheme scheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Container(
        color: scheme.background,
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.1),
          child: IntroductionScreen(
            isTopSafeArea: true,
            isBottomSafeArea: true,
            key: _introKey,
            pages: [
              PageViewModel(
                title:
                    'Currently, in normal apps, the developer or the manager of the app has the right to control all data in the database.',
                image: const Image(image: AssetImage("images/intro0.png")),
                bodyWidget: Column(),
              ),
              PageViewModel(
                title:
                    'Even the personal things you say to your friends via Messenger and the diary you write every night in your diary app are all stored in the database.',
                image: const Image(image: AssetImage("images/intro1.png")),
                bodyWidget: Column(),
              ),
              PageViewModel(
                title:
                    'These private data are often used for better management by analyzing users. These days, it is also used to train AI or provide secondary services.',
                image: const Image(image: AssetImage("images/intro2.png")),
                bodyWidget: Column(),
              ),
              PageViewModel(
                title:
                    'Maybe a developer with a bad heart is looking at your data, just for fun.',
                image: const Image(image: AssetImage("images/intro4.png")),
                bodyWidget: Column(),
              ),
              PageViewModel(
                title:
                    'So we need an encryption system. If only the user knows the key to decrypt, you dont have to worry about someone stealing your valuable data.',
                image: const Image(image: AssetImage("images/intro3.png")),
                bodyWidget: Column(),
              ),
              PageViewModel(
                title:
                    'So we made this app called Crypty. Start your journey to protect your precious data!',
                image: const Image(image: AssetImage("images/intro5.png")),
                bodyWidget: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        PrefsHandling prefsHandling = PrefsHandling();
                        prefsHandling.setIsIntroComplete(true);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                            (route) => false);
                      },
                      child: const Text("start!"),
                    ),
                  ],
                ),
              ),
            ],
            showNextButton: false,
            showDoneButton: false,
          ),
        ),
      ),
    );
  }
}

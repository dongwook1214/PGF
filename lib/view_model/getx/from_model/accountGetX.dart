import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/model/prefsHandling/prefsHandling.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountGetX extends GetxController {
  RSAKeyPairClass? myAccount = null;

  void login() {
    PrefsHandling prefsHandling = PrefsHandling();
    SharedPreferences prefs = prefsHandling.getSharedPreferences();
    String? publicKey = prefs.getString("publicKey");
    String? privateKey = prefs.getString("privateKey");

    if (publicKey == null || privateKey == null) {
      myAccount = null;
    } else {
      myAccount = RSAKeyPairClass.fromPems(publicKey, privateKey);
    }

    print("init login finish");
    print(
        "login info: ${myAccount == null ? "null" : myAccount!.getCompressedPublicKeyString()}");
    update();
  }

  Future logOut() async {
    PrefsHandling prefsHandling = PrefsHandling();
    SharedPreferences prefs = prefsHandling.getSharedPreferences();
    await prefs.remove("publicKey");
    await prefs.remove("privateKey");
    login();
  }
}

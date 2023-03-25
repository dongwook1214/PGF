import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/model/prefsHandling/prefsHandling.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountGetX extends GetxController {
  Rx<RSAKeyPairClass?> myAccount = null.obs;

  void initLogin() {
    PrefsHandling prefsHandling = PrefsHandling();
    SharedPreferences prefs = prefsHandling.getSharedPreferences();
    String? publicKey = prefs.getString("publicKey");
    String? privateKey = prefs.getString("privateKey");

    myAccount = publicKey != null
        ? RSAKeyPairClass.fromPems(publicKey, privateKey!).obs
        : null.obs;
    print("init login finish");
    print(
        "login info: ${myAccount.value == null ? "null" : myAccount.value!.getCompressedPublicKeyString()}");
  }

  void login() {
    PrefsHandling prefsHandling = PrefsHandling();
    SharedPreferences prefs = prefsHandling.getSharedPreferences();
    initLogin();
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

import 'package:cryptofile/crypto/cryptoClass.dart';
import 'package:flutter/material.dart';
import 'package:cryptofile/crypto/RSAKeyPairClass.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

class AccountProvider with ChangeNotifier {
  RSAKeyPairClass? _myAccount;

  RSAKeyPairClass? get myAccount => _myAccount;

  void initLogin(SharedPreferences prefs) {
    String? publicKey = prefs.getString("publicKey");
    String? privateKey = prefs.getString("privateKey");

    _myAccount = publicKey != null
        ? RSAKeyPairClass.fromPems(publicKey, privateKey!)
        : null;
    print("init login finish");
    print("login info: " +
        (_myAccount == null ? "null" : _myAccount!.getPublicKeyString()));
  }

  void login(SharedPreferences prefs) {
    String? publicKey = prefs.getString("publicKey");
    String? privateKey = prefs.getString("privateKey");

    _myAccount = publicKey != null
        ? RSAKeyPairClass.fromPems(publicKey, privateKey!)
        : null;
    print("login fisish");
    print("login info: " +
        (_myAccount == null ? "null" : _myAccount!.getPublicKeyString()));
    notifyListeners();
  }

  Future logOut(SharedPreferences prefs) async {
    await prefs.remove("publicKey");
    await prefs.remove("privateKey");
    login(prefs);
  }
}

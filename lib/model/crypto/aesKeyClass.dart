import 'dart:typed_data';
import 'package:aes_crypt/aes_crypt.dart';
import 'dart:math';

class AesKeyClass {
  late AesCrypt crypt;
  late Uint8List key;
  late Uint8List iv;

  AesKeyClass({required this.crypt});
  AesKeyClass.fromString(String keyString, String ivString) {
    crypt = AesCrypt();
    key = Uint8List.fromList(keyString.codeUnits);
    iv = Uint8List.fromList(ivString.codeUnits);
    crypt.aesSetKeys(key, iv);
  }
  AesKeyClass.fromRandom() {
    crypt = AesCrypt();
    Random random = Random.secure();
    key =
        Uint8List.fromList(List<int>.generate(32, (i) => random.nextInt(256)));
    iv = Uint8List.fromList(List<int>.generate(16, (i) => random.nextInt(256)));
    print(key);
    print(iv);
    crypt.aesSetKeys(key, iv);
  }
}

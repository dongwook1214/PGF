import 'dart:typed_data';
import 'package:aes_crypt/aes_crypt.dart';
import 'dart:math';

class AesKeyClass {
  late AesCrypt crypt;
  late Uint8List key;
  late Uint8List iv;

  AesKeyClass({required this.crypt});
  AesKeyClass.fromString(String aesKeyString) {
    List<int> aesKeyStringList = aesKeyString.codeUnits;
    crypt = AesCrypt();
    crypt.aesSetMode(AesMode.cbc);
    print(aesKeyStringList.sublist(0, 32));
    print("length: " + aesKeyStringList.sublist(0, 32).length.toString());
    print(aesKeyStringList.sublist(32));
    print("length: " + aesKeyStringList.sublist(32).length.toString());
    key = Uint8List.fromList(aesKeyStringList.sublist(0, 32));
    iv = Uint8List.fromList(aesKeyStringList.sublist(32));
    crypt.aesSetKeys(key, iv);
  }
  AesKeyClass.fromRandom() {
    crypt = AesCrypt();
    crypt.aesSetMode(AesMode.cbc);
    Random random = Random.secure();
    key =
        Uint8List.fromList(List<int>.generate(32, (i) => random.nextInt(256)));
    iv = Uint8List.fromList(List<int>.generate(16, (i) => random.nextInt(256)));
    print(key);
    print(iv);
    crypt.aesSetKeys(key, iv);
  }
  String getAesKeyString() {
    List<int> list = key.toList() + iv.toList();
    return String.fromCharCodes(list);
  }
}

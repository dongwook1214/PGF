import 'package:cryptofile/model/crypto/aesKeyClass.dart';
import 'package:cryptofile/model/crypto/cryptoClass.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<int> key = [
    148,
    123,
    94,
    136,
    184,
    120,
    87,
    210,
    4,
    43,
    85,
    121,
    86,
    191,
    166,
    235,
    163,
    151,
    175,
    234,
    146,
    246,
    209,
    71,
    156,
    143,
    204,
    58,
    220,
    75,
    78,
    58
  ];
  List<int> iv = [
    89,
    77,
    115,
    58,
    236,
    78,
    219,
    205,
    189,
    209,
    252,
    105,
    26,
    138,
    207,
    8
  ];
  String aesKeyString = String.fromCharCodes(key + iv);
  test('make key test', () async {
    AesKeyClass aesKey = AesKeyClass.fromRandom();
  });

  test("keyString test", () {
    AesKeyClass aesKey = AesKeyClass.fromRandom();
    String str = aesKey.getAesKeyString();
    AesKeyClass aesKey2 = AesKeyClass.fromString(str);
    expect(aesKey2.iv, aesKey.iv);
    expect(aesKey2.key, aesKey.key);
  });

  test('encrypt test', () {
    AesKeyClass aesKey = AesKeyClass.fromString(aesKeyString);
    String encrypted = CryptoClass.symmetricEncryptData(aesKey, "test" * 4);
    print(encrypted);
    expect(encrypted.isNotEmpty, true);
  });

  test("decrypt test", () {
    String encrypted = "C9bMD82L1ggfrpm3jkJwnp";
    AesKeyClass aesKey = AesKeyClass.fromString(aesKeyString);
    String decrypted = CryptoClass.symmetricDecryptData(aesKey, encrypted);
    print(decrypted);
    expect(decrypted, "test" * 4);
  });

  test("encryptAndDecrypt", () {
    String text = "hi동욱" * 2;
    AesKeyClass aesKey = AesKeyClass.fromString(aesKeyString);
    String encrypted = CryptoClass.symmetricEncryptData(aesKey, text);
    String decrypted = CryptoClass.symmetricDecryptData(aesKey, encrypted);
    print(decrypted);
    expect(text, decrypted);
  });
}

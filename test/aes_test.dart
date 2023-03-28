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
  test('make key test', () async {
    AesKeyClass aesKey = AesKeyClass.fromRandom();
  });

  test('encrypt test', () {
    AesKeyClass aesKey = AesKeyClass.fromString(
        String.fromCharCodes(key), String.fromCharCodes(iv));
    String encrypted = CryptoClass.symmetricEncryptData(aesKey, "test" * 4);
    expect(encrypted.length % 16, 0);
  });

  test("decrypt test", () {
    String encrypted = String.fromCharCodes([
      90,
      71,
      164,
      181,
      94,
      23,
      251,
      12,
      16,
      63,
      198,
      57,
      192,
      238,
      238,
      17
    ]);
    AesKeyClass aesKey = AesKeyClass.fromString(
        String.fromCharCodes(key), String.fromCharCodes(iv));
    String decrypted = CryptoClass.symmetricDecryptData(aesKey, encrypted);
    print(decrypted);
    expect(decrypted, "test" * 4);
  });

  test("encryptAndDecrypt", () {
    String text = "hi동욱" * 2;
    AesKeyClass aesKey = AesKeyClass.fromString(
        String.fromCharCodes(key), String.fromCharCodes(iv));
    String encrypted = CryptoClass.symmetricEncryptData(aesKey, text);
    String decrypted = CryptoClass.symmetricDecryptData(aesKey, encrypted);
    print(decrypted);
    expect(text, decrypted);
  });
}

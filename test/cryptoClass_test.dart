import 'package:crypto/crypto.dart';
import 'package:cryptofile/crypto/cryptoKeyPair.dart';
import 'package:flutter_test/flutter_test.dart';
import "package:cryptofile/crypto/cryptoClass.dart";
import 'package:rsa_encrypt/rsa_encrypt.dart';

void main() {
  test('비대칭 암호화 테스트', () async {
    String longText = "dfs";
    print(longText.length);
    CryptoKeyPair keyPair = await CryptoClass.createKeyPair();
    String encrypted =
        CryptoClass.asymmetricEncryptData(keyPair.publicKey, longText);
    String decrypted =
        CryptoClass.asymmetricDecryptData(keyPair.privateKey, encrypted);
    print(decrypted);
  });

  test('test', () async {
    String plainText = "d" * 255;
    CryptoKeyPair keyPair = await CryptoClass.createKeyPair();
    print(keyPair.getPrivateKeyString());
    print(keyPair.getPublicKeyString());
    print(keyPair.getPrivateKeyString().length);
    print(keyPair.getPublicKeyString().length);
    print(decrypt(encrypt(plainText, keyPair.publicKey), keyPair.privateKey) ==
        plainText);
  });

  test('sha256 test', () async {
    print(CryptoClass.sha256hash("fsdfsgjyghgjhgjh"));
  });
}

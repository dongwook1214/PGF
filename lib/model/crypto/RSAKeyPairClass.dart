import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart' as pointycastleCrypto;
import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:bs58/bs58.dart';

class RSAKeyPairClass {
  late pointycastleCrypto.RSAPrivateKey privateKey;
  late pointycastleCrypto.RSAPublicKey publicKey;

  RSAKeyPairClass(this.privateKey, this.publicKey);
  RSAKeyPairClass.fromPems(String public, String private) {
    RsaKeyHelper helper = RsaKeyHelper();
    privateKey = helper.parsePrivateKeyFromPem(private);
    publicKey = helper.parsePublicKeyFromPem(public);
  }

  static Future<RSAKeyPairClass> createKeyPair() async {
    RsaKeyHelper helper = RsaKeyHelper();
    pointycastleCrypto.AsymmetricKeyPair<pointycastleCrypto.PublicKey,
            pointycastleCrypto.PrivateKey> keyPair =
        await helper.computeRSAKeyPair(helper.getSecureRandom());
    RSAKeyPairClass cryptoKeyPair = RSAKeyPairClass(
        keyPair.privateKey as pointycastleCrypto.RSAPrivateKey,
        keyPair.publicKey as pointycastleCrypto.RSAPublicKey);
    return cryptoKeyPair;
  }

  String getCompressedPublicKeyString() {
    List<int> bytes = getPublicKeyString().codeUnits;
    crypto.Digest digest = crypto.sha256.convert(bytes);
    return base58.encode(Uint8List.fromList(digest.bytes));
  }

  String getPrivateKeyString() {
    RsaKeyHelper helper = RsaKeyHelper();
    return helper.encodePrivateKeyToPemPKCS8(privateKey);
  }

  String getPublicKeyString() {
    RsaKeyHelper helper = RsaKeyHelper();
    return helper.encodePublicKeyToPemPKCS8(publicKey);
  }

  String getPublicKeyBase58() {
    return base58.encode(Uint8List.fromList(getPublicKeyString().codeUnits));
  }

  String getPublicKeyModulusExponent() {
    return "${publicKey.modulus}and${publicKey.exponent}";
  }

  bool isKeyPairValid() {
    String encryptedValid = encrypt("validity", publicKey);
    String decryptedValid = decrypt(encryptedValid, privateKey);
    return decryptedValid == "validity";
  }
}

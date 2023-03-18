import 'dart:convert';
import 'package:pointycastle/export.dart' as pointycastleCrypto;
import 'package:rsa_encrypt/rsa_encrypt.dart';

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

  String getPrivateKeyString() {
    RsaKeyHelper helper = RsaKeyHelper();
    return helper.encodePrivateKeyToPemPKCS8(privateKey);
  }

  String getPublicKeyString() {
    RsaKeyHelper helper = RsaKeyHelper();
    return helper.encodePublicKeyToPemPKCS8(publicKey);
  }

  String getPrivateKeyBase64Pem() {
    RsaKeyHelper helper = RsaKeyHelper();
    String pem = helper.encodePrivateKeyToPemPKCS1(privateKey);
    return base64Encode(helper.removePemHeaderAndFooter(pem).codeUnits);
  }

  bool isKeyPairValid() {
    String encryptedValid = encrypt("validity", publicKey);
    String decryptedValid = decrypt(encryptedValid, privateKey);
    return decryptedValid == "validity";
  }
}

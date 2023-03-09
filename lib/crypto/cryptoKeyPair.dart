import 'package:pointycastle/export.dart' as crypto;
import 'package:rsa_encrypt/rsa_encrypt.dart';

class CryptoKeyPair {
  CryptoKeyPair(this.privateKey, this.publicKey);
  crypto.RSAPrivateKey privateKey;
  crypto.RSAPublicKey publicKey;
  String getPrivateKeyString() {
    var helper = RsaKeyHelper();

    return helper.encodePrivateKeyToPemPKCS1(privateKey);
  }

  String getPublicKeyString() {
    var helper = RsaKeyHelper();
    return helper.encodePublicKeyToPemPKCS1(publicKey);
  }

  static CryptoKeyPair getCryptoKeyPairFromPems(String public, String private) {
    RsaKeyHelper helper = RsaKeyHelper();
    return CryptoKeyPair(helper.parsePrivateKeyFromPem(private),
        helper.parsePublicKeyFromPem(public));
  }
}

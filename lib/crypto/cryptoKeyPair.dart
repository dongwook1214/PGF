import 'dart:convert';
import 'package:pointycastle/export.dart' as crypto;
import 'package:rsa_encrypt/rsa_encrypt.dart';

class CryptoKeyPair {
  CryptoKeyPair(this.privateKey, this.publicKey);
  crypto.RSAPrivateKey privateKey;
  crypto.RSAPublicKey publicKey;
  String getPrivateKeyString() {
    RsaKeyHelper helper = RsaKeyHelper();
    return helper.encodePrivateKeyToPemPKCS8(privateKey);
    //return helper.encodePrivateKeyToPemPKCS1(privateKey);
  }

  String getPublicKeyString() {
    RsaKeyHelper helper = RsaKeyHelper();
    return helper.encodePublicKeyToPemPKCS8(publicKey);
  }

  static CryptoKeyPair getCryptoKeyPairFromPems(String public, String private) {
    RsaKeyHelper helper = RsaKeyHelper();
    return CryptoKeyPair(helper.parsePrivateKeyFromPem(private),
        helper.parsePublicKeyFromPem(public));
  }

  String getPrivateKeyBase64Pem() {
    RsaKeyHelper helper = RsaKeyHelper();
    String pem = helper.encodePrivateKeyToPemPKCS1(privateKey);
    return base64Encode(removePemHeaderAndFooter(pem).codeUnits);
  }

  String getPublicKeyBase64Pem() {
    RsaKeyHelper helper = RsaKeyHelper();
    String pem = helper.encodePublicKeyToPemPKCS1(publicKey);
    return base64Encode(removePemHeaderAndFooter(pem).codeUnits);
  }

  String removePemHeaderAndFooter(String pem) {
    var startsWith = [
      "-----BEGIN PUBLIC KEY-----",
      "-----BEGIN RSA PRIVATE KEY-----",
      "-----BEGIN RSA PUBLIC KEY-----",
      "-----BEGIN PRIVATE KEY-----",
      "-----BEGIN PGP PUBLIC KEY BLOCK-----\r\nVersion: React-Native-OpenPGP.js 0.1\r\nComment: http://openpgpjs.org\r\n\r\n",
      "-----BEGIN PGP PRIVATE KEY BLOCK-----\r\nVersion: React-Native-OpenPGP.js 0.1\r\nComment: http://openpgpjs.org\r\n\r\n",
    ];
    var endsWith = [
      "-----END PUBLIC KEY-----",
      "-----END PRIVATE KEY-----",
      "-----END RSA PRIVATE KEY-----",
      "-----END RSA PUBLIC KEY-----",
      "-----END PGP PUBLIC KEY BLOCK-----",
      "-----END PGP PRIVATE KEY BLOCK-----",
    ];
    bool isOpenPgp = pem.indexOf('BEGIN PGP') != -1;

    pem = pem.replaceAll(' ', '');
    pem = pem.replaceAll('\n', '');
    pem = pem.replaceAll('\r', '');

    for (var s in startsWith) {
      s = s.replaceAll(' ', '');
      if (pem.startsWith(s)) {
        pem = pem.substring(s.length);
      }
    }

    for (var s in endsWith) {
      s = s.replaceAll(' ', '');
      if (pem.endsWith(s)) {
        pem = pem.substring(0, pem.length - s.length);
      }
    }

    if (isOpenPgp) {
      var index = pem.indexOf('\r\n');
      pem = pem.substring(0, index);
    }

    return pem;
  }
}

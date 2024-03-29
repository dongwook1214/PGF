import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:aes_crypt/aes_crypt.dart';
import 'package:bs58/bs58.dart';
import 'package:convert/convert.dart';
import 'package:cryptofile/model/crypto/aesKeyClass.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:pointycastle/export.dart' as pointycastleCrypto;
import 'package:crypto/crypto.dart' as crypto;

class CryptoClass {
  static String asymmetricEncryptData(
      pointycastleCrypto.RSAPublicKey publicKey, String plainText) {
    String utf8PlainText = _toUtf8(plainText);
    int i = 0;
    int subNum = utf8PlainText.length ~/ 256;
    String encryptedText = "";
    for (i; i < subNum; ++i) {
      String stringToEncrypt = utf8PlainText.substring(i * 256, i * 256 + 256);
      encryptedText += encrypt(stringToEncrypt, publicKey);
    }
    if (utf8PlainText.length % 256 != 0) {
      String stringToEncrypt = utf8PlainText.substring(i * 256);
      encryptedText += encrypt(stringToEncrypt, publicKey);
    }
    encryptedText = base58.encode(Uint8List.fromList(encryptedText.codeUnits));
    return encryptedText;
  }

  static String asymmetricEncryptDataFromPem(
      String publicKeyPem, String plainText) {
    String utf8PlainText = _toUtf8(plainText);
    RsaKeyHelper helper = RsaKeyHelper();
    pointycastleCrypto.RSAPublicKey publicKey =
        helper.parsePublicKeyFromPem(publicKeyPem);

    int i = 0;
    int subNum = utf8PlainText.length ~/ 256;
    String encryptedText = "";
    for (i; i < subNum; ++i) {
      String stringToEncrypt = utf8PlainText.substring(i * 256, i * 256 + 256);
      encryptedText += encrypt(stringToEncrypt, publicKey);
    }
    if (utf8PlainText.length % 256 != 0) {
      String stringToEncrypt = utf8PlainText.substring(i * 256);
      encryptedText += encrypt(stringToEncrypt, publicKey);
    }
    encryptedText = base58.encode(Uint8List.fromList(encryptedText.codeUnits));
    return encryptedText;
  }

  static String asymmetricDecryptData(
      pointycastleCrypto.RSAPrivateKey privateKey, String encryptedTextbase58) {
    String encryptedText =
        String.fromCharCodes(base58.decode(encryptedTextbase58));
    int subNum = encryptedText.length ~/ 256;
    print(subNum);
    String decryptedText = "";
    for (int i = 0; i < subNum; ++i) {
      String stringToDecrypt = encryptedText.substring(i * 256, i * 256 + 256);
      decryptedText += decrypt(stringToDecrypt, privateKey);
    }

    return _toUtf16(decryptedText);
  }

  static String asymmetricDecryptDataFromPem(
      String privateKeyPem, String encryptedTextbase58) {
    String encryptedText =
        String.fromCharCodes(base58.decode(encryptedTextbase58));
    RsaKeyHelper helper = RsaKeyHelper();
    pointycastleCrypto.RSAPrivateKey privateKey =
        helper.parsePrivateKeyFromPem(privateKeyPem);
    int subNum = encryptedText.length ~/ 256;
    print(subNum);
    String decryptedText = "";
    for (int i = 0; i < subNum; ++i) {
      String stringToDecrypt = encryptedText.substring(i * 256, i * 256 + 256);
      decryptedText += decrypt(stringToDecrypt, privateKey);
    }
    return _toUtf16(decryptedText);
  }

  static List<int> makeSign(
      String plainText, pointycastleCrypto.RSAPrivateKey privateKey) {
    RsaKeyHelper helper = RsaKeyHelper();
    Uint8List sign = helper.sign(plainText, privateKey);
    return sign;
  }

  static List<int> makeSignFromPem(String plainText, String privateKeyPem) {
    RsaKeyHelper helper = RsaKeyHelper();
    pointycastleCrypto.RSAPrivateKey privateKey =
        helper.parsePrivateKeyFromPem(privateKeyPem);
    Uint8List sign = helper.sign(plainText, privateKey);
    return sign;
  }

  static String symmetricEncryptData(AesKeyClass key, String plainText) {
    if (plainText.isEmpty) return "";
    AesCrypt crypt = key.crypt;
    String utf8PlainText = _toUtf8(plainText);
    Uint8List encrypted =
        crypt.aesEncrypt(padding(Uint8List.fromList(utf8PlainText.codeUnits)));
    return base58.encode(encrypted);
  }

  static String symmetricDecryptData(
      AesKeyClass key, String encryptedTextbase58) {
    if (encryptedTextbase58.isEmpty) return "";
    Uint8List encryptedText = base58.decode(encryptedTextbase58);
    AesCrypt crypt = key.crypt;
    String decrypted = String.fromCharCodes(crypt.aesDecrypt(encryptedText));
    return removePadding(_toUtf16(decrypted));
  }

  static Uint8List padding(Uint8List list) {
    List<int> copiedList = List.from(list);
    while (copiedList.length % 16 != 0) {
      copiedList.add(0);
    }
    return Uint8List.fromList(copiedList);
  }

  static String removePadding(String str) {
    if (!str.contains(String.fromCharCode(0))) {
      return str;
    }

    return str.substring(0, str.indexOf(String.fromCharCode(0)));
  }

  static String _toUtf8(String utf16Str) {
    Uint8List uint8list = Uint8List.fromList(utf8.encode(utf16Str));
    return String.fromCharCodes(uint8list);
  }

  static String _toUtf16(String utf8Str) {
    String utf16Str = utf8.decode(utf8Str.codeUnits);
    return utf16Str;
  }
}

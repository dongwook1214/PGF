import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:aes_crypt/aes_crypt.dart';
import 'package:convert/convert.dart';
import 'package:cryptofile/crypto/aesKeyClass.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:pointycastle/export.dart' as pointycastleCrypto;
import 'package:crypto/crypto.dart' as crypto;

class CryptoClass {
  static String asymmetricEncryptData(
      pointycastleCrypto.RSAPublicKey publicKey, String plainText) {
    int i = 0;
    int subNum = plainText.length ~/ 256;
    String encryptedText = "";
    for (i; i < subNum; ++i) {
      String stringToEncrypt = plainText.substring(i * 256, i * 256 + 256);
      encryptedText += encrypt(stringToEncrypt, publicKey);
    }
    if (plainText.length % 256 != 0) {
      String stringToEncrypt = plainText.substring(i * 256);
      encryptedText += encrypt(stringToEncrypt, publicKey);
    }
    return encryptedText;
  }

  static String asymmetricEncryptDataFromPem(
      String publicKeyPem, String plainText) {
    RsaKeyHelper helper = RsaKeyHelper();
    pointycastleCrypto.RSAPublicKey publicKey =
        helper.parsePublicKeyFromPem(publicKeyPem);
    int i = 0;
    int subNum = plainText.length ~/ 256;
    String encryptedText = "";
    for (i; i < subNum; ++i) {
      String stringToEncrypt = plainText.substring(i * 256, i * 256 + 256);
      encryptedText += encrypt(stringToEncrypt, publicKey);
    }
    if (plainText.length % 256 != 0) {
      String stringToEncrypt = plainText.substring(i * 256);
      encryptedText += encrypt(stringToEncrypt, publicKey);
    }
    return encryptedText;
  }

  static String asymmetricDecryptData(
      pointycastleCrypto.RSAPrivateKey privateKey, String encryptedText) {
    int subNum = encryptedText.length ~/ 256;
    print(subNum);
    String decryptedText = "";
    for (int i = 0; i < subNum; ++i) {
      String stringToDecrypt = encryptedText.substring(i * 256, i * 256 + 256);
      decryptedText += decrypt(stringToDecrypt, privateKey);
    }
    return decryptedText;
  }

  static String asymmetricDecryptDataFromPem(
      String privateKeyPem, String encryptedText) {
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
    return decryptedText;
  }

  static String symmetricEncryptData(AesKeyClass key, String plainText) {
    AesCrypt crypt = key.crypt;
    String encrypted = String.fromCharCodes(
        crypt.aesEncrypt(Uint8List.fromList(plainText.codeUnits)));
    return encrypted;
  }

  static String symmetricDecryptData(AesKeyClass key, String encryptedText) {
    AesCrypt crypt = key.crypt;
    String decrypted = String.fromCharCodes(
        crypt.aesDecrypt(Uint8List.fromList(encryptedText.codeUnits)));
    return decrypted;
  }

  Future<Uint8List> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File file = new File.fromUri(myUri);
    Uint8List bytes = Uint8List(0);
    await file.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
          onError.toString());
    });
    return bytes;
  }
}

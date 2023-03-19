import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:convert/convert.dart';
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
    String encryptedText = encrypt(plainText, publicKey);
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
    String decryptedText = decrypt(encryptedText, privateKey);
    return decryptedText;
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

  static String sha256hash(String str) {
    List<int> bytes = utf8.encode(str);
    crypto.Digest digest = crypto.sha256.convert(bytes);
    return base64Encode(digest.bytes);
  }

  // RSAKeyPairClass keyPair = await CryptoClass.createKeyPair();
  //             pointycastleCrypto.RSAPrivateKey tempPrivateKey = keyPair.privateKey;
  //             pointycastleCrypto.RSAPublicKey tempPublicKey = keyPair.publicKey;

  //             Uint8List byteData = (await rootBundle.load("images/key.png"))
  //                 .buffer
  //                 .asUint8List();
  //             String str =
  //                 CryptoClass.encryptData(tempPublicKey, byteData.toString());
  //             String decodedStr = CryptoClass.decryptData(tempPrivateKey, str);
  //             List<int> tempDecrypt = json.decode(decodedStr).cast<int>();
  //             Uint8List t = Uint8List.fromList(tempDecrypt);
  //             Image _image = Image.memory(t);
}

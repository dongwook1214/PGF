import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:pointycastle/export.dart' as pointycastleCrypto;
import 'cryptoKeyPair.dart';
import 'package:crypto/crypto.dart' as crypto;

class CryptoClass {
  static CryptoKeyPair getKeyPairFromPems(String publicPem, String privatePem) {
    RsaKeyHelper helper = RsaKeyHelper();
    RSAPrivateKey privateKey = helper.parsePrivateKeyFromPem(privatePem);
    RSAPublicKey publicKey = helper.parsePublicKeyFromPem(publicPem);
    return CryptoKeyPair(privateKey, publicKey);
  }

  static Future<CryptoKeyPair> createKeyPair() async {
    RsaKeyHelper helper = RsaKeyHelper();
    pointycastleCrypto.AsymmetricKeyPair<pointycastleCrypto.PublicKey,
            pointycastleCrypto.PrivateKey> keyPair =
        await helper.computeRSAKeyPair(helper.getSecureRandom());
    CryptoKeyPair cryptoKeyPair = CryptoKeyPair(
        keyPair.privateKey as pointycastleCrypto.RSAPrivateKey,
        keyPair.publicKey as pointycastleCrypto.RSAPublicKey);
    return cryptoKeyPair;
  }

  static bool isKeyPairValid(CryptoKeyPair keyPair) {
    RsaKeyHelper helper = RsaKeyHelper();
    String encryptedValid = encrypt("validity", keyPair.publicKey);
    String decryptedValid = decrypt(encryptedValid, keyPair.privateKey);
    return decryptedValid == "validity";
  }

  static String asymmetricEncryptData(
      pointycastleCrypto.RSAPublicKey publicKey, String str) {
    int i = 0;
    int subNum = str.length ~/ 256;
    String encryptedText = "";
    for (i; i < subNum; ++i) {
      String stringToEncrypt = str.substring(i * 256, i * 256 + 256);
      encryptedText += encrypt(stringToEncrypt, publicKey);
    }
    if (str.length % 256 != 0) {
      String stringToEncrypt = str.substring(i * 256);
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

  // CryptoKeyPair keyPair = await CryptoClass.createKeyPair();
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

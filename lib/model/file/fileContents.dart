import 'package:cryptofile/model/crypto/aesKeyClass.dart';
import 'package:cryptofile/model/crypto/cryptoClass.dart';
import 'package:cryptofile/model/dto/fileContentsDTO.dart';

class FileContents {
  late String fileContents;
  FileContents({required this.fileContents});
  FileContents.fromDTO(FileContentsDTO dto, String aesKeyString) {
    AesKeyClass aesKeyClass = AesKeyClass.fromString(aesKeyString);
    fileContents =
        CryptoClass.symmetricDecryptData(aesKeyClass, dto.contentsEWS);
  }
}

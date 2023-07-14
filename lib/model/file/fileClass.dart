import 'package:cryptofile/model/crypto/aesKeyClass.dart';
import 'package:cryptofile/model/crypto/cryptoClass.dart';
import 'package:cryptofile/model/dto/fileDTO.dart';

class FileClass {
  late String folderCP;
  late String fileId;
  late DateTime lastChangedDate;
  late String subhead;

  FileClass(
    this.folderCP,
    this.fileId,
    this.lastChangedDate,
    this.subhead,
  );

  FileClass.fromDTO(FileDTO dto, String aesKey) {
    folderCP = dto.folderCP;
    fileId = dto.fileId;
    lastChangedDate = DateTime.parse(dto.lastChangedDate);
    subhead = CryptoClass.symmetricDecryptData(
        AesKeyClass.fromString(aesKey), dto.subheadEWS);
  }
}

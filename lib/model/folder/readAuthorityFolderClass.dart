import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/model/dto/readAuthorityFolderDTO.dart';
import 'package:cryptofile/model/folder/folderClass.dart';
import 'package:intl/intl.dart';

class ReadAuthorityFolderClass implements FolderClass {
  late String folderCP;
  late bool isTitleOpen;
  late String title;
  late String symmetricKey;
  late DateTime lastChangedDate;

  ReadAuthorityFolderClass(this.folderCP, this.isTitleOpen, this.title,
      this.symmetricKey, this.lastChangedDate);

  ReadAuthorityFolderClass.fromDTO(
      ReadAuthorityFolderDTO dto, RSAKeyPairClass keyPair) {
    folderCP = dto.folderCP;
    isTitleOpen = dto.isTitleOpen;
    title = dto.title;
    symmetricKey = dto.symmetricKeyEWA;
    lastChangedDate = DateTime.parse(dto.lastChangedDate);
  }

  @override
  String getPrivateKey() {
    return "don't have privateKey";
  }

  @override
  String getPublicKey() {
    return "don't have publicKey";
  }

  @override
  String getTitle() {
    return title;
  }

  @override
  String getFolderCP() {
    return folderCP;
  }

  @override
  String getLastChangedDate() {
    return DateFormat.yMMMd().format(lastChangedDate);
  }
}

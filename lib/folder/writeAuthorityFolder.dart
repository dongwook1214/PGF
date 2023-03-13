import 'package:cryptofile/folder/folder.dart';

class WriteAuthorityFolder implements Folder {
  final String folderCP;
  final String folderPublicKey;
  final String folderPrivateKeyEWA;
  final bool isTitleOpen;
  final String Title;
  final String symmetricKeyEWF;
  final int lastChangedDate;
  WriteAuthorityFolder(
      this.folderCP,
      this.folderPublicKey,
      this.folderPrivateKeyEWA,
      this.isTitleOpen,
      this.Title,
      this.symmetricKeyEWF,
      this.lastChangedDate);
}

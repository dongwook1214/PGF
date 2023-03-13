import 'package:cryptofile/folder/folder.dart';

class ReadAuthorityFolder implements Folder {
  final String folderCP;
  final bool isTitleOpen;
  final String Title;
  final String symmetricKeyEWA;
  final int lastChangedDate;

  ReadAuthorityFolder(this.folderCP, this.isTitleOpen, this.Title,
      this.symmetricKeyEWA, this.lastChangedDate);
}

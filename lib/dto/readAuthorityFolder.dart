import 'package:cryptofile/dto/folder.dart';

class ReadAuthorityFolder implements Folder {
  final String folderCP;
  final bool isTitleOpen;
  final String title;
  final String symmetricKeyEWA;
  final int lastChangedDate;

  ReadAuthorityFolder(this.folderCP, this.isTitleOpen, this.title,
      this.symmetricKeyEWA, this.lastChangedDate);
}

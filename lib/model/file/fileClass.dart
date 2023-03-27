import 'package:cryptofile/model/dto/fileDTO.dart';

class FileClass {
  late String folderCP;
  late String fileId;
  late DateTime lastChangedDate;
  late String subhead;
  late String contents;

  FileClass(this.folderCP, this.fileId, this.lastChangedDate, this.subhead,
      this.contents);

  FileClass.fromDTO(FileDTO dto) {
    folderCP = dto.folderCP;
    fileId = dto.fileId;
    lastChangedDate = DateTime.parse(dto.lastChangedDate);
    subhead = dto.subheadEWS;
    contents = dto.contentsEWS;
  }
}

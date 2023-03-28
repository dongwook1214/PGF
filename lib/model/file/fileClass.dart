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

  FileClass.fromDTO(FileDTO dto) {
    folderCP = dto.folderCP;
    fileId = dto.fileId;
    lastChangedDate = DateTime.parse(dto.lastChangedDate);
    subhead = dto.subheadEWS;
  }
}

import 'package:cryptofile/model/dto/fileContentsDTO.dart';

class FileContents {
  late String fileContents;
  FileContents({required this.fileContents});
  FileContents.fromDTO(FileContentsDTO dto) {
    fileContents = dto.contentsEWS;
  }
}

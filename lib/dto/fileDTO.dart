class FileDTO {
  final String folderCP;
  final String fileId;
  final int lastChangedDate;
  final String subheadEWS;
  final String contentsEWS;

  FileDTO(this.folderCP, this.fileId, this.lastChangedDate, this.subheadEWS,
      this.contentsEWS);
}

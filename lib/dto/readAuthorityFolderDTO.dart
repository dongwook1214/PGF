class ReadAuthorityFolderDTO {
  final String folderCP;
  final bool isTitleOpen;
  final String title;
  final String symmetricKeyEWA;
  final String lastChangedDate;

  ReadAuthorityFolderDTO(this.folderCP, this.isTitleOpen, this.title,
      this.symmetricKeyEWA, this.lastChangedDate);
}

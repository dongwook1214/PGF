class WriteAuthorityFolderDTO {
  final String folderCP;
  final String folderPublicKey;
  final String folderPrivateKeyEWA;
  final bool isTitleOpen;
  final String title;
  final String symmetricKeyEWF;
  final int lastChangedDate;
  WriteAuthorityFolderDTO(
      this.folderCP,
      this.folderPublicKey,
      this.folderPrivateKeyEWA,
      this.isTitleOpen,
      this.title,
      this.symmetricKeyEWF,
      this.lastChangedDate);
}

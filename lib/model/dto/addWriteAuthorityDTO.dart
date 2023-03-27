class AddWriteAuthorityDTO {
  final String accountCp;

  final String folderCp;

  final String folderPublicKey;

  final String folderPrivateKeyEWA;

  AddWriteAuthorityDTO(this.accountCp, this.folderCp, this.folderPublicKey,
      this.folderPrivateKeyEWA);

  Map<String, dynamic> toJson() {
    return {
      'accountCp': accountCp,
      'folderCp': folderCp,
      'folderPublicKey': folderPublicKey,
      "folderPrivateKeyEWA": folderPrivateKeyEWA,
    };
  }
}
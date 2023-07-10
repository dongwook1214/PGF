class AddWriteAuthorityDTO {
  final String accountCP;

  final String folderCP;

  final String folderPublicKey;

  final String folderPrivateKeyEWA;

  AddWriteAuthorityDTO(this.accountCP, this.folderCP, this.folderPublicKey,
      this.folderPrivateKeyEWA);

  Map<String, dynamic> toJson() {
    return {
      'accountCP': accountCP,
      'folderCP': folderCP,
      'folderPublicKey': folderPublicKey,
      "folderPrivateKeyEWA": folderPrivateKeyEWA,
    };
  }

  void printData() {
    print('''
      accountCP : ${accountCP}
      folderCP : ${folderCP}
      folderPublicKey : ${folderPublicKey}
      folderPrivateKeyEWA : ${folderPrivateKeyEWA}''');
  }
}

class AllowSubscribeDTO {
  final String folderPublicKey;

  final List<int> byteSign;

  final String accountCP;

  final String symmetricKeyEWA;

  AllowSubscribeDTO(this.folderPublicKey, this.byteSign, this.accountCP,
      this.symmetricKeyEWA);

  Map<String, dynamic> toJson() {
    return {
      'folderPublicKey': folderPublicKey,
      'byteSign': byteSign,
      'accountCP': accountCP,
      'symmetricKeyEWA': symmetricKeyEWA,
    };
  }
}

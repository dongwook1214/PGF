class AllowSubscribeDTO {
  final String folderPublicKey;

  final String sign;

  final String accountCP;

  final String symmetricKeyEWA;

  AllowSubscribeDTO(
      this.folderPublicKey, this.sign, this.accountCP, this.symmetricKeyEWA);

  Map<String, dynamic> toJson() {
    return {
      'folderPublicKey': folderPublicKey,
      'sign': sign,
      'accountCP': accountCP,
      'symmetricKeyEWA': symmetricKeyEWA,
    };
  }
}

class AllowSubscribeDTO {
  final String folderPublicKey;

  final String sign;

  final String accountCP;

  final String symmetricKeyEWA;

  AllowSubscribeDTO(
      this.folderPublicKey, this.sign, this.accountCP, this.symmetricKeyEWA);
}

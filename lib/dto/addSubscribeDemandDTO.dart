class AddSubscribeDemandDTO {
  final String folderCP;
  final String accountPublicKey;
  final List<int> byteSign;

  AddSubscribeDemandDTO(this.folderCP, this.accountPublicKey, this.byteSign);
}

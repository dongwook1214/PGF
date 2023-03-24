class ModifyFileDTO {
  final List<int> byteSign;
  final String contents;
  final String subhead;

  ModifyFileDTO(this.byteSign, this.contents, this.subhead);
  Map<String, dynamic> toJson() {
    return {
      'byteSign': byteSign,
      'subhead': subhead,
      'contents': contents,
    };
  }
}

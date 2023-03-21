class GenerateFileDTO {
  final List<int> byteSign;
  final String subhead;

  GenerateFileDTO(this.byteSign, this.subhead);
  Map<String, dynamic> toJson() {
    return {
      'byteSign': byteSign,
      'subhead': subhead,
    };
  }
}

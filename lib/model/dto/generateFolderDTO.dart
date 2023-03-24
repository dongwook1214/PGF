class GenerateFolderDTO {
  final bool isTitleOpen;
  final String title;
  final String symmetricKeyEWF;

  GenerateFolderDTO(this.isTitleOpen, this.title, this.symmetricKeyEWF);

  // GenerateFolderDTO.fromJson(Map<String, dynamic> json)
  //     : isTitleOpen = json['isTitleOpen'],
  //       title = json['title'],
  //       symmetricKeyEWF = json['symmetricKeyEWF'];

  Map<String, dynamic> toJson() {
    return {
      'isTitleOpen': isTitleOpen,
      'title': title,
      'symmetricKeyEWF': symmetricKeyEWF,
    };
  }
}

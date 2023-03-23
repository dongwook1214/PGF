import 'package:cryptofile/designClass/borderCard.dart';
import 'package:cryptofile/dto/fileDTO.dart';
import 'package:cryptofile/file/fileClass.dart';
import 'package:cryptofile/filePage/filePage.dart';
import 'package:flutter/material.dart';

class FileMain extends StatefulWidget {
  String title;
  FileMain({super.key, required this.title});

  @override
  State<FileMain> createState() => _PaperMainState();
}

class _PaperMainState extends State<FileMain> {
  late Size size;
  late ColorScheme scheme;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: scheme.onBackground,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) => paper(
            FileDTO("folderCP", "fileId", "lastChangedDate", "subheadEWS",
                "contentsEWS"),
            size.width * 1),
      ),
    );
  }

  Widget paper(FileDTO fileDTO, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: width * 0.025),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => FilePage(
                        fileClass: FileClass("folderCP", "fileId",
                            "lastChangedDate", "subhead", "contents"),
                      )));
        },
        child: BorderCard(
          childWidget: Padding(
            padding:
                EdgeInsets.symmetric(vertical: 5.0, horizontal: width * 0.025),
            child: BorderCard.contentsOfContents(
              Image.asset(
                "images/file.png",
                color: Colors.white,
              ),
              fileDTO.subheadEWS,
              fileDTO.lastChangedDate,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cryptofile/designClass/borderCard.dart';
import 'package:flutter/material.dart';

class FileMain extends StatefulWidget {
  const FileMain({super.key});

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
        itemBuilder: (BuildContext context, int index) =>
            paper("title", "2022-03-12", size.width * 1),
      ),
    );
  }

  Widget paper(String title, String lastChanged, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: width * 0.025),
      child: BorderCard(
        childWidget: Padding(
          padding:
              EdgeInsets.symmetric(vertical: 5.0, horizontal: width * 0.025),
          child: BorderCard.contentsOfContents(
            Image.asset(
              "images/file.png",
              color: Colors.white,
            ),
            title,
            lastChanged,
          ),
        ),
      ),
    );
  }
}

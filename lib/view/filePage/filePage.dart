import 'package:cryptofile/model/file/fileClass.dart';
import 'package:cryptofile/view_model/getx/from_model/fileContentsGetX.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class FilePage extends StatefulWidget {
  final FileClass fileClass;
  final bool isWriteAuth;
  FilePage({super.key, required this.fileClass, required this.isWriteAuth});

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  late ColorScheme scheme;
  late Size size;
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Get.put(FileContentsGetX());
    scheme = Theme.of(context).colorScheme;
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: _actions(),
        title: Text(widget.fileClass.subhead),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: scheme.onBackground,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            textField(),
            Container(height: size.height * 0.5),
          ],
        ),
      ),
    );
  }

  List<Widget> _actions() {
    return widget.isWriteAuth
        ? [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check),
            ),
          ]
        : [];
  }

  Widget textField() {
    Get.find<FileContentsGetX>()
        .getFileContents(widget.fileClass.folderCP, widget.fileClass.fileId);
    return GetBuilder<FileContentsGetX>(builder: (context) {
      textEditingController.text =
          Get.find<FileContentsGetX>().contents.fileContents;
      return TextField(
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        controller: textEditingController,
      );
    });
  }
}

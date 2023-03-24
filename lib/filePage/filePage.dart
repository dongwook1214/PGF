import 'package:cryptofile/file/fileClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FilePage extends StatefulWidget {
  final FileClass fileClass;
  FilePage({super.key, required this.fileClass});

  @override
  State<FilePage> createState() => _FielPageState();
}

class _FielPageState extends State<FilePage> {
  late ColorScheme scheme;
  late Size size;
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    scheme = Theme.of(context).colorScheme;
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check),
          ),
        ],
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

  Widget textField() {
    return TextField(
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: null,
      controller: textEditingController,
    );
  }
}

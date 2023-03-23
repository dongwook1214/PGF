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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileClass.subhead),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

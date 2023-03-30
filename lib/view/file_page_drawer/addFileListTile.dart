import 'package:cryptofile/model/crypto/cryptoClass.dart';
import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:cryptofile/model/dto/generateFileDTO.dart';
import 'package:cryptofile/model/folder/folderClass.dart';
import 'package:cryptofile/view/designClass/dialogFormat.dart';
import 'package:cryptofile/view/designClass/snackBarFormat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddFileListTile extends StatefulWidget {
  final FolderClass folderClass;
  const AddFileListTile({super.key, required this.folderClass});

  @override
  State<AddFileListTile> createState() => _AddFileListTileState();
}

class _AddFileListTileState extends State<AddFileListTile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController createNewFileTextEditController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Add file'),
      onTap: () => {showDialog(context: context, builder: (_) => _dialog())},
    );
  }

  Widget _dialog() {
    return DialogFormat(
      image: Image.asset("images/treasure.png"),
      tempTitle: "add file",
      okFunction: () {
        if (validateCheck()) {
          _onOkFunction();
        }
      },
      childWidget: _childWidget(),
      isLackOfSpace: true,
    );
  }

  Widget _childWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: createNewFileTextEditController,
          decoration: const InputDecoration(
            labelText: 'File Subtitle',
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter the subtitle of the file";
            }
            return null;
          },
        ),
      ),
    );
  }

  bool validateCheck() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void _onOkFunction() {
    List<int> byteSign = CryptoClass.makeSignFromPem(
        widget.folderClass.getPublicKey(), widget.folderClass.getPrivateKey());
    DioHandling dioHandling = DioHandling();
    GenerateFileDTO generateFileDTO =
        GenerateFileDTO(byteSign, createNewFileTextEditController.text);
    dioHandling.generateFile(
        widget.folderClass.getPublicKey(), generateFileDTO);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBarFormat(const Text("file is added! try refresh"), context));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}

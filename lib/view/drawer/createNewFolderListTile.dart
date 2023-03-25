import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';
import '../designClass/dialogFormat.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
import '../../model/crypto/cryptoClass.dart';
import '../../model/sqfLiteHandling/sqfLiteHandling.dart';
import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';

class CreateNewFolderListTile extends StatefulWidget {
  const CreateNewFolderListTile({super.key});

  @override
  State<CreateNewFolderListTile> createState() =>
      _CreateNewFolderListTileState();
}

class _CreateNewFolderListTileState extends State<CreateNewFolderListTile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController createNewFolderTextEditController =
      TextEditingController();
  bool isNameOpen = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Create New Folder'),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) =>
                DialogFormat(
              isLackOfSpace: true,
              image: Image.asset("images/treasureBox.png"),
              tempTitle: "Create New Folder",
              tempDescription: "Private keys are only stored locally!",
              childWidget: _childWidget(setState),
              okFunction: () async {
                if (validateCheck()) {
                  // Database db = value.localDatabase;
                  // await _onOkFunction(db);
                  // await value.refreshFoldersInfo();
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        );
      },
    );
  }

  bool validateCheck() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future _onOkFunction(Database db) async {
    RSAKeyPairClass keyPair = await RSAKeyPairClass.createKeyPair();
    RsaKeyHelper helper = RsaKeyHelper();
    int date = DateTime.now().millisecondsSinceEpoch;
    String privateKey = helper.encodePrivateKeyToPemPKCS1(keyPair.privateKey);
    String publicKey = helper.encodePublicKeyToPemPKCS1(keyPair.publicKey);
    String title = createNewFolderTextEditController.text;
    Map<String, dynamic> newFolder = {
      "publicKey": publicKey,
      "privateKey": privateKey,
      "title": title,
      "lastChanged": date,
    };
    await SqfLiteHandling.createNewFolder(db, newFolder);
  }

  Widget _childWidget(setState) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Flexible(flex: 8, child: createNewFolderTextField()),
          Flexible(flex: 2, child: isNameOpenCheckBox(setState)),
        ],
      ),
    );
  }

  Widget createNewFolderTextField() {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: createNewFolderTextEditController,
        decoration: const InputDecoration(
          labelText: 'Folder Title',
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter the title of the folder";
          }
          return null;
        },
      ),
    );
  }

  Widget isNameOpenCheckBox(setState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "is title open",
          style: TextStyle(letterSpacing: 0.6, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        Checkbox(
          key: ValueKey(isNameOpen),
          value: isNameOpen,
          onChanged: (bool? value) {
            setState(() {
              isNameOpen = value!;
            });
          },
        ),
      ],
    );
  }
}

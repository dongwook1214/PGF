import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:cryptofile/model/dto/addWriteAuthorityDTO.dart';
import 'package:cryptofile/model/dto/generateFolderDTO.dart';
import 'package:cryptofile/view_model/getx/from_model/accountGetX.dart';
import 'package:cryptofile/view_model/getx/from_view/createNewFolderListTileGetX.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sqflite/sqflite.dart';
import '../designClass/dialogFormat.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
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
  @override
  Widget build(BuildContext context) {
    Get.put(CreateNewFolderListTileGetX());
    return ListTile(
      title: const Text('Create New Folder'),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DialogFormat(
            isLackOfSpace: true,
            image: Image.asset("images/treasureBox.png"),
            tempTitle: "Create New Folder",
            tempDescription: "Private keys are only stored locally!",
            childWidget: _childWidget(),
            okFunction: () async {
              if (validateCheck()) {
                _onOkFunction();
              }
            },
          ),
        );
      },
    );
  }

  Future<void> _onOkFunction() async {
    RSAKeyPairClass rsaKeyPairClass = await RSAKeyPairClass.createKeyPair();
    bool isTitleOpen = Get.find<CreateNewFolderListTileGetX>().isTitleOpen;
    String accountCp =
        Get.find<AccountGetX>().myAccount!.getCompressedPublicKeyString();
    GenerateFolderDTO generateFolderDTO = GenerateFolderDTO(
        isTitleOpen, createNewFolderTextEditController.text, "");
    AddWriteAuthorityDTO addWriteAuthorityDTO = AddWriteAuthorityDTO(
        accountCp,
        rsaKeyPairClass.getCompressedPublicKeyString(),
        rsaKeyPairClass.getPublicKeyString(),
        "");
    DioHandling dioHandling = DioHandling();
    dioHandling.generateFolder(
        generateFolderDTO, rsaKeyPairClass.getCompressedPublicKeyString());
    dioHandling.addWriteAuthority(addWriteAuthorityDTO);
    goBack();
  }

  void goBack() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  bool validateCheck() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  // Future _onOkFunction(Database db) async {
  //   RSAKeyPairClass keyPair = await RSAKeyPairClass.createKeyPair();
  //   RsaKeyHelper helper = RsaKeyHelper();
  //   int date = DateTime.now().millisecondsSinceEpoch;
  //   String privateKey = helper.encodePrivateKeyToPemPKCS1(keyPair.privateKey);
  //   String publicKey = helper.encodePublicKeyToPemPKCS1(keyPair.publicKey);
  //   String title = createNewFolderTextEditController.text;
  //   Map<String, dynamic> newFolder = {
  //     "publicKey": publicKey,
  //     "privateKey": privateKey,
  //     "title": title,
  //     "lastChanged": date,
  //   };
  //   await SqfLiteHandling.createNewFolder(db, newFolder);
  // }

  Widget _childWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Flexible(flex: 8, child: createNewFolderTextField()),
          Flexible(flex: 2, child: isTitleOpenCheckBox()),
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

  Widget isTitleOpenCheckBox() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "is title open",
          style: TextStyle(letterSpacing: 0.6, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        GetBuilder<CreateNewFolderListTileGetX>(builder: (context) {
          return Checkbox(
            value: Get.find<CreateNewFolderListTileGetX>().isTitleOpen,
            onChanged: (bool? value) {
              Get.find<CreateNewFolderListTileGetX>().setIsTitleOpen(value!);
            },
          );
        }),
      ],
    );
  }
}

import 'package:bs58/bs58.dart';
import 'package:cryptofile/model/crypto/aesKeyClass.dart';
import 'package:cryptofile/model/crypto/cryptoClass.dart';
import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:cryptofile/model/dto/addWriteAuthorityDTO.dart';
import 'package:cryptofile/model/dto/generateFolderDTO.dart';
import 'package:cryptofile/view/designClass/snackBarFormat.dart';
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
    AesKeyClass aesKeyClass = AesKeyClass.fromRandom();
    String symmetricKeyEWF = CryptoClass.asymmetricEncryptData(
        rsaKeyPairClass.publicKey, aesKeyClass.getAesKeyString());
    String folderPrivateKeyEWA = CryptoClass.asymmetricEncryptData(
        Get.find<AccountGetX>().myAccount!.publicKey,
        rsaKeyPairClass.getPrivateKeyString());
    bool isTitleOpen = Get.find<CreateNewFolderListTileGetX>().isTitleOpen;
    String folderTitle = isTitleOpen
        ? createNewFolderTextEditController.text
        : CryptoClass.symmetricEncryptData(
            aesKeyClass, createNewFolderTextEditController.text);
    String accountCp =
        Get.find<AccountGetX>().myAccount!.getCompressedPublicKeyString();
    GenerateFolderDTO generateFolderDTO =
        GenerateFolderDTO(isTitleOpen, folderTitle, symmetricKeyEWF);
    AddWriteAuthorityDTO addWriteAuthorityDTO = AddWriteAuthorityDTO(
        accountCp,
        rsaKeyPairClass.getCompressedPublicKeyString(),
        rsaKeyPairClass.getPublicKeyString(),
        folderPrivateKeyEWA);
    DioHandling dioHandling = DioHandling();
    addWriteAuthorityDTO.printData();
    await dioHandling.generateFolder(
        generateFolderDTO, rsaKeyPairClass.getCompressedPublicKeyString());
    await dioHandling.addWriteAuthority(addWriteAuthorityDTO);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBarFormat(Text("folder is created! Try refresh"), context));
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
        GetBuilder<CreateNewFolderListTileGetX>(
          builder: (context) {
            return Checkbox(
              value: Get.find<CreateNewFolderListTileGetX>().isTitleOpen,
              onChanged: (bool? value) {
                Get.find<CreateNewFolderListTileGetX>().setIsTitleOpen(value!);
              },
            );
          },
        ),
      ],
    );
  }
}

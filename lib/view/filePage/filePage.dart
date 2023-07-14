import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/model/crypto/aesKeyClass.dart';
import 'package:cryptofile/model/crypto/cryptoClass.dart';
import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:cryptofile/model/dto/modifyFileDTO.dart';
import 'package:cryptofile/model/file/fileClass.dart';
import 'package:cryptofile/model/folder/folderClass.dart';
import 'package:cryptofile/view/designClass/snackBarFormat.dart';
import 'package:cryptofile/view/mainPage/folderCard.dart';
import 'package:cryptofile/view_model/getx/from_model/fileContentsGetX.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class FilePage extends StatefulWidget {
  final FolderClass folderClass;
  final FileClass fileClass;
  final bool isWriteAuth;
  FilePage(
      {super.key,
      required this.folderClass,
      required this.fileClass,
      required this.isWriteAuth});

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  @override
  late ColorScheme scheme;
  late Size size;
  final TextEditingController textEditingController = TextEditingController();
  bool isFirstBuild = true;
  @override
  Widget build(BuildContext context) {
    Get.put(FileContentsGetX());
    scheme = Theme.of(context).colorScheme;
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: _actions(),
        title: Text(
          widget.fileClass.subhead,
          style: TextStyle(color: scheme.onBackground),
        ),
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
              onPressed: () => _onCheckIconPressed(),
              icon: const Icon(Icons.check),
            ),
          ]
        : [];
  }

  Future _onCheckIconPressed() async {
    List<int> byteSign = CryptoClass.makeSignFromPem(
        "validate", widget.folderClass.getPrivateKey());
    AesKeyClass aesKeyClass =
        AesKeyClass.fromString(widget.folderClass.getSymmetricKey());
    DioHandling dioHandling = DioHandling();
    String encryptedSubhead =
        CryptoClass.symmetricEncryptData(aesKeyClass, widget.fileClass.subhead);
    String encryptedContents = CryptoClass.symmetricEncryptData(
        aesKeyClass, textEditingController.text);
    ModifyFileDTO modifyFileDTO =
        ModifyFileDTO(byteSign, encryptedContents, encryptedSubhead);
    ScaffoldMessenger.of(context).showSnackBar(SnackBarFormat(
        const Text(textAlign: TextAlign.center, "file is modified"), context));
    await dioHandling.modifyFile(
        modifyFileDTO,
        RSAKeyPairClass.getPublicKeyModulusExponent(
            widget.folderClass.getPublicKey()),
        widget.fileClass.fileId);
  }

  Widget textField() {
    if (isFirstBuild) {
      isFirstBuild = false;
      Get.find<FileContentsGetX>()
          .getFileContents(widget.fileClass.folderCP, widget.fileClass.fileId,
              widget.folderClass.getSymmetricKey())
          .then((value) {
        textEditingController.text =
            Get.find<FileContentsGetX>().contents.fileContents;
      });
    }
    return GetBuilder<FileContentsGetX>(builder: (context) {
      return TextField(
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        controller: textEditingController,
      );
    });
  }
}

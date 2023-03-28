import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/model/crypto/cryptoClass.dart';
import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:cryptofile/model/dto/addWriteAuthorityDTO.dart';
import 'package:cryptofile/view/designClass/snackBarFormat.dart';
import 'package:cryptofile/view_model/getx/from_model/accountGetX.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../designClass/dialogFormat.dart';

class ImportExistingFolder extends StatefulWidget {
  const ImportExistingFolder({super.key});

  @override
  State<ImportExistingFolder> createState() => _ImportExistingFolderState();
}

class _ImportExistingFolderState extends State<ImportExistingFolder> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController privateKeyController = TextEditingController();
  TextEditingController publicKeyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Importing Existing Folder'),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DialogFormat(
            image: Image.asset("images/location.png"),
            tempDescription: "The private key is never sent to the server!",
            okFunction: () {
              if (validateCheck()) {
                _okFunction();
              }
            },
            tempTitle: 'Import Existing Folder',
            childWidget: _textField(),
            isLackOfSpace: true,
          ),
        );
      },
    );
  }

  void _okFunction() {
    RSAKeyPairClass folderRSAKeyPair = RSAKeyPairClass.fromPems(
        publicKeyController.text, privateKeyController.text);
    DioHandling dioHandling = DioHandling();
    RSAKeyPairClass accountRSAKeyPair = Get.find<AccountGetX>().myAccount!;
    String folderPrivateKeyEWA = CryptoClass.asymmetricEncryptData(
        accountRSAKeyPair.publicKey, folderRSAKeyPair.getPrivateKeyString());
    AddWriteAuthorityDTO addWriteAuthorityDTO = AddWriteAuthorityDTO(
        accountRSAKeyPair.getCompressedPublicKeyString(),
        folderRSAKeyPair.getCompressedPublicKeyString(),
        folderRSAKeyPair.getPublicKeyString(),
        folderPrivateKeyEWA);
    dioHandling.addWriteAuthority(addWriteAuthorityDTO);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBarFormat(Text("folder is added! Try refresh"), context));
    goBack();
  }

  void goBack() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Widget _textField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: publicKeyController,
              decoration: const InputDecoration(
                labelText: 'public key',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the public key of the folder";
                }
                if (!keyPairValidCheck()) {
                  return "keyPair is not valid with private key";
                }
                return null;
              },
            ),
            Container(height: 10),
            TextFormField(
              controller: privateKeyController,
              decoration: const InputDecoration(
                labelText: 'private key',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the private key of the folder";
                }
                if (!keyPairValidCheck()) {
                  return "keyPair is not valid with public key";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  bool keyPairValidCheck() {
    try {
      RSAKeyPairClass keyPair = RSAKeyPairClass.fromPems(
          publicKeyController.text, privateKeyController.text);
      return keyPair.isKeyPairValid();
    } catch (e) {
      return false;
    }
  }

  bool validateCheck() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}

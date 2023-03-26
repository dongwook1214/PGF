import 'package:cryptofile/model/prefsHandling/prefsHandling.dart';
import 'package:cryptofile/view/designClass/snackBarFormat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/crypto/cryptoClass.dart';
import '../../model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/view/designClass/dialogFormat.dart';
import '../../view_model/getx/from_model/accountGetX.dart';
import '../../view_model/getx/from_model/accountGetX.dart';

class ImportAccountDialog extends StatefulWidget {
  const ImportAccountDialog({super.key});

  @override
  State<ImportAccountDialog> createState() => _ImportAccountDialogState();
}

class _ImportAccountDialogState extends State<ImportAccountDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController privateKeyController = TextEditingController();
  TextEditingController publicKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DialogFormat(
      image: Image.asset("images/human.png"),
      tempDescription: "write your key including header and footer.",
      okFunction: () {
        onOkButtonPressed();
      },
      tempTitle: 'Import Existing Account',
      childWidget: _textInput(),
      isLackOfSpace: true,
    );
  }

  void onOkButtonPressed() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    RSAKeyPairClass keyPair = RSAKeyPairClass.fromPems(
        publicKeyController.text, privateKeyController.text);
    PrefsHandling prefsHandling = PrefsHandling();
    await prefsHandling.setPublicAndPrivateKey(
        keyPair.getPublicKeyString(), keyPair.getPrivateKeyString());
    Get.find<AccountGetX>().login();
    welcome(context);
    Navigator.pop(context);
  }

  Widget _textInput() {
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
                  return "Please enter publicKey";
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
                  return "Please enter privateKey";
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
}

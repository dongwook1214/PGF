import 'package:cryptofile/screen/designClass/snackBarFormat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/crypto/cryptoClass.dart';
import '../../model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/screen/designClass/dialogFormat.dart';
import '../../controller/provider/accountProvider.dart';

class ImportAccountDialog extends StatefulWidget {
  final SharedPreferences prefs;
  const ImportAccountDialog({super.key, required this.prefs});

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
    await widget.prefs.setString("publicKey", keyPair.getPublicKeyString());
    await widget.prefs.setString("privateKey", keyPair.getPrivateKeyString());
    Provider.of<AccountProvider>(context, listen: false).login(widget.prefs);
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

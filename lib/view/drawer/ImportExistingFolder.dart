import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
            okFunction: () {},
            tempTitle: 'Import Existing Folder',
            childWidget: _textField(),
            isLackOfSpace: true,
          ),
        );
      },
    );
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
                  return "Please enter the name of the folder";
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
                  return "Please enter the name of the folder";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../designClass/dialogFormat.dart';

class HowToUse extends StatefulWidget {
  const HowToUse({super.key});

  @override
  State<HowToUse> createState() => _ImportExistingFolderState();
}

class _ImportExistingFolderState extends State<HowToUse> {
  @override
  Widget build(BuildContext context) {
    String contentStr =
        '1. Press "Copy account details" in the menu and save it in a safe place. This will be used later to load your account.\n\n2. Press and hold the folder card to use additional features. Here it is also recommended to save the information in the folder by pressing the "Copy" button.\n\n3. You can get write/read permission to any folder by pressing "Importing Existing Folder" in the menu.';
    return ListTile(
      title: const Text('How To Use'),
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('PGF'),
                  content: Text(contentStr),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      },
    );
  }
}

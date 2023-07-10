import 'package:cryptofile/view/drawer/contactUsClass.dart';
import 'package:cryptofile/view/drawer/howToUSe.dart';
import 'package:cryptofile/view/drawer/logOut.dart';
import 'package:cryptofile/view/drawer/searchFolderPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../view_model/getx/from_model/accountGetX.dart';
import '../designClass/snackBarFormat.dart';
import 'ImportExistingFolder.dart';
import 'createNewFolderListTile.dart';

class DrawerClass extends StatefulWidget {
  const DrawerClass({super.key});

  @override
  State<DrawerClass> createState() => _DrawerClassState();
}

class _DrawerClassState extends State<DrawerClass> {
  late ColorScheme scheme = Theme.of(context).colorScheme;
  @override
  Widget build(BuildContext context) {
    return _drawer();
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          customDrawerHeader(),
          CreateNewFolderListTile(),
          ImportExistingFolder(),
          ListTile(
            title: const Text('Search Folder'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => SearchFolderPage())),
          ),
          ListTile(
            title: const Text('Copy account details'),
            onTap: () {
              Clipboard.setData(ClipboardData(
                  text:
                      "publicKey:\n${Get.find<AccountGetX>().myAccount!.getPublicKeyString()} \nprivateKey:\n${Get.find<AccountGetX>().myAccount!.getPrivateKeyString()}"));
              ScaffoldMessenger.of(context).showSnackBar(SnackBarFormat(
                  Text("Account key has been copied!"), context));
              Navigator.pop(context);
            },
          ),
          HowToUse(),
          ContactUsClass(),
          LogOut(),
        ],
      ),
    );
  }

  Widget customDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: scheme.primary),
      child: Text(
        'Menu',
        style: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 25, color: scheme.onPrimary),
      ),
    );
  }
}

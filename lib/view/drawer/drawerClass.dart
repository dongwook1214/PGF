import 'package:cryptofile/view/drawer/contactUsClass.dart';
import 'package:cryptofile/view/drawer/howToUSe.dart';
import 'package:cryptofile/view/drawer/logOut.dart';
import 'package:cryptofile/view/drawer/searchFolderPage.dart';
import 'package:flutter/material.dart';
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

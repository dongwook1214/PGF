import 'package:cryptofile/model/folder/folderClass.dart';
import 'package:cryptofile/view/file_page_drawer/addFileListTile.dart';
import 'package:cryptofile/view/file_page_drawer/subscribeDemandPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FilePageDrawer extends StatefulWidget {
  final FolderClass folderClass;
  const FilePageDrawer({super.key, required this.folderClass});

  @override
  State<FilePageDrawer> createState() => _FilePageDrawerState();
}

class _FilePageDrawerState extends State<FilePageDrawer> {
  late ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    scheme = Theme.of(context).colorScheme;
    return _drawer();
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          customDrawerHeader(),
          AddFileListTile(
            folderClass: widget.folderClass,
          ),
          ListTile(
            title: const Text('subscribe demand'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubscribeDemandPage(
                  folderClass: widget.folderClass,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: scheme.primary),
      child: Text(
        'Function',
        style: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 25, color: scheme.onPrimary),
      ),
    );
  }
}

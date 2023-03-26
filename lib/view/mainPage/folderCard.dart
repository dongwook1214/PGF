import 'package:context_menus/context_menus.dart';
import 'package:cryptofile/model/crypto/cryptoClass.dart';
import 'package:cryptofile/model/folder/folderClass.dart';
import 'package:cryptofile/model/folder/readAuthorityFolderClass.dart';
import 'package:cryptofile/model/folder/writeAuthorityFolderClass.dart';
import 'package:cryptofile/view/designClass/borderCard.dart';
import 'package:cryptofile/view/filePage/fileMain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FolderCard extends StatelessWidget {
  final FolderClass folder;
  // final String title;
  // final String publicKey;
  // final String privateKey;
  // final String lastChangedDate;

  const FolderCard({
    super.key,
    required this.folder,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: width * 0.025),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FileMain(
                title: folder.getTitle(),
              ),
            ),
          );
        },
        onLongPress: () {},
        child: ContextMenuRegion(
          contextMenu: GenericContextMenu(
            buttonConfigs: [
              ContextMenuButtonConfig("copy",
                  onPressed: () => copyFunction(context)),
              ContextMenuButtonConfig("Hide folder", onPressed: () {}),
              ContextMenuButtonConfig("Delete folder forever",
                  onPressed: () {}),
            ],
          ),
          child: BorderCard(
            childWidget: cardContents(width),
          ),
        ),
      ),
    );
  }

  Widget cardContents(double width) {
    return Padding(
      padding: EdgeInsets.all(width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                folder.getTitle(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
          Container(
            height: 20,
          ),
          Column(
            children: [
              BorderCard.contentsOfContents(
                Image.asset("images/treasureBox.png"),
                "public key",
                folder.getFolderCP(),
              ),
              BorderCard.contentsOfContents(Image.asset("images/schedule.png"),
                  "last changed", folder.getLastChangedDate().substring(0, 10)),
            ],
          )
        ],
      ),
    );
  }

  void copyFunction(BuildContext context) {
    Clipboard.setData(ClipboardData(
        text:
            "title:${folder.getTitle()} \npublicKey:\n${folder.getPublicKey()} \nprivateKey:\n${folder.getPrivateKey()}"));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "The folder's information has been copied.",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            width: 2,
          ),
        ),
      ),
    );
  }
}

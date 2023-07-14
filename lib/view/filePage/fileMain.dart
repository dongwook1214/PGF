import 'package:cryptofile/model/dto/fileDTO.dart';
import 'package:cryptofile/model/file/fileClass.dart';
import 'package:cryptofile/model/folder/folderClass.dart';
import 'package:cryptofile/model/folder/writeAuthorityFolderClass.dart';
import 'package:cryptofile/model/prefsHandling/prefsHandling.dart';
import 'package:cryptofile/view/designClass/borderCard.dart';
import 'package:cryptofile/view/filePage/filePage.dart';
import 'package:cryptofile/view/file_page_drawer/filePageDrawer.dart';
import 'package:cryptofile/view_model/getx/from_model/fileGetX.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FileMain extends StatefulWidget {
  final FolderClass folderClass;
  FileMain({super.key, required this.folderClass});

  @override
  State<FileMain> createState() => _FileMainState();
}

class _FileMainState extends State<FileMain> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(FileGetX());
  }

  late Size size;
  late ColorScheme scheme;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    scheme = Theme.of(context).colorScheme;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: widget.folderClass is WriteAuthorityFolderClass
          ? FilePageDrawer(
              folderClass: widget.folderClass,
            )
          : null,
      appBar: AppBar(
        title: Text(
          widget.folderClass.getTitle(),
          style: TextStyle(
            color: scheme.onBackground,
          ),
        ),
        actions: widget.folderClass is WriteAuthorityFolderClass
            ? [_settingActionButton()]
            : null,
        backgroundColor: Colors.transparent,
        leading: _leading(),
      ),
      body: _listViewBuilder(widget.folderClass.getFolderCP()),
    );
  }

  Widget _settingActionButton() {
    return IconButton(
      onPressed: () {
        _scaffoldKey.currentState!.openEndDrawer();
      },
      icon: Icon(
        Icons.menu,
        color: scheme.onBackground,
      ),
    );
  }

  Widget _leading() {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: scheme.onBackground,
      ),
    );
  }

  Widget _listViewBuilder(String folderCP) {
    Get.find<FileGetX>()
        .setFileList(folderCP, widget.folderClass.getSymmetricKey());
    return GetBuilder<FileGetX>(
      builder: (context) {
        return RefreshIndicator(
          onRefresh: () => Get.find<FileGetX>()
              .setFileList(folderCP, widget.folderClass.getSymmetricKey()),
          child: ListView.builder(
            itemCount: Get.find<FileGetX>().fileList.length,
            itemBuilder: (BuildContext context, int index) =>
                paper(Get.find<FileGetX>().fileList[index], size.width * 1),
          ),
        );
      },
    );
  }

  Widget paper(FileClass fileClass, double width) {
    PrefsHandling prefsHandling = PrefsHandling();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: width * 0.025),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FilePage(
                fileClass: fileClass,
                folderClass: widget.folderClass,
                isWriteAuth: widget.folderClass is WriteAuthorityFolderClass,
              ),
            ),
          );
        },
        child: BorderCard(
          childWidget: Padding(
            padding:
                EdgeInsets.symmetric(vertical: 5.0, horizontal: width * 0.025),
            child: BorderCard.contentsOfContents(
              Image.asset(
                "images/file.png",
                color:
                    prefsHandling.getIsDarkMode() ? Colors.white : Colors.black,
              ),
              fileClass.subhead,
              DateFormat.yMMMd().format(fileClass.lastChangedDate),
            ),
          ),
        ),
      ),
    );
  }
}

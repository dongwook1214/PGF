import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/model/prefsHandling/prefsHandling.dart';
import 'package:cryptofile/view/drawer/drawerClass.dart';
import 'package:cryptofile/view/mainPage/importAccountDialog.dart';
import 'package:cryptofile/view/settingPage/settingPage.dart';
import 'package:cryptofile/view_model/getx/from_model/readAuthorityFolderGetX.dart';
import 'package:cryptofile/view_model/getx/from_view/mainPageGetX.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cryptofile/view/designClass/snackBarFormat.dart';
import 'package:cryptofile/view_model/getx/from_model/accountGetX.dart';
import 'package:cryptofile/view_model/getx/from_model/writeAuthorityFolderGetX.dart';
import 'folderCard.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(WriteAuthorityFolderGetX());
    Get.put(ReadAuthorityFolderGetX());
    Get.put(MainPageGetX());
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ColorScheme scheme;
  late Size size;

  @override
  Widget build(BuildContext context) {
    scheme = Theme.of(context).colorScheme;
    size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const DrawerClass(),
      backgroundColor: scheme.background,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: const Text(
          "PGF",
          style: TextStyle(
              color: Colors.grey, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          _settingActionButton(),
          _hambergerActionButton(),
        ],
      ),
      body: Center(child: accountButtonOrMain()),
    );
  }

  Widget accountButtonOrMain() {
    return GetBuilder<AccountGetX>(
      builder: (_) {
        if (Get.find<AccountGetX>().myAccount == null) {
          return _accountButton();
        } else {
          Get.find<WriteAuthorityFolderGetX>().setFolderList();
          return _main();
        }
      },
    );
  }

  Widget _settingActionButton() {
    return IconButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingPage())),
      icon: Icon(
        Icons.settings,
        color: scheme.onBackground,
      ),
    );
  }

  Widget _hambergerActionButton() {
    return GetBuilder<AccountGetX>(
      builder: (_) {
        print("account change");
        print(Get.find<AccountGetX>().myAccount);
        return Get.find<AccountGetX>().myAccount == null
            ? const SizedBox.shrink()
            : IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: scheme.onBackground,
                ),
              );
      },
    );
  }

  Widget _toggleButton() {
    return GetBuilder<MainPageGetX>(
      builder: (_) {
        return ToggleButtons(
          onPressed: (int index) {
            Get.find<MainPageGetX>().setSelectedToggle(index);
            if (index == 0) {
              Get.find<WriteAuthorityFolderGetX>().setFolderList();
            } else {
              Get.find<ReadAuthorityFolderGetX>().setFolderList();
            }
          },
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedBorderColor: Colors.black,
          selectedColor: Colors.white,
          fillColor: Colors.grey,
          color: Colors.grey,
          isSelected: Get.find<MainPageGetX>().selectedToggle,
          constraints: BoxConstraints(minHeight: size.height * 0.04),
          children: const [
            Text('  write-authority  '),
            Text('  read-authority  ')
          ],
        );
      },
    );
  }

  Widget _accountButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _loadAccountButton(),
        _createAccountButton(),
      ],
    );
  }

  Widget _loadAccountButton() {
    return ElevatedButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (_) => ImportAccountDialog(),
        );
      },
      child: const Text(
        "load account",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _createAccountButton() {
    return ElevatedButton(
      onPressed: () async {
        RSAKeyPairClass keyPair = await RSAKeyPairClass.createKeyPair();
        PrefsHandling prefsHandling = PrefsHandling();
        await prefsHandling.setPublicAndPrivateKey(
            keyPair.getPublicKeyString(), keyPair.getPrivateKeyString());
        Get.find<AccountGetX>().login();
        welcome(context);
      },
      child: const Text(
        "create account",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _main() {
    return Column(
      children: [
        _toggleButton(),
        _listViewBuilder(),
      ],
    );
  }

  Widget _listViewBuilder() {
    return Expanded(
      child: GetBuilder<MainPageGetX>(
        builder: (_) {
          if (Get.find<MainPageGetX>().selectedToggle[0]) {
            return GetBuilder<WriteAuthorityFolderGetX>(builder: (_) {
              return RefreshIndicator(
                onRefresh: () async =>
                    await Get.find<WriteAuthorityFolderGetX>().setFolderList(),
                child: ListView.builder(
                  itemCount:
                      Get.find<WriteAuthorityFolderGetX>().folderList.length,
                  itemBuilder: (BuildContext context, int idx) => FolderCard(
                    folder:
                        Get.find<WriteAuthorityFolderGetX>().folderList[idx],
                  ),
                ),
              );
            });
          } else {
            return GetBuilder<ReadAuthorityFolderGetX>(
              builder: (_) {
                return RefreshIndicator(
                  onRefresh: () async =>
                      await Get.find<ReadAuthorityFolderGetX>().setFolderList(),
                  child: ListView.builder(
                    itemCount:
                        Get.find<ReadAuthorityFolderGetX>().folderList.length,
                    itemBuilder: (BuildContext context, int idx) => FolderCard(
                      folder:
                          Get.find<ReadAuthorityFolderGetX>().folderList[idx],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

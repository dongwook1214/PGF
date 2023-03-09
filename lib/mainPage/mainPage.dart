import 'package:cryptofile/crypto/cryptoClass.dart';
import 'package:cryptofile/crypto/cryptoKeyPair.dart';
import 'package:cryptofile/designClass/dialogFormat.dart';
import 'package:cryptofile/drawer/drawerClass.dart';
import 'package:cryptofile/mainPage/importAccountDialog.dart';
import 'package:cryptofile/provider/accountProvider.dart';
import 'package:cryptofile/provider/localDatabaseProvider.dart';
import 'package:cryptofile/provider/sharedPreferencesProvider.dart';
import 'package:cryptofile/settingPage/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../designClass/snackBarFormat.dart';
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
    _initStateMethod();
  }

  Future _initStateMethod() async {
    prefs =
        Provider.of<SharedPreferencesProvider>(context, listen: false).prefs;

    await Provider.of<LocalDatabaseProvider>(context, listen: false)
        .setLocalDatabase();
    await Provider.of<LocalDatabaseProvider>(context, listen: false)
        .initFoldersInfo();
    Provider.of<AccountProvider>(context, listen: false).initLogin(prefs);
    initFinished = true;
    setState(() {});
  }

  bool initFinished = false;
  late SharedPreferences prefs;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CryptoKeyPair? _loginedKey;
  late ColorScheme scheme;
  late List<Map<String, dynamic>> _foldersInfo;

  @override
  Widget build(BuildContext context) {
    _foldersInfo =
        Provider.of<LocalDatabaseProvider>(context, listen: true).foldersInfo;
    _loginedKey = Provider.of<AccountProvider>(context, listen: true).myAccount;
    scheme = Theme.of(context).colorScheme;
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
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingPage())),
            icon: Icon(
              Icons.settings,
              color: scheme.onBackground,
            ),
          ),
          _loginedKey == null
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: scheme.onBackground,
                  ),
                ),
        ],
      ),
      body: Center(
        child: _loginedKey == null ? _accountButton() : _listViewBuilder(),
      ),
    );
  }

  Widget _accountButton() {
    return initFinished
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _loadAccountButton(),
              _createAccountButton(),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget _loadAccountButton() {
    return ElevatedButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (_) => ImportAccountDialog(
            prefs: prefs,
          ),
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
        CryptoKeyPair keyPair = await CryptoClass.createKeyPair();
        await prefs.setString("publicKey", keyPair.getPublicKeyString());
        await prefs.setString("privateKey", keyPair.getPrivateKeyString());
        Provider.of<AccountProvider>(context, listen: false).login(prefs);
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

  Widget _listViewBuilder() {
    return ListView.builder(
      itemCount: _foldersInfo.length,
      itemBuilder: (BuildContext context, int idx) => FolderCard(
        title: _foldersInfo[idx]["title"],
        publicKey: _foldersInfo[idx]["publicKey"],
        lastChangedDate: _foldersInfo[idx]["lastChanged"],
        privateKey: _foldersInfo[idx]["privateKey"],
      ),
    );
  }
}

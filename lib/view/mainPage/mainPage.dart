import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/model/prefsHandling/prefsHandling.dart';
import 'package:cryptofile/view_model/getx/accountGetX.dart';
import 'package:cryptofile/view/drawer/drawerClass.dart';
import 'package:cryptofile/view/mainPage/importAccountDialog.dart';
import 'package:cryptofile/view/settingPage/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:cryptofile/view/designClass/snackBarFormat.dart';
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
  }

  final List<Widget> _authorityState = <Widget>[
    const Text('  write-authority  '),
    const Text('  read-authority  ')
  ];
  final List<bool> _selectedFruits = [true, false];
  bool initFinished = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ColorScheme scheme;
  late List<Map<String, dynamic>> _foldersInfo;
  late Size size;

  @override
  Widget build(BuildContext context) {
    _foldersInfo = [];
    // _foldersInfo =
    //     Provider.of<LocalDatabaseProvider>(context, listen: true).foldersInfo;
    // _loginedKey = Provider.of<AccountProvider>(context, listen: true).myAccount;
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
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingPage())),
            icon: Icon(
              Icons.settings,
              color: scheme.onBackground,
            ),
          ),
          GetX<AccountGetX>(
            builder: (controller) {
              print(controller.myAccount.value);
              return controller.myAccount.value == null
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
          ),
        ],
      ),
      body: Center(
        child: GetX<AccountGetX>(
          builder: (controller) {
            return controller.myAccount.value == null
                ? _accountButton()
                : _main();
          },
        ),
      ),
    );
  }

  Widget _toggleButton() {
    return ToggleButtons(
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < _selectedFruits.length; i++) {
            _selectedFruits[i] = i == index;
          }
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      selectedBorderColor: Colors.black,
      selectedColor: Colors.white,
      fillColor: Colors.grey,
      color: Colors.grey,
      isSelected: _selectedFruits,
      constraints: BoxConstraints(minHeight: size.height * 0.04),
      children: _authorityState,
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
        prefsHandling.setPublicAndPrivateKey(
            keyPair.getPublicKeyString(), keyPair.getPrivateKeyString());
        //Provider.of<AccountProvider>(context, listen: false).login(prefs);
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
      child: ListView.builder(
        itemCount: _foldersInfo.length,
        itemBuilder: (BuildContext context, int idx) => FolderCard(
          title: _foldersInfo[idx]["title"],
          publicKey: _foldersInfo[idx]["publicKey"],
          lastChangedDate: _foldersInfo[idx]["lastChanged"],
          privateKey: _foldersInfo[idx]["privateKey"],
        ),
      ),
    );
  }
}

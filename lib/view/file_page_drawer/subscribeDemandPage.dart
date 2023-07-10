import 'dart:typed_data';

import 'package:bs58/bs58.dart';
import 'package:cryptofile/model/crypto/cryptoClass.dart';
import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:cryptofile/model/dto/allowSubscribeDTO.dart';
import 'package:cryptofile/model/folder/folderClass.dart';
import 'package:cryptofile/view/designClass/snackBarFormat.dart';
import 'package:cryptofile/view_model/getx/from_model/accountGetX.dart';
import 'package:cryptofile/view_model/getx/from_view/subscribeDemandPageGetX.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:pointycastle/export.dart' as pointycastleCrypto;
import 'package:crypto/crypto.dart' as crypto;

import '../../model/crypto/RSAKeyPairClass.dart';

class SubscribeDemandPage extends StatefulWidget {
  final FolderClass folderClass;
  const SubscribeDemandPage({super.key, required this.folderClass});

  @override
  State<SubscribeDemandPage> createState() => _SubscribeDemandPageState();
}

class _SubscribeDemandPageState extends State<SubscribeDemandPage> {
  late ColorScheme scheme;
  late Size size;
  @override
  Widget build(BuildContext context) {
    Get.put(subscribeDemandPageGetX());
    size = MediaQuery.of(context).size;
    scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: scheme.onBackground,
          ),
        ),
        title: Text(
          "Subscribe Demand",
          style: TextStyle(color: scheme.onBackground),
        ),
      ),
      body: _listViewBuilder(),
    );
  }

  Widget _listViewBuilder() {
    Get.find<subscribeDemandPageGetX>()
        .setSubscribeDemandList(widget.folderClass.getFolderCP());
    return GetBuilder<subscribeDemandPageGetX>(builder: (context) {
      return ListView.builder(
        itemCount:
            Get.find<subscribeDemandPageGetX>().subscribeDemandList.length,
        itemBuilder: ((context, index) => _listTile(index)),
      );
    });
  }

  String _publicKeyPretreatmen(String str) {
    crypto.Digest digest = crypto.sha256.convert(str.codeUnits);
    String cp = base58.encode(Uint8List.fromList(digest.bytes));
    if (cp.length > 20) {
      return "${cp.substring(0, 20)}...";
    } else {
      return cp;
    }
  }

  Widget _listTile(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(30),
        ),
        tileColor: scheme.onSecondary,
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => _alertDialog(index),
          );
        },
        title: Text(_publicKeyPretreatmen(
            Get.find<subscribeDemandPageGetX>().subscribeDemandList[index])),
      ),
    );
  }

  Widget _alertDialog(int index) {
    return AlertDialog(
      title: const Text('allow subscribe'),
      content: const Text("Click ok to accept the subscription."),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _onOkPressed(index),
          child: const Text('OK'),
        ),
      ],
    );
  }

  void _onOkPressed(int index) async {
    String input =
        Get.find<subscribeDemandPageGetX>().subscribeDemandList[index];
    RegExp regExp = RegExp(r'(\d+)and(\d+)');

    RegExpMatch? match = regExp.firstMatch(input);

    BigInt modulus = BigInt.parse(match!.group(1)!);
    BigInt exponent = BigInt.parse(match.group(2)!);

    pointycastleCrypto.RSAPublicKey rsaPublicKey =
        pointycastleCrypto.RSAPublicKey(modulus, exponent);

    crypto.Digest digest = crypto.sha256.convert(input.codeUnits);
    String cp = base58.encode(Uint8List.fromList(digest.bytes));

    //수정 필요 현재 compressed account
    String symmetricKeyEWA = CryptoClass.asymmetricEncryptData(
        rsaPublicKey, widget.folderClass.getSymmetricKey());

    List<int> byteSign = CryptoClass.makeSignFromPem(
        "validate", widget.folderClass.getPrivateKey());

    DioHandling dioHandling = DioHandling();

    AllowSubscribeDTO allowSubscribeDTO = AllowSubscribeDTO(
        RSAKeyPairClass.getPublicKeyModulusExponent(
            widget.folderClass.getPublicKey()),
        byteSign,
        cp,
        symmetricKeyEWA);

    dioHandling.allowSubscribe(allowSubscribeDTO);
    Get.find<subscribeDemandPageGetX>()
        .setSubscribeDemandList(widget.folderClass.getFolderCP());
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBarFormat(
        const Text(
          "subscription is allowed",
          textAlign: TextAlign.center,
        ),
        context));
  }
}

import 'dart:async';
import 'package:cryptofile/model/crypto/cryptoClass.dart';
import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:cryptofile/model/dto/addSubscribeDemandDTO.dart';
import 'package:cryptofile/view/designClass/dialogFormat.dart';
import 'package:cryptofile/view/designClass/snackBarFormat.dart';
import 'package:cryptofile/view_model/getx/from_model/accountGetX.dart';
import 'package:cryptofile/view_model/getx/from_model/searchContentsDTOGetX.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFolderPage extends StatefulWidget {
  const SearchFolderPage({super.key});

  @override
  State<SearchFolderPage> createState() => _SearchFolderPageState();
}

class _SearchFolderPageState extends State<SearchFolderPage> {
  late ColorScheme scheme;
  StreamController streamCtrl = StreamController();
  @override
  Widget build(BuildContext context) {
    Get.put(SearchContentsDTOGetX());
    double width = MediaQuery.of(context).size.width;
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
          "search",
          style: TextStyle(color: scheme.onBackground),
        ),
      ),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.text,
            onChanged: (text) {
              streamCtrl.add(text);
            },
            decoration: const InputDecoration(
                hintText: "public Key || folder title",
                border: InputBorder.none,
                icon: Padding(
                    padding: EdgeInsets.only(left: 13),
                    child: Icon(Icons.search))),
          ),
          Expanded(
            child: StreamBuilder(
              stream: streamCtrl.stream,
              builder: (context, AsyncSnapshot snapshot) {
                Get.find<SearchContentsDTOGetX>()
                    .setSearchedList(snapshot.data);
                return _listViewBuilder();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _listViewBuilder() {
    return GetBuilder<SearchContentsDTOGetX>(
      builder: (context) {
        return ListView.builder(
          itemCount: Get.find<SearchContentsDTOGetX>().searchedList.length,
          itemBuilder: (context, i) => _listTile(i),
        );
      },
    );
  }

  Widget _listTile(int i) {
    return ListTile(
      onTap: () => showDialog(context: context, builder: (_) => _dialog(i)),
      title: Text(Get.find<SearchContentsDTOGetX>().searchedList[i].title),
      subtitle: Text(
          "${Get.find<SearchContentsDTOGetX>().searchedList[i].folderCP.substring(0, 10)}..."),
    );
  }

  Widget _dialog(int i) {
    return DialogFormat(
        image: Image.asset("images/get.png"),
        tempTitle: "Do you want to subscribe?",
        tempDescription:
            "${Get.find<SearchContentsDTOGetX>().searchedList[i].title}\n\n${Get.find<SearchContentsDTOGetX>().searchedList[i].folderCP}",
        okFunction: () => _okFunction(i));
  }

  void _okFunction(int i) {
    DioHandling dioHandling = DioHandling();
    AddSubscribeDemandDTO addSubscribeDemandDTO = AddSubscribeDemandDTO(
      Get.find<SearchContentsDTOGetX>().searchedList[i].folderCP,
      Get.find<AccountGetX>().myAccount!.getCompressedPublicKeyString(),
      CryptoClass.makeSign(
          Get.find<AccountGetX>().myAccount!.getPublicKeyString(),
          Get.find<AccountGetX>().myAccount!.privateKey),
    );
    dioHandling.addSubscribeDemand(addSubscribeDemandDTO);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBarFormat(
        const Text("subscription request has been sended."), context));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchFolderPage extends StatefulWidget {
  const SearchFolderPage({super.key});

  @override
  State<SearchFolderPage> createState() => _SearchFolderPageState();
}

class _SearchFolderPageState extends State<SearchFolderPage> {
  List<String> strList = [
    "바보",
    "멍청이",
    "히힛",
    "헤헷",
    "흐흣",
    "끼요",
    "끼욧!",
    "dsf",
    "dsaf",
    "aw",
    "wawa",
    "wa"
  ];
  late ColorScheme scheme;
  StreamController streamCtrl = StreamController();
  @override
  Widget build(BuildContext context) {
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
            //focusNode: _focus,
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
                return ListView.builder(
                  itemCount: snapshot.data == null
                      ? 0
                      : snapshot.data.toString().length,
                  itemBuilder: (context, i) => ListTile(
                    title: Text(snapshot.data.toString() + strList[i]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

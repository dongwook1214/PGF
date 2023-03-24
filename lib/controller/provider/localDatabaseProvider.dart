// import 'package:cryptofile/sqfLiteHandling/sqfLiteHandling.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class LocalDatabaseProvider with ChangeNotifier {
//   late Database _localDatabase;
//   Database get localDatabase => _localDatabase;
//   List<Map<String, dynamic>> _foldersInfo = [];
//   List<Map<String, dynamic>> get foldersInfo => _foldersInfo;

//   Future setLocalDatabase() async {
//     _localDatabase = await SqfLiteHandling.openDb();
//     print("set dataBase");
//     //notifyListeners();
//   }

//   Future initFoldersInfo() async {
//     _foldersInfo = await SqfLiteHandling.getFolderInfos(_localDatabase);
//     print("init Folder Info Finish");
//   }

//   Future refreshFoldersInfo() async {
//     _foldersInfo = await SqfLiteHandling.getFolderInfos(_localDatabase);
//     print("load Folder Info Finish");
//     notifyListeners();
//   }
// }

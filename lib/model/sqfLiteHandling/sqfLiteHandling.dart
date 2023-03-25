import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfLiteHandling {
  static Future<void> createNewFolder(
      Database db, Map<String, dynamic> newFolder) async {
    await db.insert("folder", newFolder);
  }

  static allDelete(Database db) {
    db.execute('''
        drop table folder;
        drop table paper;
      ''');
  }

  static Future getInfo(Database db) async {
    return await db.query("folder",
        columns: ["publicKey", "privateKey", "title", "lastChanged"]);
  }

  static Future updateTable(Database db, item) async {
    await db.update(
      'posts', // table name
      {
        'title': 'changed post title ...',
        'content': 'changed post content ...',
      }, // update post row data
      where: 'id = ?',
      whereArgs: [item.id],
    );
    return item;
  }

  static Future<int> removeTable(Database db, int id) async {
    await db.delete(
      'posts', // table name
      where: 'id = ?',
      whereArgs: [id],
    );
    return id;
  }

  static Future<Database> openDb() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'database.db');

    Database db = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) => {},
      onCreate: (Database db, int version) => {},
      onUpgrade: (Database db, int oldVersion, int newVersion) => {},
    );
    await db.execute('''
      CREATE TABLE IF NOT EXISTS `Folder` (
        `publicKey` TEXT NOT NULL unique,
        `privateKey` TEXT NOT NULL unique,
        `title` TEXT NOT NULL,
        `lastChanged` DATE NOT NULL
      );
      CREATE TABLE IF NOT EXISTS `Paper` (
        `publicKey` TEXT NOT NULL,
        `PaperId` unsigned INTEGER AUTO_INCREMENT PRIMARY KEY,
        `SmallTitle` TEXT NOT NULL,
        `LastChanged` DATE NOT NULL
      );
  ''');
    return db;
  }

  static Future<List<Map<String, dynamic>>> getFolderInfos(Database db) async {
    List<Map<String, dynamic>> info = await db.query("folder",
        columns: ["publicKey", "privateKey", "title", "lastChanged"]);
    List<Map<String, dynamic>> copiedInfo = [];
    for (int i = 0; i < info.length; ++i) {
      copiedInfo.add(Map.of(info[i]));
    }
    copiedInfo.sort(((a, b) =>
        (b["lastChanged"] as int).compareTo(a["lastChanged"] as int)));

    for (int i = 0; i < info.length; i++) {
      copiedInfo[i]["lastChanged"] =
          DateTime.fromMillisecondsSinceEpoch(copiedInfo[i]["lastChanged"])
              .toString();
    }
    return copiedInfo;
  }
}

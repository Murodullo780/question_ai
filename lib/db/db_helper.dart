import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:question_ai_project/models/feedback.dart';
import 'package:sqflite/sqflite.dart';

class TableNames {
  static String feedBack = "feedbacks";
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  ValueNotifier change = ValueNotifier(false);

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb(1);
    return _db!;
  }

  DatabaseHelper._internal();

  initDb(int version) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main_v1.db");
    if (!await File(path).exists()) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load(join("assets", "feedbacks.db"));
      debugPrint("DB saqlandi");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: false);
    }
    var ourDb =
        await openDatabase(path, version: version, onCreate: (db, version) {});
    print(await ourDb.getVersion());
    return ourDb;
  }

  Future<int> safeFeedback(String feedback) async {
    var dbClient = await db;
    return await dbClient.insert(TableNames.feedBack,
        MyFeedback(time: DateTime.now().toString(), feedback: feedback).toJson());
  }

  Future<List<MyFeedback>> getAllFeedback() async {
    final db = await this.db;
    final List<Map<String, dynamic>> map =
    await db.rawQuery("SELECT * FROM  ${TableNames.feedBack}");
    List<MyFeedback> list =
    map.isNotEmpty ? map.map((e) => MyFeedback.fromJson(e)).toList() : [];
    return list;
  }
}

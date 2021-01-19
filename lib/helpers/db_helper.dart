import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/place.dart';

const String table = 'places';
const String id = 'id';
const String title = 'title';
const String image = 'image';
const String latitude = 'loc_lat';
const String longitude = 'loc_lng';
const String address = 'addr';

class DbHelper {
  static Future<Database> database() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, '$table.db');
    final String sql =
        'CREATE TABLE $table ($id TEXT PRIMARY KEY, $title TEXT, $image TEXT, $latitude REAL, $longitude REAL, $address TEXT)';
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async => await db.execute(sql),
    );
  }

  static Future<void> insert(Place data) async {
    final db = await DbHelper.database();
    await db.insert(
      table,
      {
        id: data.id,
        title: data.title,
        image: data.image.path,
        latitude: data.location.latitude,
        longitude: data.location.longitude,
        address: data.location.address,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DbHelper.database();
    return db.query(table);
  }
}

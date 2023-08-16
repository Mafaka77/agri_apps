import 'package:agri_farmers_app/Data/AllDatabaseQueryString.dart';
import 'package:sqflite/sqflite.dart';

import 'DatabaseConnection.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }

  getRdBlockByDistrictId(table, id) async {
    var connection = await database;
    return await connection
        ?.query(table, where: 'district_id=?', whereArgs: [id]);
  }

  getVillageByRdBlock(table, id) async {
    var connection = await database;
    return await connection?.query(table, where: 'block_id=?', whereArgs: [id]);
  }

  getAllFarmers() async {
    var connection = await database;
    return await connection?.rawQuery(getAllFarmersQuery);
    // return await connection?.rawQuery(
    //     "SELECT full_name,district_id,district_name from farmers LEFT JOIN districts ON district_id=districts.id");
  }

  getFarmerBankDetails(table, id) async {
    var connection = await database;
    return await connection
        ?.query(table, where: 'farmers_id=?', whereArgs: [id]);
  }
}

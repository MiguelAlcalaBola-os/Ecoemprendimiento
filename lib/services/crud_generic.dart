// import 'package:flutter/material.dart';

// abstract class BaseModel {
//   int id;
//   Map<String, dynamic> toJson();
//   BaseModel fromJson(Map<String, dynamic> json);
// }

// class Dao<T extends BaseModel> {
//   Future<Database> get db => DatabaseProvider.dbProvider.database;
//   final String tableName;
//   final BaseModel instance;

//   Dao(this.instance, {@required this.tableName});

//   BaseModel fromJson(dynamic map) => instance.fromJson(map);

//   Future<T> find(int id) async {
//     final dbClient = await db;
//     var map = await dbClient.query(tableName, where: "id = ?", whereArgs: [id]);
//     return fromJson(map.first) as T;
//   }

//   Future<List<T>> getAll() async {
//     var dbClient = await db;
//     var map = await dbClient.query(tableName);
//     return List.generate(map.length, (i) => fromJson(map[i]) as T);
//   }

//   Future<int> insert(BaseModel model) async {
//     var dbClient = await db;
//     return await dbClient.insert(tableName, model.toJson());
//   }

//   Future<void> update(BaseModel model) async {
//     final dbClient = await db;
//     await dbClient.update(
//       tableName,
//       model.toJson(),
//       where: "id = ?",
//       whereArgs: [model.id],
//     );
//   }

//   Future<void> delete(BaseModel model) async {
//     final dbClient = await db;
//     await dbClient.delete(tableName, where: "id = ?", whereArgs: [model.id]);
//   }

//   Future<void> deleteById(int id) async {
//     final dbClient = await db;
//     await dbClient.delete(tableName, where: "id = ?", whereArgs: [id]);
//   }
// }

// class ReminderRepository {
//   final dao = Dao<Reminder>(Reminder(), tableName: REMINDER_DB_TABLE);
//   Future<Reminder> find(int id) => dao.find(id);
//   Future<List<Reminder>> getAll() => dao.getAll();
//   Future<int> insert(Reminder reminder) => dao.insert(reminder);
//   Future<void> update(Reminder reminder) => dao.update(reminder);
//   Future<void> delete(Reminder reminder) => dao.delete(reminder);
//   Future<void> deleteById(int id) => dao.deleteById(id);
// }
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:laboratorio/model/user.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'jja.sqlite'));
    print('Database file path: ${file.path}');
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
  Future<int> createUser(UsersCompanion user) async {
    return await into(users).insert(user);
  }

  // Read
  Future<List<User>> getAllUsers() async {
    return await select(users).get();
  }

  Future<User?> getUserById(int id) async {
    return await (select(users)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  // Update
  Future<bool> updateUser(User user) async {
    return await update(users).replace(user);
  }

  // Delete
  Future<int> deleteUser(int id) async {
    return await (delete(users)..where((tbl) => tbl.id.equals(id))).go();
  }
}


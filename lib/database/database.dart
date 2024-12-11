import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:laboratorio/model/user.dart';
import 'package:laboratorio/model/categories.dart';
import 'package:laboratorio/model/chats.dart';
import 'package:laboratorio/model/messages.dart';
import 'package:laboratorio/model/filesdb.dart';
import 'package:laboratorio/model/category_chat.dart';
import 'package:laboratorio/model/file_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drift/drift.dart' as drift;
part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'jja.sqlite'));
    print('Database file path: ${file.path}');

    return NativeDatabase(
      file,
      setup: (database) {
        // Habilita as chaves estrangeiras
        database.execute('PRAGMA foreign_keys = ON;');
      },
    );
  });
}

@DriftDatabase(tables: [Users, Categories, Chats, Messages, Filesdb, CategoryChat, FileMessage])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  get database => null;
  Future<int> createUser(UsersCompanion user) async {
    return await into(users).insert(user);
  }

  // User
  Future<List<User>> getAllUsers() async {
    return await select(users).get();
  }

  Future<User?> getUserById(int id) async {
    return await (select(users)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<bool> updateUser(User user) async {
    return await update(users).replace(user);
  }

  Future<int> deleteUser(int id) async {
    return await (delete(users)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> _saveImage(XFile image) async {
    final file = FilesdbCompanion.insert(
      mimeType: 'image/jpeg', // Adjust as needed
      size: await image.length(),
      path: image.path,
      duration: const Value.absent(),
    );

    try {
      await database.into(database.filesdb).insert(file);
    } catch (e) {
      print('Error saving image: $e');
    }
  }
}


import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:JAJA/schemas/objectives.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:JAJA/schemas/users.dart';
import 'package:JAJA/schemas/categories.dart';
import 'package:JAJA/schemas/chats.dart';
import 'package:JAJA/schemas/messages.dart';
import 'package:JAJA/schemas/files.dart';
import 'package:JAJA/schemas/category_chat.dart';
import 'package:JAJA/schemas/file_message.dart';
import 'package:JAJA/schemas/objectives.dart';
part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'jja.sqlite'));
    print('Database file path: ${file.path}');

    return NativeDatabase(
      file,
      setup: (database) {
        database.execute('PRAGMA foreign_keys = ON;');
      },
    );
  });
}

@DriftDatabase(tables: [Users, Categories, Chats, Messages, Filesdb, CategoryChat, FileMessage, Objectives])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  get database => null;

  Future<int> createRecord<T extends Table, D extends DataClass>(
    TableInfo<T, D> table,
    Insertable<D> companion,
  ) {
    return into(table).insert(companion);
  }

  Future<List<D>> getAllRecords<T extends Table, D extends DataClass>(
    TableInfo<T, D> table,
  ) {
    return select(table).get();
  }

  Future<D?> getRecordById<T extends Table, D extends DataClass>(
    TableInfo<T, D> table,
    int id,
  ) async {
    final idColumn = table.$columns
      .firstWhere((col) => col.$name == 'id') as GeneratedColumn<int>;

    final query = select(table)..where((row) => idColumn.equals(id));
    return query.getSingleOrNull();
  }

  Future<bool> updateRecord<T extends Table, D extends DataClass>(
    TableInfo<T, D> table,
    Insertable<D> data,
  ) {
    return update(table).replace(data);
  }

  Future<int> deleteRecordById<T extends Table, D extends DataClass>(
    TableInfo<T, D> table,
    int id,
  ) {
    final idColumn = table.$columns
      .firstWhere((col) => col.$name == 'id') as GeneratedColumn<int>;

    return (delete(table)..where((row) => idColumn.equals(id))).go();
  }

  Future<FilesdbData?> saveFile(File file, {String mimeType = 'image/jpeg', int? duration = 0}) async {
    final finalFile = FilesdbCompanion.insert(
      mimeType: mimeType,
      size: await file.length(),
      path: file.path,
      duration: Value(duration),
    );

    var id = await createRecord(filesdb, finalFile);

    return getRecordById(filesdb, id);
  }
}

AppDatabase db = AppDatabase();
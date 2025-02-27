import 'package:drift/drift.dart';
import 'package:JAJA/schemas/files.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named('name')();
  TextColumn get email => text().named('email')();
  TextColumn get description => text().named('description')();
  BoolColumn get isSaveChats => boolean().withDefault(const Constant(false))();
  IntColumn get photoId => integer().named('photo_id').nullable().references(Filesdb, #id)();
}
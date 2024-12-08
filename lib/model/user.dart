import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named('name')();
  TextColumn get email => text().named('email')();
  BoolColumn get isSaveChats => boolean().withDefault(const Constant(false))();
  TextColumn get photoId => text().nullable().named('photoId')();
  TextColumn get language => text().named('language')();
}
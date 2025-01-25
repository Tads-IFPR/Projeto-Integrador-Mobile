import 'package:drift/drift.dart';
import 'package:laboratorio/schemas/users.dart';

class Chats extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().named('title')();
  IntColumn get userId => integer().nullable().named('user_id').references(Users, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime).named('created_at')();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime).named('updated_at')();
  DateTimeColumn get deletedAt => dateTime().nullable().named('deleted_at')();
}
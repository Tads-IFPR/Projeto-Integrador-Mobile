import 'package:drift/drift.dart';
import 'package:laboratorio/model/chats.dart';

class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chatId => integer().named('chat_id').references(Chats, #id)();
  TextColumn get messageText => text().named('text')();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();
  BoolColumn get isBot => boolean().named('is_bot')();
}
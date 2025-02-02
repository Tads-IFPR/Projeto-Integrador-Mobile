import 'package:drift/drift.dart';
import 'package:JAJA/schemas/chats.dart';

class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chatId => integer().named('chat_id').references(Chats, #id)();
  TextColumn get messageText => text().named('text')();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime).named('created_at')();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime).named('updated_at')();
  BoolColumn get isBot => boolean().named('is_bot')();
  BoolColumn get isAudio => boolean().named('is_audio')();
}
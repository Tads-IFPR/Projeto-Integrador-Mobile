import 'package:drift/drift.dart';
import 'package:laboratorio/model/messages.dart';

class FileMessage extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get messageId => integer().named('message_id').references(Messages, #id)();
  TextColumn get fileId => text().named('file_id')();
}
import 'package:drift/drift.dart';
import 'package:laboratorio/schemas/messages.dart';

class FileMessage extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get messageId => integer().named('message_id').references(Messages, #id)();
  IntColumn get fileId => integer().named('file_id')();
}
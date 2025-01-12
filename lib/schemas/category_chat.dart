import 'package:drift/drift.dart';
import 'package:laboratorio/schemas/categories.dart';
import 'package:laboratorio/schemas/chats.dart';

class CategoryChat extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().named('category_id').references(Categories, #id)();
  IntColumn get chatId => integer().named('chat_id').references(Chats, #id)();
}
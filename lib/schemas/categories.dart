import 'package:drift/drift.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named('name')();
  IntColumn get frequency => integer().withDefault(const Constant(1)).named('frequency')();
}
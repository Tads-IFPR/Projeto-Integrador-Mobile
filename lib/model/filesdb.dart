import 'package:drift/drift.dart';

class Filesdb extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mimeType => text().named('mime_type')();
  IntColumn get size => integer().named('size')();
  TextColumn get path => text().named('path')();
  IntColumn get duration => integer().nullable().named('duration')();
}
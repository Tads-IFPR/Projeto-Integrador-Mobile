import 'package:drift/drift.dart';
import 'package:JAJA/schemas/users.dart';


enum ObjectiveType {
  chats,
  messages
}

extension ObjectiveTypeExtension on ObjectiveType {
  int toInt() {
    return this.index;
  }

  static ObjectiveType fromInt(int index) {
    return ObjectiveType.values[index];
  }
}

class Objectives extends Table{

  IntColumn get id => integer().autoIncrement()();
  IntColumn get value => integer().named('value')();
  TextColumn get description => text().named('description')();
  IntColumn get userId => integer().named('userId').references(Users, #id)();
  IntColumn get type => integer().map(const EnumIndexConverter<ObjectiveType>(ObjectiveType.values)).named('type')();
}
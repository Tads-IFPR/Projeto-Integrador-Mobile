import 'package:drift/drift.dart';
import 'package:laboratorio/schemas/users.dart';


enum ObjectiveType {
  quantidade_horas,
  quantidade_dias,
  quantidade_semanas,
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
  ColumnBuilder<int> get userId => integer().named('userId').references(Users() as Type, #id);
  IntColumn get type => integer().map(const EnumIndexConverter<ObjectiveType>(ObjectiveType.values)).named('type')();
}
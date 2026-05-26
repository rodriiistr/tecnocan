import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get apellidoPaterno => text()();
  TextColumn get apellidoMaterno => text().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get email => text().unique()();
  TextColumn get password => text()();
  IntColumn get createdAt => integer().withDefault(Constant(0))();
}

class Pets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get name => text()();
  TextColumn get breed => text()();
  IntColumn get birthDate => integer()();
  TextColumn get sex => text()();
  TextColumn get photoPath => text().nullable()(); // ← NUEVO
}

class FeedingSchedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get petId => integer().references(Pets, #id)();
  IntColumn get frequency => integer()();
  IntColumn get createdAt => integer().withDefault(Constant(0))();
}

class FeedingTimes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get scheduleId => integer().references(FeedingSchedules, #id)();
  TextColumn get name => text()();
  TextColumn get time => text()();
  RealColumn get amount => real()();
}

class Devices extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get petId => integer().references(Pets, #id)();
  TextColumn get macAddress => text()();
  TextColumn get nickname => text().nullable()();
  IntColumn get connectedAt => integer().withDefault(Constant(0))();
}
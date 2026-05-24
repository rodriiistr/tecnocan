import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get email => text().unique()();
  TextColumn get password => text()();
  IntColumn get createdAt =>
      integer().withDefault(Constant(0))();
}

class Pets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get name => text()();
  TextColumn get breed => text()();
  IntColumn get birthDate => integer()();  // epoch ms
  TextColumn get sex => text()();          // 'macho' | 'hembra'
}

class FeedingSchedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get petId => integer().references(Pets, #id)();
  IntColumn get frequency => integer()();  // veces al día
  IntColumn get createdAt => integer().withDefault(Constant(0))();
}

class FeedingTimes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get scheduleId => integer().references(FeedingSchedules, #id)();
  TextColumn get name => text()();         // 'Desayuno', 'Cena', etc.
  TextColumn get time => text()();         // 'HH:mm'
  RealColumn get amount => real()();       // gramos
}

class Devices extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get petId => integer().references(Pets, #id)();
  TextColumn get macAddress => text()();
  TextColumn get nickname => text().nullable()();
  IntColumn get connectedAt => integer().withDefault(Constant(0))();
}
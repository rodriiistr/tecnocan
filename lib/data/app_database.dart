import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Users, Pets, FeedingSchedules, FeedingTimes, Devices],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // Opción A: borra todo y recrea limpio
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
          }
          await m.createAll();
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  // ───────────────── USERS ─────────────────

  Future<int> createUser(UsersCompanion user) =>
      into(users).insert(user);

  Future<User?> getUserByEmail(String email) =>
      (select(users)..where((u) => u.email.equals(email)))
          .getSingleOrNull();

  Future<User?> getUserById(int id) =>
      (select(users)..where((u) => u.id.equals(id)))
          .getSingleOrNull();

  Future<bool> updateUser(UsersCompanion user) =>
      update(users).replace(user);

  // ───────────────── PETS ─────────────────

  Future<int> createPet(PetsCompanion pet) =>
      into(pets).insert(pet);

  Future<List<Pet>> getPetsForUser(int userId) =>
      (select(pets)..where((p) => p.userId.equals(userId))).get();

  Future<Pet?> getPetById(int petId) =>
      (select(pets)..where((p) => p.id.equals(petId))).getSingleOrNull();

  Future<bool> updatePet(Pet pet) =>
    update(pets).replace(pet);    

  // ───────────── FEEDING SCHEDULES ─────────────

  Future<int> createSchedule(FeedingSchedulesCompanion schedule) =>
      into(feedingSchedules).insert(schedule);

  Future<FeedingSchedule?> getScheduleForPet(int petId) =>
      (select(feedingSchedules)..where((s) => s.petId.equals(petId)))
          .getSingleOrNull();

  Future<bool> updateSchedule(
    FeedingSchedule schedule,
  ) =>
      update(feedingSchedules).replace(schedule);

  Future<bool> updateFeedingTime(
    FeedingTime time,
  ) =>
      update(feedingTimes).replace(time);

  Future<void> deleteTimesForSchedule(
    int scheduleId,
  ) =>
      (delete(feedingTimes)
            ..where((t) => t.scheduleId.equals(scheduleId)))
          .go();

  // ───────────── FEEDING TIMES ─────────────

  Future<void> insertFeedingTimes(List<FeedingTimesCompanion> times) =>
      batch((b) => b.insertAll(feedingTimes, times));

  Future<List<FeedingTime>> getTimesForSchedule(int scheduleId) =>
      (select(feedingTimes)
            ..where((t) => t.scheduleId.equals(scheduleId)))
          .get();

  // ───────────────── DEVICES ─────────────────

  Future<int> saveDevice(DevicesCompanion device) =>
      into(devices).insert(device, mode: InsertMode.insertOrReplace);

  Future<Device?> getDeviceForPet(int petId) =>
      (select(devices)..where((d) => d.petId.equals(petId)))
          .getSingleOrNull();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'tecnocan.db'));
    return NativeDatabase.createInBackground(file);
  });
}
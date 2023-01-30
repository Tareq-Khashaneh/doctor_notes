import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
part 'doctor_db.g.dart';

class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uniqueId => text()();

  TextColumn get patientId => text().nullable()();

  TextColumn get name => text()();

  TextColumn get phone => text()();

  DateTimeColumn get birthday => dateTime()();

  BoolColumn get isMale => boolean().withDefault(const Constant(false))();
}

class Visits extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get userId => text()();

  DateTimeColumn get visitDate => dateTime()();

  BoolColumn get isSmoker => boolean().withDefault(const Constant(false))();

  TextColumn get pastCase => text().nullable()();

  TextColumn get pastMedicines => text().nullable()();

  TextColumn get currentCase => text().nullable()();

  TextColumn get treatment => text().nullable()();

  TextColumn get notes => text().nullable()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getExternalStorageDirectory();
    final file = File(p.join(dbFolder?.path ?? '', 'doctor.db'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Patients, Visits])
class DoctorDB extends _$DoctorDB {
  DoctorDB() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Patients -START-
  Future<List<Patient>> getAllPatients() => select(patients).get();

  Future<List<Patient>> getAllPatientsBySearch(String search) =>
      (select(patients)..where((tbl) => tbl.name.contains(search) | tbl.phone.contains(search) | tbl.patientId.contains(search))).get();

  Future<Patient> getPatient(String uniqueId) =>
      (select(patients)..where((tbl) => tbl.uniqueId.equals(uniqueId)))
          .getSingle();

  Stream<List<Patient>> watchAllPatients() => select(patients).watch();

  Future<int> insertPatient(Patient patient) => into(patients).insert(PatientsCompanion.insert(uniqueId: patient.uniqueId, name: patient.name, phone: patient.phone, birthday: patient.birthday));

  Future<bool> updatePatient(Patient patient) => update(patients).replace(patient);

  Future<int> deletePatient(Patient patient) => delete(patients).delete(patient);

// Patients -END-
////////////////////////////////////////

// Visits -START-
  Future<List<Visit>> getAllVisits() => select(visits).get();
  
  Future<List<Visit>> getAllVisitsFromDate(DateTime lastDate) => (select(visits)..where((tbl) => tbl.visitDate.isBiggerOrEqualValue(lastDate))).get();

  // Future<Visit> getVisit(String userUniqueId) =>
  //     (select(visits)..where((tbl) => tbl.userId.equals(userUniqueId)))
  //         .getSingle();

  Future<Visit> getVisit(int id) =>
      (select(visits)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<List<Visit>> getPatientVisits(String userUniqueId) =>
      (select(visits)..where((tbl) => tbl.userId.equals(userUniqueId))).get();

  Stream<List<Visit>> watchAllVisits() => select(visits).watch();

  Future<int> insertVisit(Visit visit) => into(visits).insert(VisitsCompanion.insert(userId: visit.userId, visitDate: visit.visitDate, notes: Value(visit.notes), currentCase: Value(visit.currentCase), isSmoker: Value(visit.isSmoker), pastCase: Value(visit.pastCase), pastMedicines: Value(visit.pastMedicines), treatment: Value(visit.treatment)));

  Future<bool> updateVisit(Visit visit) => update(visits).replace(visit);

  Future<int> deleteVisit(Visit visit) => delete(visits).delete(visit);

// Visits -END-
////////////////////////////////////////

}

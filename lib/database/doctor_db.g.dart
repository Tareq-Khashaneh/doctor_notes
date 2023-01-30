// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_db.dart';

// ignore_for_file: type=lint
class $PatientsTable extends Patients with TableInfo<$PatientsTable, Patient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uniqueIdMeta =
      const VerificationMeta('uniqueId');
  @override
  late final GeneratedColumn<String> uniqueId = GeneratedColumn<String>(
      'unique_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  @override
  late final GeneratedColumn<DateTime> birthday = GeneratedColumn<DateTime>(
      'birthday', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isMaleMeta = const VerificationMeta('isMale');
  @override
  late final GeneratedColumn<bool> isMale =
      GeneratedColumn<bool>('is_male', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_male" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, uniqueId, patientId, name, phone, birthday, isMale];
  @override
  String get aliasedName => _alias ?? 'patients';
  @override
  String get actualTableName => 'patients';
  @override
  VerificationContext validateIntegrity(Insertable<Patient> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('unique_id')) {
      context.handle(_uniqueIdMeta,
          uniqueId.isAcceptableOrUnknown(data['unique_id']!, _uniqueIdMeta));
    } else if (isInserting) {
      context.missing(_uniqueIdMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    } else if (isInserting) {
      context.missing(_birthdayMeta);
    }
    if (data.containsKey('is_male')) {
      context.handle(_isMaleMeta,
          isMale.isAcceptableOrUnknown(data['is_male']!, _isMaleMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Patient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Patient(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uniqueId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unique_id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}birthday'])!,
      isMale: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_male'])!,
    );
  }

  @override
  $PatientsTable createAlias(String alias) {
    return $PatientsTable(attachedDatabase, alias);
  }
}

class Patient extends DataClass implements Insertable<Patient> {
  final int id;
  final String uniqueId;
  final String? patientId;
  final String name;
  final String phone;
  final DateTime birthday;
  final bool isMale;
  const Patient(
      {required this.id,
      required this.uniqueId,
      this.patientId,
      required this.name,
      required this.phone,
      required this.birthday,
      required this.isMale});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['unique_id'] = Variable<String>(uniqueId);
    if (!nullToAbsent || patientId != null) {
      map['patient_id'] = Variable<String>(patientId);
    }
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    map['birthday'] = Variable<DateTime>(birthday);
    map['is_male'] = Variable<bool>(isMale);
    return map;
  }

  PatientsCompanion toCompanion(bool nullToAbsent) {
    return PatientsCompanion(
      id: Value(id),
      uniqueId: Value(uniqueId),
      patientId: patientId == null && nullToAbsent
          ? const Value.absent()
          : Value(patientId),
      name: Value(name),
      phone: Value(phone),
      birthday: Value(birthday),
      isMale: Value(isMale),
    );
  }

  factory Patient.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Patient(
      id: serializer.fromJson<int>(json['id']),
      uniqueId: serializer.fromJson<String>(json['uniqueId']),
      patientId: serializer.fromJson<String?>(json['patientId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      birthday: serializer.fromJson<DateTime>(json['birthday']),
      isMale: serializer.fromJson<bool>(json['isMale']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uniqueId': serializer.toJson<String>(uniqueId),
      'patientId': serializer.toJson<String?>(patientId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'birthday': serializer.toJson<DateTime>(birthday),
      'isMale': serializer.toJson<bool>(isMale),
    };
  }

  Patient copyWith(
          {int? id,
          String? uniqueId,
          Value<String?> patientId = const Value.absent(),
          String? name,
          String? phone,
          DateTime? birthday,
          bool? isMale}) =>
      Patient(
        id: id ?? this.id,
        uniqueId: uniqueId ?? this.uniqueId,
        patientId: patientId.present ? patientId.value : this.patientId,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        birthday: birthday ?? this.birthday,
        isMale: isMale ?? this.isMale,
      );
  @override
  String toString() {
    return (StringBuffer('Patient(')
          ..write('id: $id, ')
          ..write('uniqueId: $uniqueId, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('birthday: $birthday, ')
          ..write('isMale: $isMale')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, uniqueId, patientId, name, phone, birthday, isMale);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Patient &&
          other.id == this.id &&
          other.uniqueId == this.uniqueId &&
          other.patientId == this.patientId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.birthday == this.birthday &&
          other.isMale == this.isMale);
}

class PatientsCompanion extends UpdateCompanion<Patient> {
  final Value<int> id;
  final Value<String> uniqueId;
  final Value<String?> patientId;
  final Value<String> name;
  final Value<String> phone;
  final Value<DateTime> birthday;
  final Value<bool> isMale;
  const PatientsCompanion({
    this.id = const Value.absent(),
    this.uniqueId = const Value.absent(),
    this.patientId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.birthday = const Value.absent(),
    this.isMale = const Value.absent(),
  });
  PatientsCompanion.insert({
    this.id = const Value.absent(),
    required String uniqueId,
    this.patientId = const Value.absent(),
    required String name,
    required String phone,
    required DateTime birthday,
    this.isMale = const Value.absent(),
  })  : uniqueId = Value(uniqueId),
        name = Value(name),
        phone = Value(phone),
        birthday = Value(birthday);
  static Insertable<Patient> custom({
    Expression<int>? id,
    Expression<String>? uniqueId,
    Expression<String>? patientId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<DateTime>? birthday,
    Expression<bool>? isMale,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uniqueId != null) 'unique_id': uniqueId,
      if (patientId != null) 'patient_id': patientId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (birthday != null) 'birthday': birthday,
      if (isMale != null) 'is_male': isMale,
    });
  }

  PatientsCompanion copyWith(
      {Value<int>? id,
      Value<String>? uniqueId,
      Value<String?>? patientId,
      Value<String>? name,
      Value<String>? phone,
      Value<DateTime>? birthday,
      Value<bool>? isMale}) {
    return PatientsCompanion(
      id: id ?? this.id,
      uniqueId: uniqueId ?? this.uniqueId,
      patientId: patientId ?? this.patientId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      isMale: isMale ?? this.isMale,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uniqueId.present) {
      map['unique_id'] = Variable<String>(uniqueId.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    if (isMale.present) {
      map['is_male'] = Variable<bool>(isMale.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsCompanion(')
          ..write('id: $id, ')
          ..write('uniqueId: $uniqueId, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('birthday: $birthday, ')
          ..write('isMale: $isMale')
          ..write(')'))
        .toString();
  }
}

class $VisitsTable extends Visits with TableInfo<$VisitsTable, Visit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VisitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _visitDateMeta =
      const VerificationMeta('visitDate');
  @override
  late final GeneratedColumn<DateTime> visitDate = GeneratedColumn<DateTime>(
      'visit_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isSmokerMeta =
      const VerificationMeta('isSmoker');
  @override
  late final GeneratedColumn<bool> isSmoker =
      GeneratedColumn<bool>('is_smoker', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_smoker" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _pastCaseMeta =
      const VerificationMeta('pastCase');
  @override
  late final GeneratedColumn<String> pastCase = GeneratedColumn<String>(
      'past_case', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pastMedicinesMeta =
      const VerificationMeta('pastMedicines');
  @override
  late final GeneratedColumn<String> pastMedicines = GeneratedColumn<String>(
      'past_medicines', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _currentCaseMeta =
      const VerificationMeta('currentCase');
  @override
  late final GeneratedColumn<String> currentCase = GeneratedColumn<String>(
      'current_case', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _treatmentMeta =
      const VerificationMeta('treatment');
  @override
  late final GeneratedColumn<String> treatment = GeneratedColumn<String>(
      'treatment', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        visitDate,
        isSmoker,
        pastCase,
        pastMedicines,
        currentCase,
        treatment,
        notes
      ];
  @override
  String get aliasedName => _alias ?? 'visits';
  @override
  String get actualTableName => 'visits';
  @override
  VerificationContext validateIntegrity(Insertable<Visit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('visit_date')) {
      context.handle(_visitDateMeta,
          visitDate.isAcceptableOrUnknown(data['visit_date']!, _visitDateMeta));
    } else if (isInserting) {
      context.missing(_visitDateMeta);
    }
    if (data.containsKey('is_smoker')) {
      context.handle(_isSmokerMeta,
          isSmoker.isAcceptableOrUnknown(data['is_smoker']!, _isSmokerMeta));
    }
    if (data.containsKey('past_case')) {
      context.handle(_pastCaseMeta,
          pastCase.isAcceptableOrUnknown(data['past_case']!, _pastCaseMeta));
    }
    if (data.containsKey('past_medicines')) {
      context.handle(
          _pastMedicinesMeta,
          pastMedicines.isAcceptableOrUnknown(
              data['past_medicines']!, _pastMedicinesMeta));
    }
    if (data.containsKey('current_case')) {
      context.handle(
          _currentCaseMeta,
          currentCase.isAcceptableOrUnknown(
              data['current_case']!, _currentCaseMeta));
    }
    if (data.containsKey('treatment')) {
      context.handle(_treatmentMeta,
          treatment.isAcceptableOrUnknown(data['treatment']!, _treatmentMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Visit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Visit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      visitDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}visit_date'])!,
      isSmoker: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_smoker'])!,
      pastCase: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}past_case']),
      pastMedicines: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}past_medicines']),
      currentCase: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}current_case']),
      treatment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}treatment']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $VisitsTable createAlias(String alias) {
    return $VisitsTable(attachedDatabase, alias);
  }
}

class Visit extends DataClass implements Insertable<Visit> {
  final int id;
  final String userId;
  final DateTime visitDate;
  final bool isSmoker;
  final String? pastCase;
  final String? pastMedicines;
  final String? currentCase;
  final String? treatment;
  final String? notes;
  const Visit(
      {required this.id,
      required this.userId,
      required this.visitDate,
      required this.isSmoker,
      this.pastCase,
      this.pastMedicines,
      this.currentCase,
      this.treatment,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['visit_date'] = Variable<DateTime>(visitDate);
    map['is_smoker'] = Variable<bool>(isSmoker);
    if (!nullToAbsent || pastCase != null) {
      map['past_case'] = Variable<String>(pastCase);
    }
    if (!nullToAbsent || pastMedicines != null) {
      map['past_medicines'] = Variable<String>(pastMedicines);
    }
    if (!nullToAbsent || currentCase != null) {
      map['current_case'] = Variable<String>(currentCase);
    }
    if (!nullToAbsent || treatment != null) {
      map['treatment'] = Variable<String>(treatment);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  VisitsCompanion toCompanion(bool nullToAbsent) {
    return VisitsCompanion(
      id: Value(id),
      userId: Value(userId),
      visitDate: Value(visitDate),
      isSmoker: Value(isSmoker),
      pastCase: pastCase == null && nullToAbsent
          ? const Value.absent()
          : Value(pastCase),
      pastMedicines: pastMedicines == null && nullToAbsent
          ? const Value.absent()
          : Value(pastMedicines),
      currentCase: currentCase == null && nullToAbsent
          ? const Value.absent()
          : Value(currentCase),
      treatment: treatment == null && nullToAbsent
          ? const Value.absent()
          : Value(treatment),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory Visit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Visit(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      visitDate: serializer.fromJson<DateTime>(json['visitDate']),
      isSmoker: serializer.fromJson<bool>(json['isSmoker']),
      pastCase: serializer.fromJson<String?>(json['pastCase']),
      pastMedicines: serializer.fromJson<String?>(json['pastMedicines']),
      currentCase: serializer.fromJson<String?>(json['currentCase']),
      treatment: serializer.fromJson<String?>(json['treatment']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'visitDate': serializer.toJson<DateTime>(visitDate),
      'isSmoker': serializer.toJson<bool>(isSmoker),
      'pastCase': serializer.toJson<String?>(pastCase),
      'pastMedicines': serializer.toJson<String?>(pastMedicines),
      'currentCase': serializer.toJson<String?>(currentCase),
      'treatment': serializer.toJson<String?>(treatment),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Visit copyWith(
          {int? id,
          String? userId,
          DateTime? visitDate,
          bool? isSmoker,
          Value<String?> pastCase = const Value.absent(),
          Value<String?> pastMedicines = const Value.absent(),
          Value<String?> currentCase = const Value.absent(),
          Value<String?> treatment = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      Visit(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        visitDate: visitDate ?? this.visitDate,
        isSmoker: isSmoker ?? this.isSmoker,
        pastCase: pastCase.present ? pastCase.value : this.pastCase,
        pastMedicines:
            pastMedicines.present ? pastMedicines.value : this.pastMedicines,
        currentCase: currentCase.present ? currentCase.value : this.currentCase,
        treatment: treatment.present ? treatment.value : this.treatment,
        notes: notes.present ? notes.value : this.notes,
      );
  @override
  String toString() {
    return (StringBuffer('Visit(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('visitDate: $visitDate, ')
          ..write('isSmoker: $isSmoker, ')
          ..write('pastCase: $pastCase, ')
          ..write('pastMedicines: $pastMedicines, ')
          ..write('currentCase: $currentCase, ')
          ..write('treatment: $treatment, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, visitDate, isSmoker, pastCase,
      pastMedicines, currentCase, treatment, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Visit &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.visitDate == this.visitDate &&
          other.isSmoker == this.isSmoker &&
          other.pastCase == this.pastCase &&
          other.pastMedicines == this.pastMedicines &&
          other.currentCase == this.currentCase &&
          other.treatment == this.treatment &&
          other.notes == this.notes);
}

class VisitsCompanion extends UpdateCompanion<Visit> {
  final Value<int> id;
  final Value<String> userId;
  final Value<DateTime> visitDate;
  final Value<bool> isSmoker;
  final Value<String?> pastCase;
  final Value<String?> pastMedicines;
  final Value<String?> currentCase;
  final Value<String?> treatment;
  final Value<String?> notes;
  const VisitsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.visitDate = const Value.absent(),
    this.isSmoker = const Value.absent(),
    this.pastCase = const Value.absent(),
    this.pastMedicines = const Value.absent(),
    this.currentCase = const Value.absent(),
    this.treatment = const Value.absent(),
    this.notes = const Value.absent(),
  });
  VisitsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required DateTime visitDate,
    this.isSmoker = const Value.absent(),
    this.pastCase = const Value.absent(),
    this.pastMedicines = const Value.absent(),
    this.currentCase = const Value.absent(),
    this.treatment = const Value.absent(),
    this.notes = const Value.absent(),
  })  : userId = Value(userId),
        visitDate = Value(visitDate);
  static Insertable<Visit> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<DateTime>? visitDate,
    Expression<bool>? isSmoker,
    Expression<String>? pastCase,
    Expression<String>? pastMedicines,
    Expression<String>? currentCase,
    Expression<String>? treatment,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (visitDate != null) 'visit_date': visitDate,
      if (isSmoker != null) 'is_smoker': isSmoker,
      if (pastCase != null) 'past_case': pastCase,
      if (pastMedicines != null) 'past_medicines': pastMedicines,
      if (currentCase != null) 'current_case': currentCase,
      if (treatment != null) 'treatment': treatment,
      if (notes != null) 'notes': notes,
    });
  }

  VisitsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<DateTime>? visitDate,
      Value<bool>? isSmoker,
      Value<String?>? pastCase,
      Value<String?>? pastMedicines,
      Value<String?>? currentCase,
      Value<String?>? treatment,
      Value<String?>? notes}) {
    return VisitsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      visitDate: visitDate ?? this.visitDate,
      isSmoker: isSmoker ?? this.isSmoker,
      pastCase: pastCase ?? this.pastCase,
      pastMedicines: pastMedicines ?? this.pastMedicines,
      currentCase: currentCase ?? this.currentCase,
      treatment: treatment ?? this.treatment,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (visitDate.present) {
      map['visit_date'] = Variable<DateTime>(visitDate.value);
    }
    if (isSmoker.present) {
      map['is_smoker'] = Variable<bool>(isSmoker.value);
    }
    if (pastCase.present) {
      map['past_case'] = Variable<String>(pastCase.value);
    }
    if (pastMedicines.present) {
      map['past_medicines'] = Variable<String>(pastMedicines.value);
    }
    if (currentCase.present) {
      map['current_case'] = Variable<String>(currentCase.value);
    }
    if (treatment.present) {
      map['treatment'] = Variable<String>(treatment.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('visitDate: $visitDate, ')
          ..write('isSmoker: $isSmoker, ')
          ..write('pastCase: $pastCase, ')
          ..write('pastMedicines: $pastMedicines, ')
          ..write('currentCase: $currentCase, ')
          ..write('treatment: $treatment, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

abstract class _$DoctorDB extends GeneratedDatabase {
  _$DoctorDB(QueryExecutor e) : super(e);
  late final $PatientsTable patients = $PatientsTable(this);
  late final $VisitsTable visits = $VisitsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [patients, visits];
}

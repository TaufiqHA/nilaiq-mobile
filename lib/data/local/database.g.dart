// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CachedClassesTable extends CachedClasses
    with TableInfo<$CachedClassesTable, CachedClass> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedClassesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_classes';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedClass> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedClass map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedClass(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $CachedClassesTable createAlias(String alias) {
    return $CachedClassesTable(attachedDatabase, alias);
  }
}

class CachedClass extends DataClass implements Insertable<CachedClass> {
  final int id;
  final String name;
  const CachedClass({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  CachedClassesCompanion toCompanion(bool nullToAbsent) {
    return CachedClassesCompanion(id: Value(id), name: Value(name));
  }

  factory CachedClass.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedClass(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  CachedClass copyWith({int? id, String? name}) =>
      CachedClass(id: id ?? this.id, name: name ?? this.name);
  CachedClass copyWithCompanion(CachedClassesCompanion data) {
    return CachedClass(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedClass(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedClass && other.id == this.id && other.name == this.name);
}

class CachedClassesCompanion extends UpdateCompanion<CachedClass> {
  final Value<int> id;
  final Value<String> name;
  const CachedClassesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  CachedClassesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<CachedClass> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  CachedClassesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return CachedClassesCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedClassesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $CachedStudentsTable extends CachedStudents
    with TableInfo<$CachedStudentsTable, CachedStudent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedStudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<int> classId = GeneratedColumn<int>(
    'class_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nisMeta = const VerificationMeta('nis');
  @override
  late final GeneratedColumn<String> nis = GeneratedColumn<String>(
    'nis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, classId, name, nis, gender];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_students';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedStudent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('nis')) {
      context.handle(
        _nisMeta,
        nis.isAcceptableOrUnknown(data['nis']!, _nisMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedStudent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedStudent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}class_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nis'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
    );
  }

  @override
  $CachedStudentsTable createAlias(String alias) {
    return $CachedStudentsTable(attachedDatabase, alias);
  }
}

class CachedStudent extends DataClass implements Insertable<CachedStudent> {
  final int id;
  final int? classId;
  final String name;
  final String? nis;
  final String? gender;
  const CachedStudent({
    required this.id,
    this.classId,
    required this.name,
    this.nis,
    this.gender,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || classId != null) {
      map['class_id'] = Variable<int>(classId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || nis != null) {
      map['nis'] = Variable<String>(nis);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    return map;
  }

  CachedStudentsCompanion toCompanion(bool nullToAbsent) {
    return CachedStudentsCompanion(
      id: Value(id),
      classId: classId == null && nullToAbsent
          ? const Value.absent()
          : Value(classId),
      name: Value(name),
      nis: nis == null && nullToAbsent ? const Value.absent() : Value(nis),
      gender: gender == null && nullToAbsent
          ? const Value.absent()
          : Value(gender),
    );
  }

  factory CachedStudent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedStudent(
      id: serializer.fromJson<int>(json['id']),
      classId: serializer.fromJson<int?>(json['classId']),
      name: serializer.fromJson<String>(json['name']),
      nis: serializer.fromJson<String?>(json['nis']),
      gender: serializer.fromJson<String?>(json['gender']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'classId': serializer.toJson<int?>(classId),
      'name': serializer.toJson<String>(name),
      'nis': serializer.toJson<String?>(nis),
      'gender': serializer.toJson<String?>(gender),
    };
  }

  CachedStudent copyWith({
    int? id,
    Value<int?> classId = const Value.absent(),
    String? name,
    Value<String?> nis = const Value.absent(),
    Value<String?> gender = const Value.absent(),
  }) => CachedStudent(
    id: id ?? this.id,
    classId: classId.present ? classId.value : this.classId,
    name: name ?? this.name,
    nis: nis.present ? nis.value : this.nis,
    gender: gender.present ? gender.value : this.gender,
  );
  CachedStudent copyWithCompanion(CachedStudentsCompanion data) {
    return CachedStudent(
      id: data.id.present ? data.id.value : this.id,
      classId: data.classId.present ? data.classId.value : this.classId,
      name: data.name.present ? data.name.value : this.name,
      nis: data.nis.present ? data.nis.value : this.nis,
      gender: data.gender.present ? data.gender.value : this.gender,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedStudent(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('name: $name, ')
          ..write('nis: $nis, ')
          ..write('gender: $gender')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, classId, name, nis, gender);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedStudent &&
          other.id == this.id &&
          other.classId == this.classId &&
          other.name == this.name &&
          other.nis == this.nis &&
          other.gender == this.gender);
}

class CachedStudentsCompanion extends UpdateCompanion<CachedStudent> {
  final Value<int> id;
  final Value<int?> classId;
  final Value<String> name;
  final Value<String?> nis;
  final Value<String?> gender;
  const CachedStudentsCompanion({
    this.id = const Value.absent(),
    this.classId = const Value.absent(),
    this.name = const Value.absent(),
    this.nis = const Value.absent(),
    this.gender = const Value.absent(),
  });
  CachedStudentsCompanion.insert({
    this.id = const Value.absent(),
    this.classId = const Value.absent(),
    required String name,
    this.nis = const Value.absent(),
    this.gender = const Value.absent(),
  }) : name = Value(name);
  static Insertable<CachedStudent> custom({
    Expression<int>? id,
    Expression<int>? classId,
    Expression<String>? name,
    Expression<String>? nis,
    Expression<String>? gender,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (classId != null) 'class_id': classId,
      if (name != null) 'name': name,
      if (nis != null) 'nis': nis,
      if (gender != null) 'gender': gender,
    });
  }

  CachedStudentsCompanion copyWith({
    Value<int>? id,
    Value<int?>? classId,
    Value<String>? name,
    Value<String?>? nis,
    Value<String?>? gender,
  }) {
    return CachedStudentsCompanion(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      name: name ?? this.name,
      nis: nis ?? this.nis,
      gender: gender ?? this.gender,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<int>(classId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nis.present) {
      map['nis'] = Variable<String>(nis.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedStudentsCompanion(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('name: $name, ')
          ..write('nis: $nis, ')
          ..write('gender: $gender')
          ..write(')'))
        .toString();
  }
}

class $MeetingRecordsTable extends MeetingRecords
    with TableInfo<$MeetingRecordsTable, MeetingRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeetingRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientUuidMeta = const VerificationMeta(
    'clientUuid',
  );
  @override
  late final GeneratedColumn<String> clientUuid = GeneratedColumn<String>(
    'client_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<int> classId = GeneratedColumn<int>(
    'class_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _classNameMeta = const VerificationMeta(
    'className',
  );
  @override
  late final GeneratedColumn<String> className = GeneratedColumn<String>(
    'class_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipeMeta = const VerificationMeta('tipe');
  @override
  late final GeneratedColumn<String> tipe = GeneratedColumn<String>(
    'tipe',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('harian'),
  );
  static const VerificationMeta _meetingDateMeta = const VerificationMeta(
    'meetingDate',
  );
  @override
  late final GeneratedColumn<DateTime> meetingDate = GeneratedColumn<DateTime>(
    'meeting_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    remoteId,
    clientUuid,
    classId,
    className,
    title,
    tipe,
    meetingDate,
    description,
    syncStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meeting_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<MeetingRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('client_uuid')) {
      context.handle(
        _clientUuidMeta,
        clientUuid.isAcceptableOrUnknown(data['client_uuid']!, _clientUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_clientUuidMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    }
    if (data.containsKey('class_name')) {
      context.handle(
        _classNameMeta,
        className.isAcceptableOrUnknown(data['class_name']!, _classNameMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('tipe')) {
      context.handle(
        _tipeMeta,
        tipe.isAcceptableOrUnknown(data['tipe']!, _tipeMeta),
      );
    }
    if (data.containsKey('meeting_date')) {
      context.handle(
        _meetingDateMeta,
        meetingDate.isAcceptableOrUnknown(
          data['meeting_date']!,
          _meetingDateMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  MeetingRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeetingRecord(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      clientUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_uuid'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}class_id'],
      ),
      className: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_name'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      tipe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipe'],
      )!,
      meetingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}meeting_date'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MeetingRecordsTable createAlias(String alias) {
    return $MeetingRecordsTable(attachedDatabase, alias);
  }
}

class MeetingRecord extends DataClass implements Insertable<MeetingRecord> {
  final int localId;
  final int? remoteId;
  final String clientUuid;
  final int? classId;
  final String? className;
  final String title;
  final String tipe;
  final DateTime? meetingDate;
  final String? description;
  final String syncStatus;
  final DateTime updatedAt;
  const MeetingRecord({
    required this.localId,
    this.remoteId,
    required this.clientUuid,
    this.classId,
    this.className,
    required this.title,
    required this.tipe,
    this.meetingDate,
    this.description,
    required this.syncStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['client_uuid'] = Variable<String>(clientUuid);
    if (!nullToAbsent || classId != null) {
      map['class_id'] = Variable<int>(classId);
    }
    if (!nullToAbsent || className != null) {
      map['class_name'] = Variable<String>(className);
    }
    map['title'] = Variable<String>(title);
    map['tipe'] = Variable<String>(tipe);
    if (!nullToAbsent || meetingDate != null) {
      map['meeting_date'] = Variable<DateTime>(meetingDate);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MeetingRecordsCompanion toCompanion(bool nullToAbsent) {
    return MeetingRecordsCompanion(
      localId: Value(localId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      clientUuid: Value(clientUuid),
      classId: classId == null && nullToAbsent
          ? const Value.absent()
          : Value(classId),
      className: className == null && nullToAbsent
          ? const Value.absent()
          : Value(className),
      title: Value(title),
      tipe: Value(tipe),
      meetingDate: meetingDate == null && nullToAbsent
          ? const Value.absent()
          : Value(meetingDate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory MeetingRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeetingRecord(
      localId: serializer.fromJson<int>(json['localId']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      clientUuid: serializer.fromJson<String>(json['clientUuid']),
      classId: serializer.fromJson<int?>(json['classId']),
      className: serializer.fromJson<String?>(json['className']),
      title: serializer.fromJson<String>(json['title']),
      tipe: serializer.fromJson<String>(json['tipe']),
      meetingDate: serializer.fromJson<DateTime?>(json['meetingDate']),
      description: serializer.fromJson<String?>(json['description']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'remoteId': serializer.toJson<int?>(remoteId),
      'clientUuid': serializer.toJson<String>(clientUuid),
      'classId': serializer.toJson<int?>(classId),
      'className': serializer.toJson<String?>(className),
      'title': serializer.toJson<String>(title),
      'tipe': serializer.toJson<String>(tipe),
      'meetingDate': serializer.toJson<DateTime?>(meetingDate),
      'description': serializer.toJson<String?>(description),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MeetingRecord copyWith({
    int? localId,
    Value<int?> remoteId = const Value.absent(),
    String? clientUuid,
    Value<int?> classId = const Value.absent(),
    Value<String?> className = const Value.absent(),
    String? title,
    String? tipe,
    Value<DateTime?> meetingDate = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? syncStatus,
    DateTime? updatedAt,
  }) => MeetingRecord(
    localId: localId ?? this.localId,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    clientUuid: clientUuid ?? this.clientUuid,
    classId: classId.present ? classId.value : this.classId,
    className: className.present ? className.value : this.className,
    title: title ?? this.title,
    tipe: tipe ?? this.tipe,
    meetingDate: meetingDate.present ? meetingDate.value : this.meetingDate,
    description: description.present ? description.value : this.description,
    syncStatus: syncStatus ?? this.syncStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MeetingRecord copyWithCompanion(MeetingRecordsCompanion data) {
    return MeetingRecord(
      localId: data.localId.present ? data.localId.value : this.localId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      clientUuid: data.clientUuid.present
          ? data.clientUuid.value
          : this.clientUuid,
      classId: data.classId.present ? data.classId.value : this.classId,
      className: data.className.present ? data.className.value : this.className,
      title: data.title.present ? data.title.value : this.title,
      tipe: data.tipe.present ? data.tipe.value : this.tipe,
      meetingDate: data.meetingDate.present
          ? data.meetingDate.value
          : this.meetingDate,
      description: data.description.present
          ? data.description.value
          : this.description,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeetingRecord(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientUuid: $clientUuid, ')
          ..write('classId: $classId, ')
          ..write('className: $className, ')
          ..write('title: $title, ')
          ..write('tipe: $tipe, ')
          ..write('meetingDate: $meetingDate, ')
          ..write('description: $description, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    remoteId,
    clientUuid,
    classId,
    className,
    title,
    tipe,
    meetingDate,
    description,
    syncStatus,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeetingRecord &&
          other.localId == this.localId &&
          other.remoteId == this.remoteId &&
          other.clientUuid == this.clientUuid &&
          other.classId == this.classId &&
          other.className == this.className &&
          other.title == this.title &&
          other.tipe == this.tipe &&
          other.meetingDate == this.meetingDate &&
          other.description == this.description &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class MeetingRecordsCompanion extends UpdateCompanion<MeetingRecord> {
  final Value<int> localId;
  final Value<int?> remoteId;
  final Value<String> clientUuid;
  final Value<int?> classId;
  final Value<String?> className;
  final Value<String> title;
  final Value<String> tipe;
  final Value<DateTime?> meetingDate;
  final Value<String?> description;
  final Value<String> syncStatus;
  final Value<DateTime> updatedAt;
  const MeetingRecordsCompanion({
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.clientUuid = const Value.absent(),
    this.classId = const Value.absent(),
    this.className = const Value.absent(),
    this.title = const Value.absent(),
    this.tipe = const Value.absent(),
    this.meetingDate = const Value.absent(),
    this.description = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MeetingRecordsCompanion.insert({
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    required String clientUuid,
    this.classId = const Value.absent(),
    this.className = const Value.absent(),
    required String title,
    this.tipe = const Value.absent(),
    this.meetingDate = const Value.absent(),
    this.description = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : clientUuid = Value(clientUuid),
       title = Value(title);
  static Insertable<MeetingRecord> custom({
    Expression<int>? localId,
    Expression<int>? remoteId,
    Expression<String>? clientUuid,
    Expression<int>? classId,
    Expression<String>? className,
    Expression<String>? title,
    Expression<String>? tipe,
    Expression<DateTime>? meetingDate,
    Expression<String>? description,
    Expression<String>? syncStatus,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (remoteId != null) 'remote_id': remoteId,
      if (clientUuid != null) 'client_uuid': clientUuid,
      if (classId != null) 'class_id': classId,
      if (className != null) 'class_name': className,
      if (title != null) 'title': title,
      if (tipe != null) 'tipe': tipe,
      if (meetingDate != null) 'meeting_date': meetingDate,
      if (description != null) 'description': description,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MeetingRecordsCompanion copyWith({
    Value<int>? localId,
    Value<int?>? remoteId,
    Value<String>? clientUuid,
    Value<int?>? classId,
    Value<String?>? className,
    Value<String>? title,
    Value<String>? tipe,
    Value<DateTime?>? meetingDate,
    Value<String?>? description,
    Value<String>? syncStatus,
    Value<DateTime>? updatedAt,
  }) {
    return MeetingRecordsCompanion(
      localId: localId ?? this.localId,
      remoteId: remoteId ?? this.remoteId,
      clientUuid: clientUuid ?? this.clientUuid,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      title: title ?? this.title,
      tipe: tipe ?? this.tipe,
      meetingDate: meetingDate ?? this.meetingDate,
      description: description ?? this.description,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (clientUuid.present) {
      map['client_uuid'] = Variable<String>(clientUuid.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<int>(classId.value);
    }
    if (className.present) {
      map['class_name'] = Variable<String>(className.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (tipe.present) {
      map['tipe'] = Variable<String>(tipe.value);
    }
    if (meetingDate.present) {
      map['meeting_date'] = Variable<DateTime>(meetingDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeetingRecordsCompanion(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientUuid: $clientUuid, ')
          ..write('classId: $classId, ')
          ..write('className: $className, ')
          ..write('title: $title, ')
          ..write('tipe: $tipe, ')
          ..write('meetingDate: $meetingDate, ')
          ..write('description: $description, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AttendanceRecordsTable extends AttendanceRecords
    with TableInfo<$AttendanceRecordsTable, AttendanceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientUuidMeta = const VerificationMeta(
    'clientUuid',
  );
  @override
  late final GeneratedColumn<String> clientUuid = GeneratedColumn<String>(
    'client_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meetingLocalIdMeta = const VerificationMeta(
    'meetingLocalId',
  );
  @override
  late final GeneratedColumn<int> meetingLocalId = GeneratedColumn<int>(
    'meeting_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('HADIR'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending_create'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    remoteId,
    clientUuid,
    meetingLocalId,
    studentId,
    status,
    note,
    syncStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('client_uuid')) {
      context.handle(
        _clientUuidMeta,
        clientUuid.isAcceptableOrUnknown(data['client_uuid']!, _clientUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_clientUuidMeta);
    }
    if (data.containsKey('meeting_local_id')) {
      context.handle(
        _meetingLocalIdMeta,
        meetingLocalId.isAcceptableOrUnknown(
          data['meeting_local_id']!,
          _meetingLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_meetingLocalIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  AttendanceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceRecord(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      clientUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_uuid'],
      )!,
      meetingLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meeting_local_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AttendanceRecordsTable createAlias(String alias) {
    return $AttendanceRecordsTable(attachedDatabase, alias);
  }
}

class AttendanceRecord extends DataClass
    implements Insertable<AttendanceRecord> {
  final int localId;
  final int? remoteId;
  final String clientUuid;
  final int meetingLocalId;
  final int studentId;
  final String status;
  final String? note;
  final String syncStatus;
  final DateTime updatedAt;
  const AttendanceRecord({
    required this.localId,
    this.remoteId,
    required this.clientUuid,
    required this.meetingLocalId,
    required this.studentId,
    required this.status,
    this.note,
    required this.syncStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['client_uuid'] = Variable<String>(clientUuid);
    map['meeting_local_id'] = Variable<int>(meetingLocalId);
    map['student_id'] = Variable<int>(studentId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AttendanceRecordsCompanion toCompanion(bool nullToAbsent) {
    return AttendanceRecordsCompanion(
      localId: Value(localId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      clientUuid: Value(clientUuid),
      meetingLocalId: Value(meetingLocalId),
      studentId: Value(studentId),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory AttendanceRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceRecord(
      localId: serializer.fromJson<int>(json['localId']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      clientUuid: serializer.fromJson<String>(json['clientUuid']),
      meetingLocalId: serializer.fromJson<int>(json['meetingLocalId']),
      studentId: serializer.fromJson<int>(json['studentId']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'remoteId': serializer.toJson<int?>(remoteId),
      'clientUuid': serializer.toJson<String>(clientUuid),
      'meetingLocalId': serializer.toJson<int>(meetingLocalId),
      'studentId': serializer.toJson<int>(studentId),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AttendanceRecord copyWith({
    int? localId,
    Value<int?> remoteId = const Value.absent(),
    String? clientUuid,
    int? meetingLocalId,
    int? studentId,
    String? status,
    Value<String?> note = const Value.absent(),
    String? syncStatus,
    DateTime? updatedAt,
  }) => AttendanceRecord(
    localId: localId ?? this.localId,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    clientUuid: clientUuid ?? this.clientUuid,
    meetingLocalId: meetingLocalId ?? this.meetingLocalId,
    studentId: studentId ?? this.studentId,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
    syncStatus: syncStatus ?? this.syncStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AttendanceRecord copyWithCompanion(AttendanceRecordsCompanion data) {
    return AttendanceRecord(
      localId: data.localId.present ? data.localId.value : this.localId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      clientUuid: data.clientUuid.present
          ? data.clientUuid.value
          : this.clientUuid,
      meetingLocalId: data.meetingLocalId.present
          ? data.meetingLocalId.value
          : this.meetingLocalId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceRecord(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientUuid: $clientUuid, ')
          ..write('meetingLocalId: $meetingLocalId, ')
          ..write('studentId: $studentId, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    remoteId,
    clientUuid,
    meetingLocalId,
    studentId,
    status,
    note,
    syncStatus,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceRecord &&
          other.localId == this.localId &&
          other.remoteId == this.remoteId &&
          other.clientUuid == this.clientUuid &&
          other.meetingLocalId == this.meetingLocalId &&
          other.studentId == this.studentId &&
          other.status == this.status &&
          other.note == this.note &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class AttendanceRecordsCompanion extends UpdateCompanion<AttendanceRecord> {
  final Value<int> localId;
  final Value<int?> remoteId;
  final Value<String> clientUuid;
  final Value<int> meetingLocalId;
  final Value<int> studentId;
  final Value<String> status;
  final Value<String?> note;
  final Value<String> syncStatus;
  final Value<DateTime> updatedAt;
  const AttendanceRecordsCompanion({
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.clientUuid = const Value.absent(),
    this.meetingLocalId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AttendanceRecordsCompanion.insert({
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    required String clientUuid,
    required int meetingLocalId,
    required int studentId,
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : clientUuid = Value(clientUuid),
       meetingLocalId = Value(meetingLocalId),
       studentId = Value(studentId);
  static Insertable<AttendanceRecord> custom({
    Expression<int>? localId,
    Expression<int>? remoteId,
    Expression<String>? clientUuid,
    Expression<int>? meetingLocalId,
    Expression<int>? studentId,
    Expression<String>? status,
    Expression<String>? note,
    Expression<String>? syncStatus,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (remoteId != null) 'remote_id': remoteId,
      if (clientUuid != null) 'client_uuid': clientUuid,
      if (meetingLocalId != null) 'meeting_local_id': meetingLocalId,
      if (studentId != null) 'student_id': studentId,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AttendanceRecordsCompanion copyWith({
    Value<int>? localId,
    Value<int?>? remoteId,
    Value<String>? clientUuid,
    Value<int>? meetingLocalId,
    Value<int>? studentId,
    Value<String>? status,
    Value<String?>? note,
    Value<String>? syncStatus,
    Value<DateTime>? updatedAt,
  }) {
    return AttendanceRecordsCompanion(
      localId: localId ?? this.localId,
      remoteId: remoteId ?? this.remoteId,
      clientUuid: clientUuid ?? this.clientUuid,
      meetingLocalId: meetingLocalId ?? this.meetingLocalId,
      studentId: studentId ?? this.studentId,
      status: status ?? this.status,
      note: note ?? this.note,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (clientUuid.present) {
      map['client_uuid'] = Variable<String>(clientUuid.value);
    }
    if (meetingLocalId.present) {
      map['meeting_local_id'] = Variable<int>(meetingLocalId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceRecordsCompanion(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientUuid: $clientUuid, ')
          ..write('meetingLocalId: $meetingLocalId, ')
          ..write('studentId: $studentId, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DailyTestMeetingRecordsTable extends DailyTestMeetingRecords
    with TableInfo<$DailyTestMeetingRecordsTable, DailyTestMeetingRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyTestMeetingRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientUuidMeta = const VerificationMeta(
    'clientUuid',
  );
  @override
  late final GeneratedColumn<String> clientUuid = GeneratedColumn<String>(
    'client_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<int> classId = GeneratedColumn<int>(
    'class_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _classNameMeta = const VerificationMeta(
    'className',
  );
  @override
  late final GeneratedColumn<String> className = GeneratedColumn<String>(
    'class_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _testDateMeta = const VerificationMeta(
    'testDate',
  );
  @override
  late final GeneratedColumn<DateTime> testDate = GeneratedColumn<DateTime>(
    'test_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    remoteId,
    clientUuid,
    classId,
    className,
    title,
    testDate,
    description,
    syncStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_test_meeting_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyTestMeetingRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('client_uuid')) {
      context.handle(
        _clientUuidMeta,
        clientUuid.isAcceptableOrUnknown(data['client_uuid']!, _clientUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_clientUuidMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    }
    if (data.containsKey('class_name')) {
      context.handle(
        _classNameMeta,
        className.isAcceptableOrUnknown(data['class_name']!, _classNameMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('test_date')) {
      context.handle(
        _testDateMeta,
        testDate.isAcceptableOrUnknown(data['test_date']!, _testDateMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  DailyTestMeetingRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyTestMeetingRecord(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      clientUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_uuid'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}class_id'],
      ),
      className: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_name'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      testDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}test_date'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DailyTestMeetingRecordsTable createAlias(String alias) {
    return $DailyTestMeetingRecordsTable(attachedDatabase, alias);
  }
}

class DailyTestMeetingRecord extends DataClass
    implements Insertable<DailyTestMeetingRecord> {
  final int localId;
  final int? remoteId;
  final String clientUuid;
  final int? classId;
  final String? className;
  final String title;
  final DateTime? testDate;
  final String? description;
  final String syncStatus;
  final DateTime updatedAt;
  const DailyTestMeetingRecord({
    required this.localId,
    this.remoteId,
    required this.clientUuid,
    this.classId,
    this.className,
    required this.title,
    this.testDate,
    this.description,
    required this.syncStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['client_uuid'] = Variable<String>(clientUuid);
    if (!nullToAbsent || classId != null) {
      map['class_id'] = Variable<int>(classId);
    }
    if (!nullToAbsent || className != null) {
      map['class_name'] = Variable<String>(className);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || testDate != null) {
      map['test_date'] = Variable<DateTime>(testDate);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyTestMeetingRecordsCompanion toCompanion(bool nullToAbsent) {
    return DailyTestMeetingRecordsCompanion(
      localId: Value(localId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      clientUuid: Value(clientUuid),
      classId: classId == null && nullToAbsent
          ? const Value.absent()
          : Value(classId),
      className: className == null && nullToAbsent
          ? const Value.absent()
          : Value(className),
      title: Value(title),
      testDate: testDate == null && nullToAbsent
          ? const Value.absent()
          : Value(testDate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyTestMeetingRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyTestMeetingRecord(
      localId: serializer.fromJson<int>(json['localId']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      clientUuid: serializer.fromJson<String>(json['clientUuid']),
      classId: serializer.fromJson<int?>(json['classId']),
      className: serializer.fromJson<String?>(json['className']),
      title: serializer.fromJson<String>(json['title']),
      testDate: serializer.fromJson<DateTime?>(json['testDate']),
      description: serializer.fromJson<String?>(json['description']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'remoteId': serializer.toJson<int?>(remoteId),
      'clientUuid': serializer.toJson<String>(clientUuid),
      'classId': serializer.toJson<int?>(classId),
      'className': serializer.toJson<String?>(className),
      'title': serializer.toJson<String>(title),
      'testDate': serializer.toJson<DateTime?>(testDate),
      'description': serializer.toJson<String?>(description),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyTestMeetingRecord copyWith({
    int? localId,
    Value<int?> remoteId = const Value.absent(),
    String? clientUuid,
    Value<int?> classId = const Value.absent(),
    Value<String?> className = const Value.absent(),
    String? title,
    Value<DateTime?> testDate = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? syncStatus,
    DateTime? updatedAt,
  }) => DailyTestMeetingRecord(
    localId: localId ?? this.localId,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    clientUuid: clientUuid ?? this.clientUuid,
    classId: classId.present ? classId.value : this.classId,
    className: className.present ? className.value : this.className,
    title: title ?? this.title,
    testDate: testDate.present ? testDate.value : this.testDate,
    description: description.present ? description.value : this.description,
    syncStatus: syncStatus ?? this.syncStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DailyTestMeetingRecord copyWithCompanion(
    DailyTestMeetingRecordsCompanion data,
  ) {
    return DailyTestMeetingRecord(
      localId: data.localId.present ? data.localId.value : this.localId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      clientUuid: data.clientUuid.present
          ? data.clientUuid.value
          : this.clientUuid,
      classId: data.classId.present ? data.classId.value : this.classId,
      className: data.className.present ? data.className.value : this.className,
      title: data.title.present ? data.title.value : this.title,
      testDate: data.testDate.present ? data.testDate.value : this.testDate,
      description: data.description.present
          ? data.description.value
          : this.description,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyTestMeetingRecord(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientUuid: $clientUuid, ')
          ..write('classId: $classId, ')
          ..write('className: $className, ')
          ..write('title: $title, ')
          ..write('testDate: $testDate, ')
          ..write('description: $description, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    remoteId,
    clientUuid,
    classId,
    className,
    title,
    testDate,
    description,
    syncStatus,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyTestMeetingRecord &&
          other.localId == this.localId &&
          other.remoteId == this.remoteId &&
          other.clientUuid == this.clientUuid &&
          other.classId == this.classId &&
          other.className == this.className &&
          other.title == this.title &&
          other.testDate == this.testDate &&
          other.description == this.description &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class DailyTestMeetingRecordsCompanion
    extends UpdateCompanion<DailyTestMeetingRecord> {
  final Value<int> localId;
  final Value<int?> remoteId;
  final Value<String> clientUuid;
  final Value<int?> classId;
  final Value<String?> className;
  final Value<String> title;
  final Value<DateTime?> testDate;
  final Value<String?> description;
  final Value<String> syncStatus;
  final Value<DateTime> updatedAt;
  const DailyTestMeetingRecordsCompanion({
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.clientUuid = const Value.absent(),
    this.classId = const Value.absent(),
    this.className = const Value.absent(),
    this.title = const Value.absent(),
    this.testDate = const Value.absent(),
    this.description = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DailyTestMeetingRecordsCompanion.insert({
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    required String clientUuid,
    this.classId = const Value.absent(),
    this.className = const Value.absent(),
    required String title,
    this.testDate = const Value.absent(),
    this.description = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : clientUuid = Value(clientUuid),
       title = Value(title);
  static Insertable<DailyTestMeetingRecord> custom({
    Expression<int>? localId,
    Expression<int>? remoteId,
    Expression<String>? clientUuid,
    Expression<int>? classId,
    Expression<String>? className,
    Expression<String>? title,
    Expression<DateTime>? testDate,
    Expression<String>? description,
    Expression<String>? syncStatus,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (remoteId != null) 'remote_id': remoteId,
      if (clientUuid != null) 'client_uuid': clientUuid,
      if (classId != null) 'class_id': classId,
      if (className != null) 'class_name': className,
      if (title != null) 'title': title,
      if (testDate != null) 'test_date': testDate,
      if (description != null) 'description': description,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DailyTestMeetingRecordsCompanion copyWith({
    Value<int>? localId,
    Value<int?>? remoteId,
    Value<String>? clientUuid,
    Value<int?>? classId,
    Value<String?>? className,
    Value<String>? title,
    Value<DateTime?>? testDate,
    Value<String?>? description,
    Value<String>? syncStatus,
    Value<DateTime>? updatedAt,
  }) {
    return DailyTestMeetingRecordsCompanion(
      localId: localId ?? this.localId,
      remoteId: remoteId ?? this.remoteId,
      clientUuid: clientUuid ?? this.clientUuid,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      title: title ?? this.title,
      testDate: testDate ?? this.testDate,
      description: description ?? this.description,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (clientUuid.present) {
      map['client_uuid'] = Variable<String>(clientUuid.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<int>(classId.value);
    }
    if (className.present) {
      map['class_name'] = Variable<String>(className.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (testDate.present) {
      map['test_date'] = Variable<DateTime>(testDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyTestMeetingRecordsCompanion(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientUuid: $clientUuid, ')
          ..write('classId: $classId, ')
          ..write('className: $className, ')
          ..write('title: $title, ')
          ..write('testDate: $testDate, ')
          ..write('description: $description, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DailyTestScoreRecordsTable extends DailyTestScoreRecords
    with TableInfo<$DailyTestScoreRecordsTable, DailyTestScoreRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyTestScoreRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientUuidMeta = const VerificationMeta(
    'clientUuid',
  );
  @override
  late final GeneratedColumn<String> clientUuid = GeneratedColumn<String>(
    'client_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meetingLocalIdMeta = const VerificationMeta(
    'meetingLocalId',
  );
  @override
  late final GeneratedColumn<int> meetingLocalId = GeneratedColumn<int>(
    'meeting_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending_create'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    remoteId,
    clientUuid,
    meetingLocalId,
    studentId,
    score,
    syncStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_test_score_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyTestScoreRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('client_uuid')) {
      context.handle(
        _clientUuidMeta,
        clientUuid.isAcceptableOrUnknown(data['client_uuid']!, _clientUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_clientUuidMeta);
    }
    if (data.containsKey('meeting_local_id')) {
      context.handle(
        _meetingLocalIdMeta,
        meetingLocalId.isAcceptableOrUnknown(
          data['meeting_local_id']!,
          _meetingLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_meetingLocalIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  DailyTestScoreRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyTestScoreRecord(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      clientUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_uuid'],
      )!,
      meetingLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meeting_local_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DailyTestScoreRecordsTable createAlias(String alias) {
    return $DailyTestScoreRecordsTable(attachedDatabase, alias);
  }
}

class DailyTestScoreRecord extends DataClass
    implements Insertable<DailyTestScoreRecord> {
  final int localId;
  final int? remoteId;
  final String clientUuid;
  final int meetingLocalId;
  final int studentId;
  final double score;
  final String syncStatus;
  final DateTime updatedAt;
  const DailyTestScoreRecord({
    required this.localId,
    this.remoteId,
    required this.clientUuid,
    required this.meetingLocalId,
    required this.studentId,
    required this.score,
    required this.syncStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['client_uuid'] = Variable<String>(clientUuid);
    map['meeting_local_id'] = Variable<int>(meetingLocalId);
    map['student_id'] = Variable<int>(studentId);
    map['score'] = Variable<double>(score);
    map['sync_status'] = Variable<String>(syncStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyTestScoreRecordsCompanion toCompanion(bool nullToAbsent) {
    return DailyTestScoreRecordsCompanion(
      localId: Value(localId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      clientUuid: Value(clientUuid),
      meetingLocalId: Value(meetingLocalId),
      studentId: Value(studentId),
      score: Value(score),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyTestScoreRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyTestScoreRecord(
      localId: serializer.fromJson<int>(json['localId']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      clientUuid: serializer.fromJson<String>(json['clientUuid']),
      meetingLocalId: serializer.fromJson<int>(json['meetingLocalId']),
      studentId: serializer.fromJson<int>(json['studentId']),
      score: serializer.fromJson<double>(json['score']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'remoteId': serializer.toJson<int?>(remoteId),
      'clientUuid': serializer.toJson<String>(clientUuid),
      'meetingLocalId': serializer.toJson<int>(meetingLocalId),
      'studentId': serializer.toJson<int>(studentId),
      'score': serializer.toJson<double>(score),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyTestScoreRecord copyWith({
    int? localId,
    Value<int?> remoteId = const Value.absent(),
    String? clientUuid,
    int? meetingLocalId,
    int? studentId,
    double? score,
    String? syncStatus,
    DateTime? updatedAt,
  }) => DailyTestScoreRecord(
    localId: localId ?? this.localId,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    clientUuid: clientUuid ?? this.clientUuid,
    meetingLocalId: meetingLocalId ?? this.meetingLocalId,
    studentId: studentId ?? this.studentId,
    score: score ?? this.score,
    syncStatus: syncStatus ?? this.syncStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DailyTestScoreRecord copyWithCompanion(DailyTestScoreRecordsCompanion data) {
    return DailyTestScoreRecord(
      localId: data.localId.present ? data.localId.value : this.localId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      clientUuid: data.clientUuid.present
          ? data.clientUuid.value
          : this.clientUuid,
      meetingLocalId: data.meetingLocalId.present
          ? data.meetingLocalId.value
          : this.meetingLocalId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      score: data.score.present ? data.score.value : this.score,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyTestScoreRecord(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientUuid: $clientUuid, ')
          ..write('meetingLocalId: $meetingLocalId, ')
          ..write('studentId: $studentId, ')
          ..write('score: $score, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    remoteId,
    clientUuid,
    meetingLocalId,
    studentId,
    score,
    syncStatus,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyTestScoreRecord &&
          other.localId == this.localId &&
          other.remoteId == this.remoteId &&
          other.clientUuid == this.clientUuid &&
          other.meetingLocalId == this.meetingLocalId &&
          other.studentId == this.studentId &&
          other.score == this.score &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class DailyTestScoreRecordsCompanion
    extends UpdateCompanion<DailyTestScoreRecord> {
  final Value<int> localId;
  final Value<int?> remoteId;
  final Value<String> clientUuid;
  final Value<int> meetingLocalId;
  final Value<int> studentId;
  final Value<double> score;
  final Value<String> syncStatus;
  final Value<DateTime> updatedAt;
  const DailyTestScoreRecordsCompanion({
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.clientUuid = const Value.absent(),
    this.meetingLocalId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.score = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DailyTestScoreRecordsCompanion.insert({
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    required String clientUuid,
    required int meetingLocalId,
    required int studentId,
    required double score,
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : clientUuid = Value(clientUuid),
       meetingLocalId = Value(meetingLocalId),
       studentId = Value(studentId),
       score = Value(score);
  static Insertable<DailyTestScoreRecord> custom({
    Expression<int>? localId,
    Expression<int>? remoteId,
    Expression<String>? clientUuid,
    Expression<int>? meetingLocalId,
    Expression<int>? studentId,
    Expression<double>? score,
    Expression<String>? syncStatus,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (remoteId != null) 'remote_id': remoteId,
      if (clientUuid != null) 'client_uuid': clientUuid,
      if (meetingLocalId != null) 'meeting_local_id': meetingLocalId,
      if (studentId != null) 'student_id': studentId,
      if (score != null) 'score': score,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DailyTestScoreRecordsCompanion copyWith({
    Value<int>? localId,
    Value<int?>? remoteId,
    Value<String>? clientUuid,
    Value<int>? meetingLocalId,
    Value<int>? studentId,
    Value<double>? score,
    Value<String>? syncStatus,
    Value<DateTime>? updatedAt,
  }) {
    return DailyTestScoreRecordsCompanion(
      localId: localId ?? this.localId,
      remoteId: remoteId ?? this.remoteId,
      clientUuid: clientUuid ?? this.clientUuid,
      meetingLocalId: meetingLocalId ?? this.meetingLocalId,
      studentId: studentId ?? this.studentId,
      score: score ?? this.score,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (clientUuid.present) {
      map['client_uuid'] = Variable<String>(clientUuid.value);
    }
    if (meetingLocalId.present) {
      map['meeting_local_id'] = Variable<int>(meetingLocalId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyTestScoreRecordsCompanion(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientUuid: $clientUuid, ')
          ..write('meetingLocalId: $meetingLocalId, ')
          ..write('studentId: $studentId, ')
          ..write('score: $score, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AssignmentMeetingRecordsTable extends AssignmentMeetingRecords
    with TableInfo<$AssignmentMeetingRecordsTable, AssignmentMeetingRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssignmentMeetingRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientUuidMeta = const VerificationMeta(
    'clientUuid',
  );
  @override
  late final GeneratedColumn<String> clientUuid = GeneratedColumn<String>(
    'client_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<int> classId = GeneratedColumn<int>(
    'class_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _classNameMeta = const VerificationMeta(
    'className',
  );
  @override
  late final GeneratedColumn<String> className = GeneratedColumn<String>(
    'class_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assignmentDateMeta = const VerificationMeta(
    'assignmentDate',
  );
  @override
  late final GeneratedColumn<DateTime> assignmentDate =
      GeneratedColumn<DateTime>(
        'assignment_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    remoteId,
    clientUuid,
    classId,
    className,
    title,
    assignmentDate,
    description,
    syncStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assignment_meeting_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<AssignmentMeetingRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('client_uuid')) {
      context.handle(
        _clientUuidMeta,
        clientUuid.isAcceptableOrUnknown(data['client_uuid']!, _clientUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_clientUuidMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    }
    if (data.containsKey('class_name')) {
      context.handle(
        _classNameMeta,
        className.isAcceptableOrUnknown(data['class_name']!, _classNameMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('assignment_date')) {
      context.handle(
        _assignmentDateMeta,
        assignmentDate.isAcceptableOrUnknown(
          data['assignment_date']!,
          _assignmentDateMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  AssignmentMeetingRecord map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssignmentMeetingRecord(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      clientUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_uuid'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}class_id'],
      ),
      className: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_name'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      assignmentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}assignment_date'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AssignmentMeetingRecordsTable createAlias(String alias) {
    return $AssignmentMeetingRecordsTable(attachedDatabase, alias);
  }
}

class AssignmentMeetingRecord extends DataClass
    implements Insertable<AssignmentMeetingRecord> {
  final int localId;
  final int? remoteId;
  final String clientUuid;
  final int? classId;
  final String? className;
  final String title;
  final DateTime? assignmentDate;
  final String? description;
  final String syncStatus;
  final DateTime updatedAt;
  const AssignmentMeetingRecord({
    required this.localId,
    this.remoteId,
    required this.clientUuid,
    this.classId,
    this.className,
    required this.title,
    this.assignmentDate,
    this.description,
    required this.syncStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['client_uuid'] = Variable<String>(clientUuid);
    if (!nullToAbsent || classId != null) {
      map['class_id'] = Variable<int>(classId);
    }
    if (!nullToAbsent || className != null) {
      map['class_name'] = Variable<String>(className);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || assignmentDate != null) {
      map['assignment_date'] = Variable<DateTime>(assignmentDate);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AssignmentMeetingRecordsCompanion toCompanion(bool nullToAbsent) {
    return AssignmentMeetingRecordsCompanion(
      localId: Value(localId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      clientUuid: Value(clientUuid),
      classId: classId == null && nullToAbsent
          ? const Value.absent()
          : Value(classId),
      className: className == null && nullToAbsent
          ? const Value.absent()
          : Value(className),
      title: Value(title),
      assignmentDate: assignmentDate == null && nullToAbsent
          ? const Value.absent()
          : Value(assignmentDate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory AssignmentMeetingRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssignmentMeetingRecord(
      localId: serializer.fromJson<int>(json['localId']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      clientUuid: serializer.fromJson<String>(json['clientUuid']),
      classId: serializer.fromJson<int?>(json['classId']),
      className: serializer.fromJson<String?>(json['className']),
      title: serializer.fromJson<String>(json['title']),
      assignmentDate: serializer.fromJson<DateTime?>(json['assignmentDate']),
      description: serializer.fromJson<String?>(json['description']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'remoteId': serializer.toJson<int?>(remoteId),
      'clientUuid': serializer.toJson<String>(clientUuid),
      'classId': serializer.toJson<int?>(classId),
      'className': serializer.toJson<String?>(className),
      'title': serializer.toJson<String>(title),
      'assignmentDate': serializer.toJson<DateTime?>(assignmentDate),
      'description': serializer.toJson<String?>(description),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AssignmentMeetingRecord copyWith({
    int? localId,
    Value<int?> remoteId = const Value.absent(),
    String? clientUuid,
    Value<int?> classId = const Value.absent(),
    Value<String?> className = const Value.absent(),
    String? title,
    Value<DateTime?> assignmentDate = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? syncStatus,
    DateTime? updatedAt,
  }) => AssignmentMeetingRecord(
    localId: localId ?? this.localId,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    clientUuid: clientUuid ?? this.clientUuid,
    classId: classId.present ? classId.value : this.classId,
    className: className.present ? className.value : this.className,
    title: title ?? this.title,
    assignmentDate: assignmentDate.present
        ? assignmentDate.value
        : this.assignmentDate,
    description: description.present ? description.value : this.description,
    syncStatus: syncStatus ?? this.syncStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AssignmentMeetingRecord copyWithCompanion(
    AssignmentMeetingRecordsCompanion data,
  ) {
    return AssignmentMeetingRecord(
      localId: data.localId.present ? data.localId.value : this.localId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      clientUuid: data.clientUuid.present
          ? data.clientUuid.value
          : this.clientUuid,
      classId: data.classId.present ? data.classId.value : this.classId,
      className: data.className.present ? data.className.value : this.className,
      title: data.title.present ? data.title.value : this.title,
      assignmentDate: data.assignmentDate.present
          ? data.assignmentDate.value
          : this.assignmentDate,
      description: data.description.present
          ? data.description.value
          : this.description,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssignmentMeetingRecord(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientUuid: $clientUuid, ')
          ..write('classId: $classId, ')
          ..write('className: $className, ')
          ..write('title: $title, ')
          ..write('assignmentDate: $assignmentDate, ')
          ..write('description: $description, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    remoteId,
    clientUuid,
    classId,
    className,
    title,
    assignmentDate,
    description,
    syncStatus,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssignmentMeetingRecord &&
          other.localId == this.localId &&
          other.remoteId == this.remoteId &&
          other.clientUuid == this.clientUuid &&
          other.classId == this.classId &&
          other.className == this.className &&
          other.title == this.title &&
          other.assignmentDate == this.assignmentDate &&
          other.description == this.description &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class AssignmentMeetingRecordsCompanion
    extends UpdateCompanion<AssignmentMeetingRecord> {
  final Value<int> localId;
  final Value<int?> remoteId;
  final Value<String> clientUuid;
  final Value<int?> classId;
  final Value<String?> className;
  final Value<String> title;
  final Value<DateTime?> assignmentDate;
  final Value<String?> description;
  final Value<String> syncStatus;
  final Value<DateTime> updatedAt;
  const AssignmentMeetingRecordsCompanion({
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.clientUuid = const Value.absent(),
    this.classId = const Value.absent(),
    this.className = const Value.absent(),
    this.title = const Value.absent(),
    this.assignmentDate = const Value.absent(),
    this.description = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AssignmentMeetingRecordsCompanion.insert({
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    required String clientUuid,
    this.classId = const Value.absent(),
    this.className = const Value.absent(),
    required String title,
    this.assignmentDate = const Value.absent(),
    this.description = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : clientUuid = Value(clientUuid),
       title = Value(title);
  static Insertable<AssignmentMeetingRecord> custom({
    Expression<int>? localId,
    Expression<int>? remoteId,
    Expression<String>? clientUuid,
    Expression<int>? classId,
    Expression<String>? className,
    Expression<String>? title,
    Expression<DateTime>? assignmentDate,
    Expression<String>? description,
    Expression<String>? syncStatus,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (remoteId != null) 'remote_id': remoteId,
      if (clientUuid != null) 'client_uuid': clientUuid,
      if (classId != null) 'class_id': classId,
      if (className != null) 'class_name': className,
      if (title != null) 'title': title,
      if (assignmentDate != null) 'assignment_date': assignmentDate,
      if (description != null) 'description': description,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AssignmentMeetingRecordsCompanion copyWith({
    Value<int>? localId,
    Value<int?>? remoteId,
    Value<String>? clientUuid,
    Value<int?>? classId,
    Value<String?>? className,
    Value<String>? title,
    Value<DateTime?>? assignmentDate,
    Value<String?>? description,
    Value<String>? syncStatus,
    Value<DateTime>? updatedAt,
  }) {
    return AssignmentMeetingRecordsCompanion(
      localId: localId ?? this.localId,
      remoteId: remoteId ?? this.remoteId,
      clientUuid: clientUuid ?? this.clientUuid,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      title: title ?? this.title,
      assignmentDate: assignmentDate ?? this.assignmentDate,
      description: description ?? this.description,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (clientUuid.present) {
      map['client_uuid'] = Variable<String>(clientUuid.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<int>(classId.value);
    }
    if (className.present) {
      map['class_name'] = Variable<String>(className.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (assignmentDate.present) {
      map['assignment_date'] = Variable<DateTime>(assignmentDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssignmentMeetingRecordsCompanion(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientUuid: $clientUuid, ')
          ..write('classId: $classId, ')
          ..write('className: $className, ')
          ..write('title: $title, ')
          ..write('assignmentDate: $assignmentDate, ')
          ..write('description: $description, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AssignmentScoreRecordsTable extends AssignmentScoreRecords
    with TableInfo<$AssignmentScoreRecordsTable, AssignmentScoreRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssignmentScoreRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientUuidMeta = const VerificationMeta(
    'clientUuid',
  );
  @override
  late final GeneratedColumn<String> clientUuid = GeneratedColumn<String>(
    'client_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meetingLocalIdMeta = const VerificationMeta(
    'meetingLocalId',
  );
  @override
  late final GeneratedColumn<int> meetingLocalId = GeneratedColumn<int>(
    'meeting_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending_create'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    remoteId,
    clientUuid,
    meetingLocalId,
    studentId,
    score,
    syncStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assignment_score_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<AssignmentScoreRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('client_uuid')) {
      context.handle(
        _clientUuidMeta,
        clientUuid.isAcceptableOrUnknown(data['client_uuid']!, _clientUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_clientUuidMeta);
    }
    if (data.containsKey('meeting_local_id')) {
      context.handle(
        _meetingLocalIdMeta,
        meetingLocalId.isAcceptableOrUnknown(
          data['meeting_local_id']!,
          _meetingLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_meetingLocalIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  AssignmentScoreRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssignmentScoreRecord(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      clientUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_uuid'],
      )!,
      meetingLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meeting_local_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AssignmentScoreRecordsTable createAlias(String alias) {
    return $AssignmentScoreRecordsTable(attachedDatabase, alias);
  }
}

class AssignmentScoreRecord extends DataClass
    implements Insertable<AssignmentScoreRecord> {
  final int localId;
  final int? remoteId;
  final String clientUuid;
  final int meetingLocalId;
  final int studentId;
  final double score;
  final String syncStatus;
  final DateTime updatedAt;
  const AssignmentScoreRecord({
    required this.localId,
    this.remoteId,
    required this.clientUuid,
    required this.meetingLocalId,
    required this.studentId,
    required this.score,
    required this.syncStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['client_uuid'] = Variable<String>(clientUuid);
    map['meeting_local_id'] = Variable<int>(meetingLocalId);
    map['student_id'] = Variable<int>(studentId);
    map['score'] = Variable<double>(score);
    map['sync_status'] = Variable<String>(syncStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AssignmentScoreRecordsCompanion toCompanion(bool nullToAbsent) {
    return AssignmentScoreRecordsCompanion(
      localId: Value(localId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      clientUuid: Value(clientUuid),
      meetingLocalId: Value(meetingLocalId),
      studentId: Value(studentId),
      score: Value(score),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory AssignmentScoreRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssignmentScoreRecord(
      localId: serializer.fromJson<int>(json['localId']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      clientUuid: serializer.fromJson<String>(json['clientUuid']),
      meetingLocalId: serializer.fromJson<int>(json['meetingLocalId']),
      studentId: serializer.fromJson<int>(json['studentId']),
      score: serializer.fromJson<double>(json['score']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'remoteId': serializer.toJson<int?>(remoteId),
      'clientUuid': serializer.toJson<String>(clientUuid),
      'meetingLocalId': serializer.toJson<int>(meetingLocalId),
      'studentId': serializer.toJson<int>(studentId),
      'score': serializer.toJson<double>(score),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AssignmentScoreRecord copyWith({
    int? localId,
    Value<int?> remoteId = const Value.absent(),
    String? clientUuid,
    int? meetingLocalId,
    int? studentId,
    double? score,
    String? syncStatus,
    DateTime? updatedAt,
  }) => AssignmentScoreRecord(
    localId: localId ?? this.localId,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    clientUuid: clientUuid ?? this.clientUuid,
    meetingLocalId: meetingLocalId ?? this.meetingLocalId,
    studentId: studentId ?? this.studentId,
    score: score ?? this.score,
    syncStatus: syncStatus ?? this.syncStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AssignmentScoreRecord copyWithCompanion(
    AssignmentScoreRecordsCompanion data,
  ) {
    return AssignmentScoreRecord(
      localId: data.localId.present ? data.localId.value : this.localId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      clientUuid: data.clientUuid.present
          ? data.clientUuid.value
          : this.clientUuid,
      meetingLocalId: data.meetingLocalId.present
          ? data.meetingLocalId.value
          : this.meetingLocalId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      score: data.score.present ? data.score.value : this.score,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssignmentScoreRecord(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientUuid: $clientUuid, ')
          ..write('meetingLocalId: $meetingLocalId, ')
          ..write('studentId: $studentId, ')
          ..write('score: $score, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    remoteId,
    clientUuid,
    meetingLocalId,
    studentId,
    score,
    syncStatus,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssignmentScoreRecord &&
          other.localId == this.localId &&
          other.remoteId == this.remoteId &&
          other.clientUuid == this.clientUuid &&
          other.meetingLocalId == this.meetingLocalId &&
          other.studentId == this.studentId &&
          other.score == this.score &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class AssignmentScoreRecordsCompanion
    extends UpdateCompanion<AssignmentScoreRecord> {
  final Value<int> localId;
  final Value<int?> remoteId;
  final Value<String> clientUuid;
  final Value<int> meetingLocalId;
  final Value<int> studentId;
  final Value<double> score;
  final Value<String> syncStatus;
  final Value<DateTime> updatedAt;
  const AssignmentScoreRecordsCompanion({
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.clientUuid = const Value.absent(),
    this.meetingLocalId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.score = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AssignmentScoreRecordsCompanion.insert({
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    required String clientUuid,
    required int meetingLocalId,
    required int studentId,
    required double score,
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : clientUuid = Value(clientUuid),
       meetingLocalId = Value(meetingLocalId),
       studentId = Value(studentId),
       score = Value(score);
  static Insertable<AssignmentScoreRecord> custom({
    Expression<int>? localId,
    Expression<int>? remoteId,
    Expression<String>? clientUuid,
    Expression<int>? meetingLocalId,
    Expression<int>? studentId,
    Expression<double>? score,
    Expression<String>? syncStatus,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (remoteId != null) 'remote_id': remoteId,
      if (clientUuid != null) 'client_uuid': clientUuid,
      if (meetingLocalId != null) 'meeting_local_id': meetingLocalId,
      if (studentId != null) 'student_id': studentId,
      if (score != null) 'score': score,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AssignmentScoreRecordsCompanion copyWith({
    Value<int>? localId,
    Value<int?>? remoteId,
    Value<String>? clientUuid,
    Value<int>? meetingLocalId,
    Value<int>? studentId,
    Value<double>? score,
    Value<String>? syncStatus,
    Value<DateTime>? updatedAt,
  }) {
    return AssignmentScoreRecordsCompanion(
      localId: localId ?? this.localId,
      remoteId: remoteId ?? this.remoteId,
      clientUuid: clientUuid ?? this.clientUuid,
      meetingLocalId: meetingLocalId ?? this.meetingLocalId,
      studentId: studentId ?? this.studentId,
      score: score ?? this.score,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (clientUuid.present) {
      map['client_uuid'] = Variable<String>(clientUuid.value);
    }
    if (meetingLocalId.present) {
      map['meeting_local_id'] = Variable<int>(meetingLocalId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssignmentScoreRecordsCompanion(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientUuid: $clientUuid, ')
          ..write('meetingLocalId: $meetingLocalId, ')
          ..write('studentId: $studentId, ')
          ..write('score: $score, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PendingOperationsTable extends PendingOperations
    with TableInfo<$PendingOperationsTable, PendingOperation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingOperationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
    'entity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entity,
    localId,
    operation,
    payload,
    createdAt,
    attempts,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_operations';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingOperation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity')) {
      context.handle(
        _entityMeta,
        entity.isAcceptableOrUnknown(data['entity']!, _entityMeta),
      );
    } else if (isInserting) {
      context.missing(_entityMeta);
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingOperation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingOperation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity'],
      )!,
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $PendingOperationsTable createAlias(String alias) {
    return $PendingOperationsTable(attachedDatabase, alias);
  }
}

class PendingOperation extends DataClass
    implements Insertable<PendingOperation> {
  final int id;
  final String entity;
  final int localId;
  final String operation;
  final String payload;
  final DateTime createdAt;
  final int attempts;
  final String? lastError;
  const PendingOperation({
    required this.id,
    required this.entity,
    required this.localId,
    required this.operation,
    required this.payload,
    required this.createdAt,
    required this.attempts,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity'] = Variable<String>(entity);
    map['local_id'] = Variable<int>(localId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  PendingOperationsCompanion toCompanion(bool nullToAbsent) {
    return PendingOperationsCompanion(
      id: Value(id),
      entity: Value(entity),
      localId: Value(localId),
      operation: Value(operation),
      payload: Value(payload),
      createdAt: Value(createdAt),
      attempts: Value(attempts),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory PendingOperation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingOperation(
      id: serializer.fromJson<int>(json['id']),
      entity: serializer.fromJson<String>(json['entity']),
      localId: serializer.fromJson<int>(json['localId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      attempts: serializer.fromJson<int>(json['attempts']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entity': serializer.toJson<String>(entity),
      'localId': serializer.toJson<int>(localId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'attempts': serializer.toJson<int>(attempts),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  PendingOperation copyWith({
    int? id,
    String? entity,
    int? localId,
    String? operation,
    String? payload,
    DateTime? createdAt,
    int? attempts,
    Value<String?> lastError = const Value.absent(),
  }) => PendingOperation(
    id: id ?? this.id,
    entity: entity ?? this.entity,
    localId: localId ?? this.localId,
    operation: operation ?? this.operation,
    payload: payload ?? this.payload,
    createdAt: createdAt ?? this.createdAt,
    attempts: attempts ?? this.attempts,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  PendingOperation copyWithCompanion(PendingOperationsCompanion data) {
    return PendingOperation(
      id: data.id.present ? data.id.value : this.id,
      entity: data.entity.present ? data.entity.value : this.entity,
      localId: data.localId.present ? data.localId.value : this.localId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingOperation(')
          ..write('id: $id, ')
          ..write('entity: $entity, ')
          ..write('localId: $localId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entity,
    localId,
    operation,
    payload,
    createdAt,
    attempts,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingOperation &&
          other.id == this.id &&
          other.entity == this.entity &&
          other.localId == this.localId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt &&
          other.attempts == this.attempts &&
          other.lastError == this.lastError);
}

class PendingOperationsCompanion extends UpdateCompanion<PendingOperation> {
  final Value<int> id;
  final Value<String> entity;
  final Value<int> localId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  final Value<int> attempts;
  final Value<String?> lastError;
  const PendingOperationsCompanion({
    this.id = const Value.absent(),
    this.entity = const Value.absent(),
    this.localId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
  });
  PendingOperationsCompanion.insert({
    this.id = const Value.absent(),
    required String entity,
    required int localId,
    required String operation,
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
  }) : entity = Value(entity),
       localId = Value(localId),
       operation = Value(operation);
  static Insertable<PendingOperation> custom({
    Expression<int>? id,
    Expression<String>? entity,
    Expression<int>? localId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
    Expression<int>? attempts,
    Expression<String>? lastError,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entity != null) 'entity': entity,
      if (localId != null) 'local_id': localId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
      if (attempts != null) 'attempts': attempts,
      if (lastError != null) 'last_error': lastError,
    });
  }

  PendingOperationsCompanion copyWith({
    Value<int>? id,
    Value<String>? entity,
    Value<int>? localId,
    Value<String>? operation,
    Value<String>? payload,
    Value<DateTime>? createdAt,
    Value<int>? attempts,
    Value<String?>? lastError,
  }) {
    return PendingOperationsCompanion(
      id: id ?? this.id,
      entity: entity ?? this.entity,
      localId: localId ?? this.localId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      attempts: attempts ?? this.attempts,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingOperationsCompanion(')
          ..write('id: $id, ')
          ..write('entity: $entity, ')
          ..write('localId: $localId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }
}

class $CachedDashboardTable extends CachedDashboard
    with TableInfo<$CachedDashboardTable, CachedDashboardData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedDashboardTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, payload, fetchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_dashboard';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedDashboardData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedDashboardData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedDashboardData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $CachedDashboardTable createAlias(String alias) {
    return $CachedDashboardTable(attachedDatabase, alias);
  }
}

class CachedDashboardData extends DataClass
    implements Insertable<CachedDashboardData> {
  final int id;
  final String payload;
  final DateTime fetchedAt;
  const CachedDashboardData({
    required this.id,
    required this.payload,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['payload'] = Variable<String>(payload);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  CachedDashboardCompanion toCompanion(bool nullToAbsent) {
    return CachedDashboardCompanion(
      id: Value(id),
      payload: Value(payload),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory CachedDashboardData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedDashboardData(
      id: serializer.fromJson<int>(json['id']),
      payload: serializer.fromJson<String>(json['payload']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'payload': serializer.toJson<String>(payload),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  CachedDashboardData copyWith({
    int? id,
    String? payload,
    DateTime? fetchedAt,
  }) => CachedDashboardData(
    id: id ?? this.id,
    payload: payload ?? this.payload,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  CachedDashboardData copyWithCompanion(CachedDashboardCompanion data) {
    return CachedDashboardData(
      id: data.id.present ? data.id.value : this.id,
      payload: data.payload.present ? data.payload.value : this.payload,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedDashboardData(')
          ..write('id: $id, ')
          ..write('payload: $payload, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, payload, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedDashboardData &&
          other.id == this.id &&
          other.payload == this.payload &&
          other.fetchedAt == this.fetchedAt);
}

class CachedDashboardCompanion extends UpdateCompanion<CachedDashboardData> {
  final Value<int> id;
  final Value<String> payload;
  final Value<DateTime> fetchedAt;
  const CachedDashboardCompanion({
    this.id = const Value.absent(),
    this.payload = const Value.absent(),
    this.fetchedAt = const Value.absent(),
  });
  CachedDashboardCompanion.insert({
    this.id = const Value.absent(),
    required String payload,
    required DateTime fetchedAt,
  }) : payload = Value(payload),
       fetchedAt = Value(fetchedAt);
  static Insertable<CachedDashboardData> custom({
    Expression<int>? id,
    Expression<String>? payload,
    Expression<DateTime>? fetchedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (payload != null) 'payload': payload,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
    });
  }

  CachedDashboardCompanion copyWith({
    Value<int>? id,
    Value<String>? payload,
    Value<DateTime>? fetchedAt,
  }) {
    return CachedDashboardCompanion(
      id: id ?? this.id,
      payload: payload ?? this.payload,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedDashboardCompanion(')
          ..write('id: $id, ')
          ..write('payload: $payload, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }
}

class $AppMetaTable extends AppMeta with TableInfo<$AppMetaTable, AppMetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppMetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetaData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppMetaTable createAlias(String alias) {
    return $AppMetaTable(attachedDatabase, alias);
  }
}

class AppMetaData extends DataClass implements Insertable<AppMetaData> {
  final String key;
  final String value;
  const AppMetaData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppMetaCompanion toCompanion(bool nullToAbsent) {
    return AppMetaCompanion(key: Value(key), value: Value(value));
  }

  factory AppMetaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetaData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppMetaData copyWith({String? key, String? value}) =>
      AppMetaData(key: key ?? this.key, value: value ?? this.value);
  AppMetaData copyWithCompanion(AppMetaCompanion data) {
    return AppMetaData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetaData &&
          other.key == this.key &&
          other.value == this.value);
}

class AppMetaCompanion extends UpdateCompanion<AppMetaData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppMetaData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedClassesTable cachedClasses = $CachedClassesTable(this);
  late final $CachedStudentsTable cachedStudents = $CachedStudentsTable(this);
  late final $MeetingRecordsTable meetingRecords = $MeetingRecordsTable(this);
  late final $AttendanceRecordsTable attendanceRecords =
      $AttendanceRecordsTable(this);
  late final $DailyTestMeetingRecordsTable dailyTestMeetingRecords =
      $DailyTestMeetingRecordsTable(this);
  late final $DailyTestScoreRecordsTable dailyTestScoreRecords =
      $DailyTestScoreRecordsTable(this);
  late final $AssignmentMeetingRecordsTable assignmentMeetingRecords =
      $AssignmentMeetingRecordsTable(this);
  late final $AssignmentScoreRecordsTable assignmentScoreRecords =
      $AssignmentScoreRecordsTable(this);
  late final $PendingOperationsTable pendingOperations =
      $PendingOperationsTable(this);
  late final $CachedDashboardTable cachedDashboard = $CachedDashboardTable(
    this,
  );
  late final $AppMetaTable appMeta = $AppMetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedClasses,
    cachedStudents,
    meetingRecords,
    attendanceRecords,
    dailyTestMeetingRecords,
    dailyTestScoreRecords,
    assignmentMeetingRecords,
    assignmentScoreRecords,
    pendingOperations,
    cachedDashboard,
    appMeta,
  ];
}

typedef $$CachedClassesTableCreateCompanionBuilder =
    CachedClassesCompanion Function({Value<int> id, required String name});
typedef $$CachedClassesTableUpdateCompanionBuilder =
    CachedClassesCompanion Function({Value<int> id, Value<String> name});

class $$CachedClassesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedClassesTable> {
  $$CachedClassesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedClassesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedClassesTable> {
  $$CachedClassesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedClassesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedClassesTable> {
  $$CachedClassesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$CachedClassesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedClassesTable,
          CachedClass,
          $$CachedClassesTableFilterComposer,
          $$CachedClassesTableOrderingComposer,
          $$CachedClassesTableAnnotationComposer,
          $$CachedClassesTableCreateCompanionBuilder,
          $$CachedClassesTableUpdateCompanionBuilder,
          (
            CachedClass,
            BaseReferences<_$AppDatabase, $CachedClassesTable, CachedClass>,
          ),
          CachedClass,
          PrefetchHooks Function()
        > {
  $$CachedClassesTableTableManager(_$AppDatabase db, $CachedClassesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedClassesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedClassesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedClassesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) => CachedClassesCompanion(id: id, name: name),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) => CachedClassesCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedClassesTable, CachedClass>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CachedClassesTable,
                    CachedClass
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedClassesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedClassesTable,
      CachedClass,
      $$CachedClassesTableFilterComposer,
      $$CachedClassesTableOrderingComposer,
      $$CachedClassesTableAnnotationComposer,
      $$CachedClassesTableCreateCompanionBuilder,
      $$CachedClassesTableUpdateCompanionBuilder,
      (
        CachedClass,
        BaseReferences<_$AppDatabase, $CachedClassesTable, CachedClass>,
      ),
      CachedClass,
      PrefetchHooks Function()
    >;
typedef $$CachedStudentsTableCreateCompanionBuilder =
    CachedStudentsCompanion Function({
      Value<int> id,
      Value<int?> classId,
      required String name,
      Value<String?> nis,
      Value<String?> gender,
    });
typedef $$CachedStudentsTableUpdateCompanionBuilder =
    CachedStudentsCompanion Function({
      Value<int> id,
      Value<int?> classId,
      Value<String> name,
      Value<String?> nis,
      Value<String?> gender,
    });

class $$CachedStudentsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedStudentsTable> {
  $$CachedStudentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nis => $composableBuilder(
    column: $table.nis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedStudentsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedStudentsTable> {
  $$CachedStudentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nis => $composableBuilder(
    column: $table.nis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedStudentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedStudentsTable> {
  $$CachedStudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nis =>
      $composableBuilder(column: $table.nis, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);
}

class $$CachedStudentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedStudentsTable,
          CachedStudent,
          $$CachedStudentsTableFilterComposer,
          $$CachedStudentsTableOrderingComposer,
          $$CachedStudentsTableAnnotationComposer,
          $$CachedStudentsTableCreateCompanionBuilder,
          $$CachedStudentsTableUpdateCompanionBuilder,
          (
            CachedStudent,
            BaseReferences<_$AppDatabase, $CachedStudentsTable, CachedStudent>,
          ),
          CachedStudent,
          PrefetchHooks Function()
        > {
  $$CachedStudentsTableTableManager(
    _$AppDatabase db,
    $CachedStudentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedStudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedStudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedStudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> classId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> nis = const Value.absent(),
                Value<String?> gender = const Value.absent(),
              }) => CachedStudentsCompanion(
                id: id,
                classId: classId,
                name: name,
                nis: nis,
                gender: gender,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> classId = const Value.absent(),
                required String name,
                Value<String?> nis = const Value.absent(),
                Value<String?> gender = const Value.absent(),
              }) => CachedStudentsCompanion.insert(
                id: id,
                classId: classId,
                name: name,
                nis: nis,
                gender: gender,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedStudentsTable, CachedStudent>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CachedStudentsTable,
                    CachedStudent
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedStudentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedStudentsTable,
      CachedStudent,
      $$CachedStudentsTableFilterComposer,
      $$CachedStudentsTableOrderingComposer,
      $$CachedStudentsTableAnnotationComposer,
      $$CachedStudentsTableCreateCompanionBuilder,
      $$CachedStudentsTableUpdateCompanionBuilder,
      (
        CachedStudent,
        BaseReferences<_$AppDatabase, $CachedStudentsTable, CachedStudent>,
      ),
      CachedStudent,
      PrefetchHooks Function()
    >;
typedef $$MeetingRecordsTableCreateCompanionBuilder =
    MeetingRecordsCompanion Function({
      Value<int> localId,
      Value<int?> remoteId,
      required String clientUuid,
      Value<int?> classId,
      Value<String?> className,
      required String title,
      Value<String> tipe,
      Value<DateTime?> meetingDate,
      Value<String?> description,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
    });
typedef $$MeetingRecordsTableUpdateCompanionBuilder =
    MeetingRecordsCompanion Function({
      Value<int> localId,
      Value<int?> remoteId,
      Value<String> clientUuid,
      Value<int?> classId,
      Value<String?> className,
      Value<String> title,
      Value<String> tipe,
      Value<DateTime?> meetingDate,
      Value<String?> description,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
    });

class $$MeetingRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $MeetingRecordsTable> {
  $$MeetingRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipe => $composableBuilder(
    column: $table.tipe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get meetingDate => $composableBuilder(
    column: $table.meetingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MeetingRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $MeetingRecordsTable> {
  $$MeetingRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipe => $composableBuilder(
    column: $table.tipe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get meetingDate => $composableBuilder(
    column: $table.meetingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MeetingRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeetingRecordsTable> {
  $$MeetingRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => column,
  );

  GeneratedColumn<int> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get className =>
      $composableBuilder(column: $table.className, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get tipe =>
      $composableBuilder(column: $table.tipe, builder: (column) => column);

  GeneratedColumn<DateTime> get meetingDate => $composableBuilder(
    column: $table.meetingDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MeetingRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeetingRecordsTable,
          MeetingRecord,
          $$MeetingRecordsTableFilterComposer,
          $$MeetingRecordsTableOrderingComposer,
          $$MeetingRecordsTableAnnotationComposer,
          $$MeetingRecordsTableCreateCompanionBuilder,
          $$MeetingRecordsTableUpdateCompanionBuilder,
          (
            MeetingRecord,
            BaseReferences<_$AppDatabase, $MeetingRecordsTable, MeetingRecord>,
          ),
          MeetingRecord,
          PrefetchHooks Function()
        > {
  $$MeetingRecordsTableTableManager(
    _$AppDatabase db,
    $MeetingRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeetingRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeetingRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeetingRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<String> clientUuid = const Value.absent(),
                Value<int?> classId = const Value.absent(),
                Value<String?> className = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> tipe = const Value.absent(),
                Value<DateTime?> meetingDate = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MeetingRecordsCompanion(
                localId: localId,
                remoteId: remoteId,
                clientUuid: clientUuid,
                classId: classId,
                className: className,
                title: title,
                tipe: tipe,
                meetingDate: meetingDate,
                description: description,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                required String clientUuid,
                Value<int?> classId = const Value.absent(),
                Value<String?> className = const Value.absent(),
                required String title,
                Value<String> tipe = const Value.absent(),
                Value<DateTime?> meetingDate = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MeetingRecordsCompanion.insert(
                localId: localId,
                remoteId: remoteId,
                clientUuid: clientUuid,
                classId: classId,
                className: className,
                title: title,
                tipe: tipe,
                meetingDate: meetingDate,
                description: description,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MeetingRecordsTable, MeetingRecord>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $MeetingRecordsTable,
                    MeetingRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MeetingRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeetingRecordsTable,
      MeetingRecord,
      $$MeetingRecordsTableFilterComposer,
      $$MeetingRecordsTableOrderingComposer,
      $$MeetingRecordsTableAnnotationComposer,
      $$MeetingRecordsTableCreateCompanionBuilder,
      $$MeetingRecordsTableUpdateCompanionBuilder,
      (
        MeetingRecord,
        BaseReferences<_$AppDatabase, $MeetingRecordsTable, MeetingRecord>,
      ),
      MeetingRecord,
      PrefetchHooks Function()
    >;
typedef $$AttendanceRecordsTableCreateCompanionBuilder =
    AttendanceRecordsCompanion Function({
      Value<int> localId,
      Value<int?> remoteId,
      required String clientUuid,
      required int meetingLocalId,
      required int studentId,
      Value<String> status,
      Value<String?> note,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
    });
typedef $$AttendanceRecordsTableUpdateCompanionBuilder =
    AttendanceRecordsCompanion Function({
      Value<int> localId,
      Value<int?> remoteId,
      Value<String> clientUuid,
      Value<int> meetingLocalId,
      Value<int> studentId,
      Value<String> status,
      Value<String?> note,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
    });

class $$AttendanceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get meetingLocalId => $composableBuilder(
    column: $table.meetingLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttendanceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get meetingLocalId => $composableBuilder(
    column: $table.meetingLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttendanceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => column,
  );

  GeneratedColumn<int> get meetingLocalId => $composableBuilder(
    column: $table.meetingLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AttendanceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceRecordsTable,
          AttendanceRecord,
          $$AttendanceRecordsTableFilterComposer,
          $$AttendanceRecordsTableOrderingComposer,
          $$AttendanceRecordsTableAnnotationComposer,
          $$AttendanceRecordsTableCreateCompanionBuilder,
          $$AttendanceRecordsTableUpdateCompanionBuilder,
          (
            AttendanceRecord,
            BaseReferences<
              _$AppDatabase,
              $AttendanceRecordsTable,
              AttendanceRecord
            >,
          ),
          AttendanceRecord,
          PrefetchHooks Function()
        > {
  $$AttendanceRecordsTableTableManager(
    _$AppDatabase db,
    $AttendanceRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<String> clientUuid = const Value.absent(),
                Value<int> meetingLocalId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AttendanceRecordsCompanion(
                localId: localId,
                remoteId: remoteId,
                clientUuid: clientUuid,
                meetingLocalId: meetingLocalId,
                studentId: studentId,
                status: status,
                note: note,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                required String clientUuid,
                required int meetingLocalId,
                required int studentId,
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AttendanceRecordsCompanion.insert(
                localId: localId,
                remoteId: remoteId,
                clientUuid: clientUuid,
                meetingLocalId: meetingLocalId,
                studentId: studentId,
                status: status,
                note: note,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AttendanceRecordsTable, AttendanceRecord>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AttendanceRecordsTable,
                    AttendanceRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttendanceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceRecordsTable,
      AttendanceRecord,
      $$AttendanceRecordsTableFilterComposer,
      $$AttendanceRecordsTableOrderingComposer,
      $$AttendanceRecordsTableAnnotationComposer,
      $$AttendanceRecordsTableCreateCompanionBuilder,
      $$AttendanceRecordsTableUpdateCompanionBuilder,
      (
        AttendanceRecord,
        BaseReferences<
          _$AppDatabase,
          $AttendanceRecordsTable,
          AttendanceRecord
        >,
      ),
      AttendanceRecord,
      PrefetchHooks Function()
    >;
typedef $$DailyTestMeetingRecordsTableCreateCompanionBuilder =
    DailyTestMeetingRecordsCompanion Function({
      Value<int> localId,
      Value<int?> remoteId,
      required String clientUuid,
      Value<int?> classId,
      Value<String?> className,
      required String title,
      Value<DateTime?> testDate,
      Value<String?> description,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
    });
typedef $$DailyTestMeetingRecordsTableUpdateCompanionBuilder =
    DailyTestMeetingRecordsCompanion Function({
      Value<int> localId,
      Value<int?> remoteId,
      Value<String> clientUuid,
      Value<int?> classId,
      Value<String?> className,
      Value<String> title,
      Value<DateTime?> testDate,
      Value<String?> description,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
    });

class $$DailyTestMeetingRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyTestMeetingRecordsTable> {
  $$DailyTestMeetingRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get testDate => $composableBuilder(
    column: $table.testDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyTestMeetingRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyTestMeetingRecordsTable> {
  $$DailyTestMeetingRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get testDate => $composableBuilder(
    column: $table.testDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyTestMeetingRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyTestMeetingRecordsTable> {
  $$DailyTestMeetingRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => column,
  );

  GeneratedColumn<int> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get className =>
      $composableBuilder(column: $table.className, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get testDate =>
      $composableBuilder(column: $table.testDate, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyTestMeetingRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyTestMeetingRecordsTable,
          DailyTestMeetingRecord,
          $$DailyTestMeetingRecordsTableFilterComposer,
          $$DailyTestMeetingRecordsTableOrderingComposer,
          $$DailyTestMeetingRecordsTableAnnotationComposer,
          $$DailyTestMeetingRecordsTableCreateCompanionBuilder,
          $$DailyTestMeetingRecordsTableUpdateCompanionBuilder,
          (
            DailyTestMeetingRecord,
            BaseReferences<
              _$AppDatabase,
              $DailyTestMeetingRecordsTable,
              DailyTestMeetingRecord
            >,
          ),
          DailyTestMeetingRecord,
          PrefetchHooks Function()
        > {
  $$DailyTestMeetingRecordsTableTableManager(
    _$AppDatabase db,
    $DailyTestMeetingRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyTestMeetingRecordsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DailyTestMeetingRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DailyTestMeetingRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<String> clientUuid = const Value.absent(),
                Value<int?> classId = const Value.absent(),
                Value<String?> className = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime?> testDate = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DailyTestMeetingRecordsCompanion(
                localId: localId,
                remoteId: remoteId,
                clientUuid: clientUuid,
                classId: classId,
                className: className,
                title: title,
                testDate: testDate,
                description: description,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                required String clientUuid,
                Value<int?> classId = const Value.absent(),
                Value<String?> className = const Value.absent(),
                required String title,
                Value<DateTime?> testDate = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DailyTestMeetingRecordsCompanion.insert(
                localId: localId,
                remoteId: remoteId,
                clientUuid: clientUuid,
                classId: classId,
                className: className,
                title: title,
                testDate: testDate,
                description: description,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $DailyTestMeetingRecordsTable,
                    DailyTestMeetingRecord
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DailyTestMeetingRecordsTable,
                    DailyTestMeetingRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyTestMeetingRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyTestMeetingRecordsTable,
      DailyTestMeetingRecord,
      $$DailyTestMeetingRecordsTableFilterComposer,
      $$DailyTestMeetingRecordsTableOrderingComposer,
      $$DailyTestMeetingRecordsTableAnnotationComposer,
      $$DailyTestMeetingRecordsTableCreateCompanionBuilder,
      $$DailyTestMeetingRecordsTableUpdateCompanionBuilder,
      (
        DailyTestMeetingRecord,
        BaseReferences<
          _$AppDatabase,
          $DailyTestMeetingRecordsTable,
          DailyTestMeetingRecord
        >,
      ),
      DailyTestMeetingRecord,
      PrefetchHooks Function()
    >;
typedef $$DailyTestScoreRecordsTableCreateCompanionBuilder =
    DailyTestScoreRecordsCompanion Function({
      Value<int> localId,
      Value<int?> remoteId,
      required String clientUuid,
      required int meetingLocalId,
      required int studentId,
      required double score,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
    });
typedef $$DailyTestScoreRecordsTableUpdateCompanionBuilder =
    DailyTestScoreRecordsCompanion Function({
      Value<int> localId,
      Value<int?> remoteId,
      Value<String> clientUuid,
      Value<int> meetingLocalId,
      Value<int> studentId,
      Value<double> score,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
    });

class $$DailyTestScoreRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyTestScoreRecordsTable> {
  $$DailyTestScoreRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get meetingLocalId => $composableBuilder(
    column: $table.meetingLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyTestScoreRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyTestScoreRecordsTable> {
  $$DailyTestScoreRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get meetingLocalId => $composableBuilder(
    column: $table.meetingLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyTestScoreRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyTestScoreRecordsTable> {
  $$DailyTestScoreRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => column,
  );

  GeneratedColumn<int> get meetingLocalId => $composableBuilder(
    column: $table.meetingLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyTestScoreRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyTestScoreRecordsTable,
          DailyTestScoreRecord,
          $$DailyTestScoreRecordsTableFilterComposer,
          $$DailyTestScoreRecordsTableOrderingComposer,
          $$DailyTestScoreRecordsTableAnnotationComposer,
          $$DailyTestScoreRecordsTableCreateCompanionBuilder,
          $$DailyTestScoreRecordsTableUpdateCompanionBuilder,
          (
            DailyTestScoreRecord,
            BaseReferences<
              _$AppDatabase,
              $DailyTestScoreRecordsTable,
              DailyTestScoreRecord
            >,
          ),
          DailyTestScoreRecord,
          PrefetchHooks Function()
        > {
  $$DailyTestScoreRecordsTableTableManager(
    _$AppDatabase db,
    $DailyTestScoreRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyTestScoreRecordsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DailyTestScoreRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DailyTestScoreRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<String> clientUuid = const Value.absent(),
                Value<int> meetingLocalId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<double> score = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DailyTestScoreRecordsCompanion(
                localId: localId,
                remoteId: remoteId,
                clientUuid: clientUuid,
                meetingLocalId: meetingLocalId,
                studentId: studentId,
                score: score,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                required String clientUuid,
                required int meetingLocalId,
                required int studentId,
                required double score,
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DailyTestScoreRecordsCompanion.insert(
                localId: localId,
                remoteId: remoteId,
                clientUuid: clientUuid,
                meetingLocalId: meetingLocalId,
                studentId: studentId,
                score: score,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $DailyTestScoreRecordsTable,
                    DailyTestScoreRecord
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DailyTestScoreRecordsTable,
                    DailyTestScoreRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyTestScoreRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyTestScoreRecordsTable,
      DailyTestScoreRecord,
      $$DailyTestScoreRecordsTableFilterComposer,
      $$DailyTestScoreRecordsTableOrderingComposer,
      $$DailyTestScoreRecordsTableAnnotationComposer,
      $$DailyTestScoreRecordsTableCreateCompanionBuilder,
      $$DailyTestScoreRecordsTableUpdateCompanionBuilder,
      (
        DailyTestScoreRecord,
        BaseReferences<
          _$AppDatabase,
          $DailyTestScoreRecordsTable,
          DailyTestScoreRecord
        >,
      ),
      DailyTestScoreRecord,
      PrefetchHooks Function()
    >;
typedef $$AssignmentMeetingRecordsTableCreateCompanionBuilder =
    AssignmentMeetingRecordsCompanion Function({
      Value<int> localId,
      Value<int?> remoteId,
      required String clientUuid,
      Value<int?> classId,
      Value<String?> className,
      required String title,
      Value<DateTime?> assignmentDate,
      Value<String?> description,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
    });
typedef $$AssignmentMeetingRecordsTableUpdateCompanionBuilder =
    AssignmentMeetingRecordsCompanion Function({
      Value<int> localId,
      Value<int?> remoteId,
      Value<String> clientUuid,
      Value<int?> classId,
      Value<String?> className,
      Value<String> title,
      Value<DateTime?> assignmentDate,
      Value<String?> description,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
    });

class $$AssignmentMeetingRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $AssignmentMeetingRecordsTable> {
  $$AssignmentMeetingRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get assignmentDate => $composableBuilder(
    column: $table.assignmentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AssignmentMeetingRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssignmentMeetingRecordsTable> {
  $$AssignmentMeetingRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get assignmentDate => $composableBuilder(
    column: $table.assignmentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AssignmentMeetingRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssignmentMeetingRecordsTable> {
  $$AssignmentMeetingRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => column,
  );

  GeneratedColumn<int> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get className =>
      $composableBuilder(column: $table.className, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get assignmentDate => $composableBuilder(
    column: $table.assignmentDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AssignmentMeetingRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssignmentMeetingRecordsTable,
          AssignmentMeetingRecord,
          $$AssignmentMeetingRecordsTableFilterComposer,
          $$AssignmentMeetingRecordsTableOrderingComposer,
          $$AssignmentMeetingRecordsTableAnnotationComposer,
          $$AssignmentMeetingRecordsTableCreateCompanionBuilder,
          $$AssignmentMeetingRecordsTableUpdateCompanionBuilder,
          (
            AssignmentMeetingRecord,
            BaseReferences<
              _$AppDatabase,
              $AssignmentMeetingRecordsTable,
              AssignmentMeetingRecord
            >,
          ),
          AssignmentMeetingRecord,
          PrefetchHooks Function()
        > {
  $$AssignmentMeetingRecordsTableTableManager(
    _$AppDatabase db,
    $AssignmentMeetingRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssignmentMeetingRecordsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$AssignmentMeetingRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AssignmentMeetingRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<String> clientUuid = const Value.absent(),
                Value<int?> classId = const Value.absent(),
                Value<String?> className = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime?> assignmentDate = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AssignmentMeetingRecordsCompanion(
                localId: localId,
                remoteId: remoteId,
                clientUuid: clientUuid,
                classId: classId,
                className: className,
                title: title,
                assignmentDate: assignmentDate,
                description: description,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                required String clientUuid,
                Value<int?> classId = const Value.absent(),
                Value<String?> className = const Value.absent(),
                required String title,
                Value<DateTime?> assignmentDate = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AssignmentMeetingRecordsCompanion.insert(
                localId: localId,
                remoteId: remoteId,
                clientUuid: clientUuid,
                classId: classId,
                className: className,
                title: title,
                assignmentDate: assignmentDate,
                description: description,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $AssignmentMeetingRecordsTable,
                    AssignmentMeetingRecord
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AssignmentMeetingRecordsTable,
                    AssignmentMeetingRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AssignmentMeetingRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssignmentMeetingRecordsTable,
      AssignmentMeetingRecord,
      $$AssignmentMeetingRecordsTableFilterComposer,
      $$AssignmentMeetingRecordsTableOrderingComposer,
      $$AssignmentMeetingRecordsTableAnnotationComposer,
      $$AssignmentMeetingRecordsTableCreateCompanionBuilder,
      $$AssignmentMeetingRecordsTableUpdateCompanionBuilder,
      (
        AssignmentMeetingRecord,
        BaseReferences<
          _$AppDatabase,
          $AssignmentMeetingRecordsTable,
          AssignmentMeetingRecord
        >,
      ),
      AssignmentMeetingRecord,
      PrefetchHooks Function()
    >;
typedef $$AssignmentScoreRecordsTableCreateCompanionBuilder =
    AssignmentScoreRecordsCompanion Function({
      Value<int> localId,
      Value<int?> remoteId,
      required String clientUuid,
      required int meetingLocalId,
      required int studentId,
      required double score,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
    });
typedef $$AssignmentScoreRecordsTableUpdateCompanionBuilder =
    AssignmentScoreRecordsCompanion Function({
      Value<int> localId,
      Value<int?> remoteId,
      Value<String> clientUuid,
      Value<int> meetingLocalId,
      Value<int> studentId,
      Value<double> score,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
    });

class $$AssignmentScoreRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $AssignmentScoreRecordsTable> {
  $$AssignmentScoreRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get meetingLocalId => $composableBuilder(
    column: $table.meetingLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AssignmentScoreRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssignmentScoreRecordsTable> {
  $$AssignmentScoreRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get meetingLocalId => $composableBuilder(
    column: $table.meetingLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AssignmentScoreRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssignmentScoreRecordsTable> {
  $$AssignmentScoreRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => column,
  );

  GeneratedColumn<int> get meetingLocalId => $composableBuilder(
    column: $table.meetingLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AssignmentScoreRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssignmentScoreRecordsTable,
          AssignmentScoreRecord,
          $$AssignmentScoreRecordsTableFilterComposer,
          $$AssignmentScoreRecordsTableOrderingComposer,
          $$AssignmentScoreRecordsTableAnnotationComposer,
          $$AssignmentScoreRecordsTableCreateCompanionBuilder,
          $$AssignmentScoreRecordsTableUpdateCompanionBuilder,
          (
            AssignmentScoreRecord,
            BaseReferences<
              _$AppDatabase,
              $AssignmentScoreRecordsTable,
              AssignmentScoreRecord
            >,
          ),
          AssignmentScoreRecord,
          PrefetchHooks Function()
        > {
  $$AssignmentScoreRecordsTableTableManager(
    _$AppDatabase db,
    $AssignmentScoreRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssignmentScoreRecordsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$AssignmentScoreRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AssignmentScoreRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<String> clientUuid = const Value.absent(),
                Value<int> meetingLocalId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<double> score = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AssignmentScoreRecordsCompanion(
                localId: localId,
                remoteId: remoteId,
                clientUuid: clientUuid,
                meetingLocalId: meetingLocalId,
                studentId: studentId,
                score: score,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                required String clientUuid,
                required int meetingLocalId,
                required int studentId,
                required double score,
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AssignmentScoreRecordsCompanion.insert(
                localId: localId,
                remoteId: remoteId,
                clientUuid: clientUuid,
                meetingLocalId: meetingLocalId,
                studentId: studentId,
                score: score,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $AssignmentScoreRecordsTable,
                    AssignmentScoreRecord
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AssignmentScoreRecordsTable,
                    AssignmentScoreRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AssignmentScoreRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssignmentScoreRecordsTable,
      AssignmentScoreRecord,
      $$AssignmentScoreRecordsTableFilterComposer,
      $$AssignmentScoreRecordsTableOrderingComposer,
      $$AssignmentScoreRecordsTableAnnotationComposer,
      $$AssignmentScoreRecordsTableCreateCompanionBuilder,
      $$AssignmentScoreRecordsTableUpdateCompanionBuilder,
      (
        AssignmentScoreRecord,
        BaseReferences<
          _$AppDatabase,
          $AssignmentScoreRecordsTable,
          AssignmentScoreRecord
        >,
      ),
      AssignmentScoreRecord,
      PrefetchHooks Function()
    >;
typedef $$PendingOperationsTableCreateCompanionBuilder =
    PendingOperationsCompanion Function({
      Value<int> id,
      required String entity,
      required int localId,
      required String operation,
      Value<String> payload,
      Value<DateTime> createdAt,
      Value<int> attempts,
      Value<String?> lastError,
    });
typedef $$PendingOperationsTableUpdateCompanionBuilder =
    PendingOperationsCompanion Function({
      Value<int> id,
      Value<String> entity,
      Value<int> localId,
      Value<String> operation,
      Value<String> payload,
      Value<DateTime> createdAt,
      Value<int> attempts,
      Value<String?> lastError,
    });

class $$PendingOperationsTableFilterComposer
    extends Composer<_$AppDatabase, $PendingOperationsTable> {
  $$PendingOperationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PendingOperationsTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingOperationsTable> {
  $$PendingOperationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PendingOperationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingOperationsTable> {
  $$PendingOperationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$PendingOperationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PendingOperationsTable,
          PendingOperation,
          $$PendingOperationsTableFilterComposer,
          $$PendingOperationsTableOrderingComposer,
          $$PendingOperationsTableAnnotationComposer,
          $$PendingOperationsTableCreateCompanionBuilder,
          $$PendingOperationsTableUpdateCompanionBuilder,
          (
            PendingOperation,
            BaseReferences<
              _$AppDatabase,
              $PendingOperationsTable,
              PendingOperation
            >,
          ),
          PendingOperation,
          PrefetchHooks Function()
        > {
  $$PendingOperationsTableTableManager(
    _$AppDatabase db,
    $PendingOperationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingOperationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingOperationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingOperationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entity = const Value.absent(),
                Value<int> localId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => PendingOperationsCompanion(
                id: id,
                entity: entity,
                localId: localId,
                operation: operation,
                payload: payload,
                createdAt: createdAt,
                attempts: attempts,
                lastError: lastError,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entity,
                required int localId,
                required String operation,
                Value<String> payload = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => PendingOperationsCompanion.insert(
                id: id,
                entity: entity,
                localId: localId,
                operation: operation,
                payload: payload,
                createdAt: createdAt,
                attempts: attempts,
                lastError: lastError,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PendingOperationsTable, PendingOperation>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PendingOperationsTable,
                    PendingOperation
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingOperationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PendingOperationsTable,
      PendingOperation,
      $$PendingOperationsTableFilterComposer,
      $$PendingOperationsTableOrderingComposer,
      $$PendingOperationsTableAnnotationComposer,
      $$PendingOperationsTableCreateCompanionBuilder,
      $$PendingOperationsTableUpdateCompanionBuilder,
      (
        PendingOperation,
        BaseReferences<
          _$AppDatabase,
          $PendingOperationsTable,
          PendingOperation
        >,
      ),
      PendingOperation,
      PrefetchHooks Function()
    >;
typedef $$CachedDashboardTableCreateCompanionBuilder =
    CachedDashboardCompanion Function({
      Value<int> id,
      required String payload,
      required DateTime fetchedAt,
    });
typedef $$CachedDashboardTableUpdateCompanionBuilder =
    CachedDashboardCompanion Function({
      Value<int> id,
      Value<String> payload,
      Value<DateTime> fetchedAt,
    });

class $$CachedDashboardTableFilterComposer
    extends Composer<_$AppDatabase, $CachedDashboardTable> {
  $$CachedDashboardTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedDashboardTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedDashboardTable> {
  $$CachedDashboardTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedDashboardTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedDashboardTable> {
  $$CachedDashboardTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$CachedDashboardTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedDashboardTable,
          CachedDashboardData,
          $$CachedDashboardTableFilterComposer,
          $$CachedDashboardTableOrderingComposer,
          $$CachedDashboardTableAnnotationComposer,
          $$CachedDashboardTableCreateCompanionBuilder,
          $$CachedDashboardTableUpdateCompanionBuilder,
          (
            CachedDashboardData,
            BaseReferences<
              _$AppDatabase,
              $CachedDashboardTable,
              CachedDashboardData
            >,
          ),
          CachedDashboardData,
          PrefetchHooks Function()
        > {
  $$CachedDashboardTableTableManager(
    _$AppDatabase db,
    $CachedDashboardTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedDashboardTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedDashboardTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedDashboardTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
              }) => CachedDashboardCompanion(
                id: id,
                payload: payload,
                fetchedAt: fetchedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String payload,
                required DateTime fetchedAt,
              }) => CachedDashboardCompanion.insert(
                id: id,
                payload: payload,
                fetchedAt: fetchedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedDashboardTable, CachedDashboardData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $CachedDashboardTable,
                    CachedDashboardData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedDashboardTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedDashboardTable,
      CachedDashboardData,
      $$CachedDashboardTableFilterComposer,
      $$CachedDashboardTableOrderingComposer,
      $$CachedDashboardTableAnnotationComposer,
      $$CachedDashboardTableCreateCompanionBuilder,
      $$CachedDashboardTableUpdateCompanionBuilder,
      (
        CachedDashboardData,
        BaseReferences<
          _$AppDatabase,
          $CachedDashboardTable,
          CachedDashboardData
        >,
      ),
      CachedDashboardData,
      PrefetchHooks Function()
    >;
typedef $$AppMetaTableCreateCompanionBuilder = AppMetaCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$AppMetaTableUpdateCompanionBuilder = AppMetaCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$AppMetaTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetaTable,
          AppMetaData,
          $$AppMetaTableFilterComposer,
          $$AppMetaTableOrderingComposer,
          $$AppMetaTableAnnotationComposer,
          $$AppMetaTableCreateCompanionBuilder,
          $$AppMetaTableUpdateCompanionBuilder,
          (
            AppMetaData,
            BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaData>,
          ),
          AppMetaData,
          PrefetchHooks Function()
        > {
  $$AppMetaTableTableManager(_$AppDatabase db, $AppMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => AppMetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => AppMetaCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppMetaTable, AppMetaData>(table),
                  BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaData>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetaTable,
      AppMetaData,
      $$AppMetaTableFilterComposer,
      $$AppMetaTableOrderingComposer,
      $$AppMetaTableAnnotationComposer,
      $$AppMetaTableCreateCompanionBuilder,
      $$AppMetaTableUpdateCompanionBuilder,
      (AppMetaData, BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaData>),
      AppMetaData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedClassesTableTableManager get cachedClasses =>
      $$CachedClassesTableTableManager(_db, _db.cachedClasses);
  $$CachedStudentsTableTableManager get cachedStudents =>
      $$CachedStudentsTableTableManager(_db, _db.cachedStudents);
  $$MeetingRecordsTableTableManager get meetingRecords =>
      $$MeetingRecordsTableTableManager(_db, _db.meetingRecords);
  $$AttendanceRecordsTableTableManager get attendanceRecords =>
      $$AttendanceRecordsTableTableManager(_db, _db.attendanceRecords);
  $$DailyTestMeetingRecordsTableTableManager get dailyTestMeetingRecords =>
      $$DailyTestMeetingRecordsTableTableManager(
        _db,
        _db.dailyTestMeetingRecords,
      );
  $$DailyTestScoreRecordsTableTableManager get dailyTestScoreRecords =>
      $$DailyTestScoreRecordsTableTableManager(_db, _db.dailyTestScoreRecords);
  $$AssignmentMeetingRecordsTableTableManager get assignmentMeetingRecords =>
      $$AssignmentMeetingRecordsTableTableManager(
        _db,
        _db.assignmentMeetingRecords,
      );
  $$AssignmentScoreRecordsTableTableManager get assignmentScoreRecords =>
      $$AssignmentScoreRecordsTableTableManager(
        _db,
        _db.assignmentScoreRecords,
      );
  $$PendingOperationsTableTableManager get pendingOperations =>
      $$PendingOperationsTableTableManager(_db, _db.pendingOperations);
  $$CachedDashboardTableTableManager get cachedDashboard =>
      $$CachedDashboardTableTableManager(_db, _db.cachedDashboard);
  $$AppMetaTableTableManager get appMeta =>
      $$AppMetaTableTableManager(_db, _db.appMeta);
}

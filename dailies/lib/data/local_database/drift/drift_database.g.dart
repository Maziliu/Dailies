// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $DriftTimeSlotsTable extends DriftTimeSlots
    with TableInfo<$DriftTimeSlotsTable, DriftTimeSlot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftTimeSlotsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nextTimeSlotIdMeta = const VerificationMeta(
    'nextTimeSlotId',
  );
  @override
  late final GeneratedColumn<int> nextTimeSlotId = GeneratedColumn<int>(
    'next_time_slot_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES drift_time_slots (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nextTimeSlotId,
    date,
    startTime,
    endTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_time_slots';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftTimeSlot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('next_time_slot_id')) {
      context.handle(
        _nextTimeSlotIdMeta,
        nextTimeSlotId.isAcceptableOrUnknown(
          data['next_time_slot_id']!,
          _nextTimeSlotIdMeta,
        ),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftTimeSlot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftTimeSlot(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      nextTimeSlotId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_time_slot_id'],
      ),
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      ),
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
    );
  }

  @override
  $DriftTimeSlotsTable createAlias(String alias) {
    return $DriftTimeSlotsTable(attachedDatabase, alias);
  }
}

class DriftTimeSlot extends DataClass implements Insertable<DriftTimeSlot> {
  final int id;
  final int? nextTimeSlotId;
  final DateTime date;
  final DateTime? startTime;
  final DateTime? endTime;
  const DriftTimeSlot({
    required this.id,
    this.nextTimeSlotId,
    required this.date,
    this.startTime,
    this.endTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || nextTimeSlotId != null) {
      map['next_time_slot_id'] = Variable<int>(nextTimeSlotId);
    }
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    return map;
  }

  DriftTimeSlotsCompanion toCompanion(bool nullToAbsent) {
    return DriftTimeSlotsCompanion(
      id: Value(id),
      nextTimeSlotId:
          nextTimeSlotId == null && nullToAbsent
              ? const Value.absent()
              : Value(nextTimeSlotId),
      date: Value(date),
      startTime:
          startTime == null && nullToAbsent
              ? const Value.absent()
              : Value(startTime),
      endTime:
          endTime == null && nullToAbsent
              ? const Value.absent()
              : Value(endTime),
    );
  }

  factory DriftTimeSlot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftTimeSlot(
      id: serializer.fromJson<int>(json['id']),
      nextTimeSlotId: serializer.fromJson<int?>(json['nextTimeSlotId']),
      date: serializer.fromJson<DateTime>(json['date']),
      startTime: serializer.fromJson<DateTime?>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nextTimeSlotId': serializer.toJson<int?>(nextTimeSlotId),
      'date': serializer.toJson<DateTime>(date),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
    };
  }

  DriftTimeSlot copyWith({
    int? id,
    Value<int?> nextTimeSlotId = const Value.absent(),
    DateTime? date,
    Value<DateTime?> startTime = const Value.absent(),
    Value<DateTime?> endTime = const Value.absent(),
  }) => DriftTimeSlot(
    id: id ?? this.id,
    nextTimeSlotId:
        nextTimeSlotId.present ? nextTimeSlotId.value : this.nextTimeSlotId,
    date: date ?? this.date,
    startTime: startTime.present ? startTime.value : this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
  );
  DriftTimeSlot copyWithCompanion(DriftTimeSlotsCompanion data) {
    return DriftTimeSlot(
      id: data.id.present ? data.id.value : this.id,
      nextTimeSlotId:
          data.nextTimeSlotId.present
              ? data.nextTimeSlotId.value
              : this.nextTimeSlotId,
      date: data.date.present ? data.date.value : this.date,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftTimeSlot(')
          ..write('id: $id, ')
          ..write('nextTimeSlotId: $nextTimeSlotId, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nextTimeSlotId, date, startTime, endTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftTimeSlot &&
          other.id == this.id &&
          other.nextTimeSlotId == this.nextTimeSlotId &&
          other.date == this.date &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime);
}

class DriftTimeSlotsCompanion extends UpdateCompanion<DriftTimeSlot> {
  final Value<int> id;
  final Value<int?> nextTimeSlotId;
  final Value<DateTime> date;
  final Value<DateTime?> startTime;
  final Value<DateTime?> endTime;
  const DriftTimeSlotsCompanion({
    this.id = const Value.absent(),
    this.nextTimeSlotId = const Value.absent(),
    this.date = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
  });
  DriftTimeSlotsCompanion.insert({
    this.id = const Value.absent(),
    this.nextTimeSlotId = const Value.absent(),
    required DateTime date,
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
  }) : date = Value(date);
  static Insertable<DriftTimeSlot> custom({
    Expression<int>? id,
    Expression<int>? nextTimeSlotId,
    Expression<DateTime>? date,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nextTimeSlotId != null) 'next_time_slot_id': nextTimeSlotId,
      if (date != null) 'date': date,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
    });
  }

  DriftTimeSlotsCompanion copyWith({
    Value<int>? id,
    Value<int?>? nextTimeSlotId,
    Value<DateTime>? date,
    Value<DateTime?>? startTime,
    Value<DateTime?>? endTime,
  }) {
    return DriftTimeSlotsCompanion(
      id: id ?? this.id,
      nextTimeSlotId: nextTimeSlotId ?? this.nextTimeSlotId,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nextTimeSlotId.present) {
      map['next_time_slot_id'] = Variable<int>(nextTimeSlotId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftTimeSlotsCompanion(')
          ..write('id: $id, ')
          ..write('nextTimeSlotId: $nextTimeSlotId, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }
}

class $DriftEventsTable extends DriftEvents
    with TableInfo<$DriftEventsTable, DriftEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftEventsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _eventNameMeta = const VerificationMeta(
    'eventName',
  );
  @override
  late final GeneratedColumn<String> eventName = GeneratedColumn<String>(
    'event_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeSlotIdMeta = const VerificationMeta(
    'timeSlotId',
  );
  @override
  late final GeneratedColumn<int> timeSlotId = GeneratedColumn<int>(
    'time_slot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES drift_time_slots (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, eventName, location, timeSlotId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_name')) {
      context.handle(
        _eventNameMeta,
        eventName.isAcceptableOrUnknown(data['event_name']!, _eventNameMeta),
      );
    } else if (isInserting) {
      context.missing(_eventNameMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('time_slot_id')) {
      context.handle(
        _timeSlotIdMeta,
        timeSlotId.isAcceptableOrUnknown(
          data['time_slot_id']!,
          _timeSlotIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timeSlotIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftEvent(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      eventName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}event_name'],
          )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      timeSlotId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}time_slot_id'],
          )!,
    );
  }

  @override
  $DriftEventsTable createAlias(String alias) {
    return $DriftEventsTable(attachedDatabase, alias);
  }
}

class DriftEvent extends DataClass implements Insertable<DriftEvent> {
  final int id;
  final String eventName;
  final String? location;
  final int timeSlotId;
  const DriftEvent({
    required this.id,
    required this.eventName,
    this.location,
    required this.timeSlotId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_name'] = Variable<String>(eventName);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['time_slot_id'] = Variable<int>(timeSlotId);
    return map;
  }

  DriftEventsCompanion toCompanion(bool nullToAbsent) {
    return DriftEventsCompanion(
      id: Value(id),
      eventName: Value(eventName),
      location:
          location == null && nullToAbsent
              ? const Value.absent()
              : Value(location),
      timeSlotId: Value(timeSlotId),
    );
  }

  factory DriftEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftEvent(
      id: serializer.fromJson<int>(json['id']),
      eventName: serializer.fromJson<String>(json['eventName']),
      location: serializer.fromJson<String?>(json['location']),
      timeSlotId: serializer.fromJson<int>(json['timeSlotId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventName': serializer.toJson<String>(eventName),
      'location': serializer.toJson<String?>(location),
      'timeSlotId': serializer.toJson<int>(timeSlotId),
    };
  }

  DriftEvent copyWith({
    int? id,
    String? eventName,
    Value<String?> location = const Value.absent(),
    int? timeSlotId,
  }) => DriftEvent(
    id: id ?? this.id,
    eventName: eventName ?? this.eventName,
    location: location.present ? location.value : this.location,
    timeSlotId: timeSlotId ?? this.timeSlotId,
  );
  DriftEvent copyWithCompanion(DriftEventsCompanion data) {
    return DriftEvent(
      id: data.id.present ? data.id.value : this.id,
      eventName: data.eventName.present ? data.eventName.value : this.eventName,
      location: data.location.present ? data.location.value : this.location,
      timeSlotId:
          data.timeSlotId.present ? data.timeSlotId.value : this.timeSlotId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftEvent(')
          ..write('id: $id, ')
          ..write('eventName: $eventName, ')
          ..write('location: $location, ')
          ..write('timeSlotId: $timeSlotId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventName, location, timeSlotId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftEvent &&
          other.id == this.id &&
          other.eventName == this.eventName &&
          other.location == this.location &&
          other.timeSlotId == this.timeSlotId);
}

class DriftEventsCompanion extends UpdateCompanion<DriftEvent> {
  final Value<int> id;
  final Value<String> eventName;
  final Value<String?> location;
  final Value<int> timeSlotId;
  const DriftEventsCompanion({
    this.id = const Value.absent(),
    this.eventName = const Value.absent(),
    this.location = const Value.absent(),
    this.timeSlotId = const Value.absent(),
  });
  DriftEventsCompanion.insert({
    this.id = const Value.absent(),
    required String eventName,
    this.location = const Value.absent(),
    required int timeSlotId,
  }) : eventName = Value(eventName),
       timeSlotId = Value(timeSlotId);
  static Insertable<DriftEvent> custom({
    Expression<int>? id,
    Expression<String>? eventName,
    Expression<String>? location,
    Expression<int>? timeSlotId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventName != null) 'event_name': eventName,
      if (location != null) 'location': location,
      if (timeSlotId != null) 'time_slot_id': timeSlotId,
    });
  }

  DriftEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? eventName,
    Value<String?>? location,
    Value<int>? timeSlotId,
  }) {
    return DriftEventsCompanion(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      location: location ?? this.location,
      timeSlotId: timeSlotId ?? this.timeSlotId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventName.present) {
      map['event_name'] = Variable<String>(eventName.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (timeSlotId.present) {
      map['time_slot_id'] = Variable<int>(timeSlotId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftEventsCompanion(')
          ..write('id: $id, ')
          ..write('eventName: $eventName, ')
          ..write('location: $location, ')
          ..write('timeSlotId: $timeSlotId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DriftTimeSlotsTable driftTimeSlots = $DriftTimeSlotsTable(this);
  late final $DriftEventsTable driftEvents = $DriftEventsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    driftTimeSlots,
    driftEvents,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'drift_time_slots',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('drift_time_slots', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'drift_time_slots',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('drift_events', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$DriftTimeSlotsTableCreateCompanionBuilder =
    DriftTimeSlotsCompanion Function({
      Value<int> id,
      Value<int?> nextTimeSlotId,
      required DateTime date,
      Value<DateTime?> startTime,
      Value<DateTime?> endTime,
    });
typedef $$DriftTimeSlotsTableUpdateCompanionBuilder =
    DriftTimeSlotsCompanion Function({
      Value<int> id,
      Value<int?> nextTimeSlotId,
      Value<DateTime> date,
      Value<DateTime?> startTime,
      Value<DateTime?> endTime,
    });

final class $$DriftTimeSlotsTableReferences
    extends BaseReferences<_$AppDatabase, $DriftTimeSlotsTable, DriftTimeSlot> {
  $$DriftTimeSlotsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DriftTimeSlotsTable _nextTimeSlotIdTable(_$AppDatabase db) =>
      db.driftTimeSlots.createAlias(
        $_aliasNameGenerator(
          db.driftTimeSlots.nextTimeSlotId,
          db.driftTimeSlots.id,
        ),
      );

  $$DriftTimeSlotsTableProcessedTableManager? get nextTimeSlotId {
    final $_column = $_itemColumn<int>('next_time_slot_id');
    if ($_column == null) return null;
    final manager = $$DriftTimeSlotsTableTableManager(
      $_db,
      $_db.driftTimeSlots,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_nextTimeSlotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DriftEventsTable, List<DriftEvent>>
  _driftEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.driftEvents,
    aliasName: $_aliasNameGenerator(
      db.driftTimeSlots.id,
      db.driftEvents.timeSlotId,
    ),
  );

  $$DriftEventsTableProcessedTableManager get driftEventsRefs {
    final manager = $$DriftEventsTableTableManager(
      $_db,
      $_db.driftEvents,
    ).filter((f) => f.timeSlotId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_driftEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DriftTimeSlotsTableFilterComposer
    extends Composer<_$AppDatabase, $DriftTimeSlotsTable> {
  $$DriftTimeSlotsTableFilterComposer({
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  $$DriftTimeSlotsTableFilterComposer get nextTimeSlotId {
    final $$DriftTimeSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nextTimeSlotId,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DriftTimeSlotsTableFilterComposer(
            $db: $db,
            $table: $db.driftTimeSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> driftEventsRefs(
    Expression<bool> Function($$DriftEventsTableFilterComposer f) f,
  ) {
    final $$DriftEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.driftEvents,
      getReferencedColumn: (t) => t.timeSlotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DriftEventsTableFilterComposer(
            $db: $db,
            $table: $db.driftEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DriftTimeSlotsTableOrderingComposer
    extends Composer<_$AppDatabase, $DriftTimeSlotsTable> {
  $$DriftTimeSlotsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  $$DriftTimeSlotsTableOrderingComposer get nextTimeSlotId {
    final $$DriftTimeSlotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nextTimeSlotId,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DriftTimeSlotsTableOrderingComposer(
            $db: $db,
            $table: $db.driftTimeSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DriftTimeSlotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DriftTimeSlotsTable> {
  $$DriftTimeSlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  $$DriftTimeSlotsTableAnnotationComposer get nextTimeSlotId {
    final $$DriftTimeSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nextTimeSlotId,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DriftTimeSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.driftTimeSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> driftEventsRefs<T extends Object>(
    Expression<T> Function($$DriftEventsTableAnnotationComposer a) f,
  ) {
    final $$DriftEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.driftEvents,
      getReferencedColumn: (t) => t.timeSlotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DriftEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.driftEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DriftTimeSlotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DriftTimeSlotsTable,
          DriftTimeSlot,
          $$DriftTimeSlotsTableFilterComposer,
          $$DriftTimeSlotsTableOrderingComposer,
          $$DriftTimeSlotsTableAnnotationComposer,
          $$DriftTimeSlotsTableCreateCompanionBuilder,
          $$DriftTimeSlotsTableUpdateCompanionBuilder,
          (DriftTimeSlot, $$DriftTimeSlotsTableReferences),
          DriftTimeSlot,
          PrefetchHooks Function({bool nextTimeSlotId, bool driftEventsRefs})
        > {
  $$DriftTimeSlotsTableTableManager(
    _$AppDatabase db,
    $DriftTimeSlotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DriftTimeSlotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$DriftTimeSlotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$DriftTimeSlotsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> nextTimeSlotId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
              }) => DriftTimeSlotsCompanion(
                id: id,
                nextTimeSlotId: nextTimeSlotId,
                date: date,
                startTime: startTime,
                endTime: endTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> nextTimeSlotId = const Value.absent(),
                required DateTime date,
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
              }) => DriftTimeSlotsCompanion.insert(
                id: id,
                nextTimeSlotId: nextTimeSlotId,
                date: date,
                startTime: startTime,
                endTime: endTime,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$DriftTimeSlotsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            nextTimeSlotId = false,
            driftEventsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (driftEventsRefs) db.driftEvents],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (nextTimeSlotId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.nextTimeSlotId,
                            referencedTable: $$DriftTimeSlotsTableReferences
                                ._nextTimeSlotIdTable(db),
                            referencedColumn:
                                $$DriftTimeSlotsTableReferences
                                    ._nextTimeSlotIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (driftEventsRefs)
                    await $_getPrefetchedData<
                      DriftTimeSlot,
                      $DriftTimeSlotsTable,
                      DriftEvent
                    >(
                      currentTable: table,
                      referencedTable: $$DriftTimeSlotsTableReferences
                          ._driftEventsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$DriftTimeSlotsTableReferences(
                                db,
                                table,
                                p0,
                              ).driftEventsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.timeSlotId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DriftTimeSlotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DriftTimeSlotsTable,
      DriftTimeSlot,
      $$DriftTimeSlotsTableFilterComposer,
      $$DriftTimeSlotsTableOrderingComposer,
      $$DriftTimeSlotsTableAnnotationComposer,
      $$DriftTimeSlotsTableCreateCompanionBuilder,
      $$DriftTimeSlotsTableUpdateCompanionBuilder,
      (DriftTimeSlot, $$DriftTimeSlotsTableReferences),
      DriftTimeSlot,
      PrefetchHooks Function({bool nextTimeSlotId, bool driftEventsRefs})
    >;
typedef $$DriftEventsTableCreateCompanionBuilder =
    DriftEventsCompanion Function({
      Value<int> id,
      required String eventName,
      Value<String?> location,
      required int timeSlotId,
    });
typedef $$DriftEventsTableUpdateCompanionBuilder =
    DriftEventsCompanion Function({
      Value<int> id,
      Value<String> eventName,
      Value<String?> location,
      Value<int> timeSlotId,
    });

final class $$DriftEventsTableReferences
    extends BaseReferences<_$AppDatabase, $DriftEventsTable, DriftEvent> {
  $$DriftEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DriftTimeSlotsTable _timeSlotIdTable(_$AppDatabase db) =>
      db.driftTimeSlots.createAlias(
        $_aliasNameGenerator(db.driftEvents.timeSlotId, db.driftTimeSlots.id),
      );

  $$DriftTimeSlotsTableProcessedTableManager get timeSlotId {
    final $_column = $_itemColumn<int>('time_slot_id')!;

    final manager = $$DriftTimeSlotsTableTableManager(
      $_db,
      $_db.driftTimeSlots,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_timeSlotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DriftEventsTableFilterComposer
    extends Composer<_$AppDatabase, $DriftEventsTable> {
  $$DriftEventsTableFilterComposer({
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

  ColumnFilters<String> get eventName => $composableBuilder(
    column: $table.eventName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  $$DriftTimeSlotsTableFilterComposer get timeSlotId {
    final $$DriftTimeSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeSlotId,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DriftTimeSlotsTableFilterComposer(
            $db: $db,
            $table: $db.driftTimeSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DriftEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $DriftEventsTable> {
  $$DriftEventsTableOrderingComposer({
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

  ColumnOrderings<String> get eventName => $composableBuilder(
    column: $table.eventName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  $$DriftTimeSlotsTableOrderingComposer get timeSlotId {
    final $$DriftTimeSlotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeSlotId,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DriftTimeSlotsTableOrderingComposer(
            $db: $db,
            $table: $db.driftTimeSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DriftEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DriftEventsTable> {
  $$DriftEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventName =>
      $composableBuilder(column: $table.eventName, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  $$DriftTimeSlotsTableAnnotationComposer get timeSlotId {
    final $$DriftTimeSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeSlotId,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DriftTimeSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.driftTimeSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DriftEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DriftEventsTable,
          DriftEvent,
          $$DriftEventsTableFilterComposer,
          $$DriftEventsTableOrderingComposer,
          $$DriftEventsTableAnnotationComposer,
          $$DriftEventsTableCreateCompanionBuilder,
          $$DriftEventsTableUpdateCompanionBuilder,
          (DriftEvent, $$DriftEventsTableReferences),
          DriftEvent,
          PrefetchHooks Function({bool timeSlotId})
        > {
  $$DriftEventsTableTableManager(_$AppDatabase db, $DriftEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DriftEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DriftEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$DriftEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> eventName = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<int> timeSlotId = const Value.absent(),
              }) => DriftEventsCompanion(
                id: id,
                eventName: eventName,
                location: location,
                timeSlotId: timeSlotId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String eventName,
                Value<String?> location = const Value.absent(),
                required int timeSlotId,
              }) => DriftEventsCompanion.insert(
                id: id,
                eventName: eventName,
                location: location,
                timeSlotId: timeSlotId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$DriftEventsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({timeSlotId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (timeSlotId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.timeSlotId,
                            referencedTable: $$DriftEventsTableReferences
                                ._timeSlotIdTable(db),
                            referencedColumn:
                                $$DriftEventsTableReferences
                                    ._timeSlotIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DriftEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DriftEventsTable,
      DriftEvent,
      $$DriftEventsTableFilterComposer,
      $$DriftEventsTableOrderingComposer,
      $$DriftEventsTableAnnotationComposer,
      $$DriftEventsTableCreateCompanionBuilder,
      $$DriftEventsTableUpdateCompanionBuilder,
      (DriftEvent, $$DriftEventsTableReferences),
      DriftEvent,
      PrefetchHooks Function({bool timeSlotId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DriftTimeSlotsTableTableManager get driftTimeSlots =>
      $$DriftTimeSlotsTableTableManager(_db, _db.driftTimeSlots);
  $$DriftEventsTableTableManager get driftEvents =>
      $$DriftEventsTableTableManager(_db, _db.driftEvents);
}

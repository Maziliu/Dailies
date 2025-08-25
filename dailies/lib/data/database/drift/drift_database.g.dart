// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
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
  @override
  List<GeneratedColumn> get $columns => [id, eventName, location];
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
  const DriftEvent({required this.id, required this.eventName, this.location});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_name'] = Variable<String>(eventName);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
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
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventName': serializer.toJson<String>(eventName),
      'location': serializer.toJson<String?>(location),
    };
  }

  DriftEvent copyWith({
    int? id,
    String? eventName,
    Value<String?> location = const Value.absent(),
  }) => DriftEvent(
    id: id ?? this.id,
    eventName: eventName ?? this.eventName,
    location: location.present ? location.value : this.location,
  );
  DriftEvent copyWithCompanion(DriftEventsCompanion data) {
    return DriftEvent(
      id: data.id.present ? data.id.value : this.id,
      eventName: data.eventName.present ? data.eventName.value : this.eventName,
      location: data.location.present ? data.location.value : this.location,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftEvent(')
          ..write('id: $id, ')
          ..write('eventName: $eventName, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventName, location);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftEvent &&
          other.id == this.id &&
          other.eventName == this.eventName &&
          other.location == this.location);
}

class DriftEventsCompanion extends UpdateCompanion<DriftEvent> {
  final Value<int> id;
  final Value<String> eventName;
  final Value<String?> location;
  const DriftEventsCompanion({
    this.id = const Value.absent(),
    this.eventName = const Value.absent(),
    this.location = const Value.absent(),
  });
  DriftEventsCompanion.insert({
    this.id = const Value.absent(),
    required String eventName,
    this.location = const Value.absent(),
  }) : eventName = Value(eventName);
  static Insertable<DriftEvent> custom({
    Expression<int>? id,
    Expression<String>? eventName,
    Expression<String>? location,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventName != null) 'event_name': eventName,
      if (location != null) 'location': location,
    });
  }

  DriftEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? eventName,
    Value<String?>? location,
  }) {
    return DriftEventsCompanion(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      location: location ?? this.location,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftEventsCompanion(')
          ..write('id: $id, ')
          ..write('eventName: $eventName, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }
}

class $DriftTimeSlotPatternsTable extends DriftTimeSlotPatterns
    with TableInfo<$DriftTimeSlotPatternsTable, DriftTimeSlotPattern> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftTimeSlotPatternsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES drift_events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _anchorPointsMeta = const VerificationMeta(
    'anchorPoints',
  );
  @override
  late final GeneratedColumn<String> anchorPoints = GeneratedColumn<String>(
    'anchor_points',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _frequencyInSecondsMeta =
      const VerificationMeta('frequencyInSeconds');
  @override
  late final GeneratedColumn<int> frequencyInSeconds = GeneratedColumn<int>(
    'frequency_in_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeZoneIdMeta = const VerificationMeta(
    'timeZoneId',
  );
  @override
  late final GeneratedColumn<String> timeZoneId = GeneratedColumn<String>(
    'time_zone_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rruleMeta = const VerificationMeta('rrule');
  @override
  late final GeneratedColumn<String> rrule = GeneratedColumn<String>(
    'rrule',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    anchorPoints,
    frequencyInSeconds,
    endDate,
    timeZoneId,
    rrule,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_time_slot_patterns';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftTimeSlotPattern> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('anchor_points')) {
      context.handle(
        _anchorPointsMeta,
        anchorPoints.isAcceptableOrUnknown(
          data['anchor_points']!,
          _anchorPointsMeta,
        ),
      );
    }
    if (data.containsKey('frequency_in_seconds')) {
      context.handle(
        _frequencyInSecondsMeta,
        frequencyInSeconds.isAcceptableOrUnknown(
          data['frequency_in_seconds']!,
          _frequencyInSecondsMeta,
        ),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('time_zone_id')) {
      context.handle(
        _timeZoneIdMeta,
        timeZoneId.isAcceptableOrUnknown(
          data['time_zone_id']!,
          _timeZoneIdMeta,
        ),
      );
    }
    if (data.containsKey('rrule')) {
      context.handle(
        _rruleMeta,
        rrule.isAcceptableOrUnknown(data['rrule']!, _rruleMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftTimeSlotPattern map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftTimeSlotPattern(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      eventId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}event_id'],
          )!,
      anchorPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}anchor_points'],
      ),
      frequencyInSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frequency_in_seconds'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      timeZoneId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_zone_id'],
      ),
      rrule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rrule'],
      ),
    );
  }

  @override
  $DriftTimeSlotPatternsTable createAlias(String alias) {
    return $DriftTimeSlotPatternsTable(attachedDatabase, alias);
  }
}

class DriftTimeSlotPattern extends DataClass
    implements Insertable<DriftTimeSlotPattern> {
  final int id;
  final int eventId;
  final String? anchorPoints;
  final int? frequencyInSeconds;
  final DateTime? endDate;
  final String? timeZoneId;
  final String? rrule;
  const DriftTimeSlotPattern({
    required this.id,
    required this.eventId,
    this.anchorPoints,
    this.frequencyInSeconds,
    this.endDate,
    this.timeZoneId,
    this.rrule,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_id'] = Variable<int>(eventId);
    if (!nullToAbsent || anchorPoints != null) {
      map['anchor_points'] = Variable<String>(anchorPoints);
    }
    if (!nullToAbsent || frequencyInSeconds != null) {
      map['frequency_in_seconds'] = Variable<int>(frequencyInSeconds);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || timeZoneId != null) {
      map['time_zone_id'] = Variable<String>(timeZoneId);
    }
    if (!nullToAbsent || rrule != null) {
      map['rrule'] = Variable<String>(rrule);
    }
    return map;
  }

  DriftTimeSlotPatternsCompanion toCompanion(bool nullToAbsent) {
    return DriftTimeSlotPatternsCompanion(
      id: Value(id),
      eventId: Value(eventId),
      anchorPoints:
          anchorPoints == null && nullToAbsent
              ? const Value.absent()
              : Value(anchorPoints),
      frequencyInSeconds:
          frequencyInSeconds == null && nullToAbsent
              ? const Value.absent()
              : Value(frequencyInSeconds),
      endDate:
          endDate == null && nullToAbsent
              ? const Value.absent()
              : Value(endDate),
      timeZoneId:
          timeZoneId == null && nullToAbsent
              ? const Value.absent()
              : Value(timeZoneId),
      rrule:
          rrule == null && nullToAbsent ? const Value.absent() : Value(rrule),
    );
  }

  factory DriftTimeSlotPattern.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftTimeSlotPattern(
      id: serializer.fromJson<int>(json['id']),
      eventId: serializer.fromJson<int>(json['eventId']),
      anchorPoints: serializer.fromJson<String?>(json['anchorPoints']),
      frequencyInSeconds: serializer.fromJson<int?>(json['frequencyInSeconds']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      timeZoneId: serializer.fromJson<String?>(json['timeZoneId']),
      rrule: serializer.fromJson<String?>(json['rrule']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventId': serializer.toJson<int>(eventId),
      'anchorPoints': serializer.toJson<String?>(anchorPoints),
      'frequencyInSeconds': serializer.toJson<int?>(frequencyInSeconds),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'timeZoneId': serializer.toJson<String?>(timeZoneId),
      'rrule': serializer.toJson<String?>(rrule),
    };
  }

  DriftTimeSlotPattern copyWith({
    int? id,
    int? eventId,
    Value<String?> anchorPoints = const Value.absent(),
    Value<int?> frequencyInSeconds = const Value.absent(),
    Value<DateTime?> endDate = const Value.absent(),
    Value<String?> timeZoneId = const Value.absent(),
    Value<String?> rrule = const Value.absent(),
  }) => DriftTimeSlotPattern(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    anchorPoints: anchorPoints.present ? anchorPoints.value : this.anchorPoints,
    frequencyInSeconds:
        frequencyInSeconds.present
            ? frequencyInSeconds.value
            : this.frequencyInSeconds,
    endDate: endDate.present ? endDate.value : this.endDate,
    timeZoneId: timeZoneId.present ? timeZoneId.value : this.timeZoneId,
    rrule: rrule.present ? rrule.value : this.rrule,
  );
  DriftTimeSlotPattern copyWithCompanion(DriftTimeSlotPatternsCompanion data) {
    return DriftTimeSlotPattern(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      anchorPoints:
          data.anchorPoints.present
              ? data.anchorPoints.value
              : this.anchorPoints,
      frequencyInSeconds:
          data.frequencyInSeconds.present
              ? data.frequencyInSeconds.value
              : this.frequencyInSeconds,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      timeZoneId:
          data.timeZoneId.present ? data.timeZoneId.value : this.timeZoneId,
      rrule: data.rrule.present ? data.rrule.value : this.rrule,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftTimeSlotPattern(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('anchorPoints: $anchorPoints, ')
          ..write('frequencyInSeconds: $frequencyInSeconds, ')
          ..write('endDate: $endDate, ')
          ..write('timeZoneId: $timeZoneId, ')
          ..write('rrule: $rrule')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventId,
    anchorPoints,
    frequencyInSeconds,
    endDate,
    timeZoneId,
    rrule,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftTimeSlotPattern &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.anchorPoints == this.anchorPoints &&
          other.frequencyInSeconds == this.frequencyInSeconds &&
          other.endDate == this.endDate &&
          other.timeZoneId == this.timeZoneId &&
          other.rrule == this.rrule);
}

class DriftTimeSlotPatternsCompanion
    extends UpdateCompanion<DriftTimeSlotPattern> {
  final Value<int> id;
  final Value<int> eventId;
  final Value<String?> anchorPoints;
  final Value<int?> frequencyInSeconds;
  final Value<DateTime?> endDate;
  final Value<String?> timeZoneId;
  final Value<String?> rrule;
  const DriftTimeSlotPatternsCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.anchorPoints = const Value.absent(),
    this.frequencyInSeconds = const Value.absent(),
    this.endDate = const Value.absent(),
    this.timeZoneId = const Value.absent(),
    this.rrule = const Value.absent(),
  });
  DriftTimeSlotPatternsCompanion.insert({
    this.id = const Value.absent(),
    required int eventId,
    this.anchorPoints = const Value.absent(),
    this.frequencyInSeconds = const Value.absent(),
    this.endDate = const Value.absent(),
    this.timeZoneId = const Value.absent(),
    this.rrule = const Value.absent(),
  }) : eventId = Value(eventId);
  static Insertable<DriftTimeSlotPattern> custom({
    Expression<int>? id,
    Expression<int>? eventId,
    Expression<String>? anchorPoints,
    Expression<int>? frequencyInSeconds,
    Expression<DateTime>? endDate,
    Expression<String>? timeZoneId,
    Expression<String>? rrule,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (anchorPoints != null) 'anchor_points': anchorPoints,
      if (frequencyInSeconds != null)
        'frequency_in_seconds': frequencyInSeconds,
      if (endDate != null) 'end_date': endDate,
      if (timeZoneId != null) 'time_zone_id': timeZoneId,
      if (rrule != null) 'rrule': rrule,
    });
  }

  DriftTimeSlotPatternsCompanion copyWith({
    Value<int>? id,
    Value<int>? eventId,
    Value<String?>? anchorPoints,
    Value<int?>? frequencyInSeconds,
    Value<DateTime?>? endDate,
    Value<String?>? timeZoneId,
    Value<String?>? rrule,
  }) {
    return DriftTimeSlotPatternsCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      anchorPoints: anchorPoints ?? this.anchorPoints,
      frequencyInSeconds: frequencyInSeconds ?? this.frequencyInSeconds,
      endDate: endDate ?? this.endDate,
      timeZoneId: timeZoneId ?? this.timeZoneId,
      rrule: rrule ?? this.rrule,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    if (anchorPoints.present) {
      map['anchor_points'] = Variable<String>(anchorPoints.value);
    }
    if (frequencyInSeconds.present) {
      map['frequency_in_seconds'] = Variable<int>(frequencyInSeconds.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (timeZoneId.present) {
      map['time_zone_id'] = Variable<String>(timeZoneId.value);
    }
    if (rrule.present) {
      map['rrule'] = Variable<String>(rrule.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftTimeSlotPatternsCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('anchorPoints: $anchorPoints, ')
          ..write('frequencyInSeconds: $frequencyInSeconds, ')
          ..write('endDate: $endDate, ')
          ..write('timeZoneId: $timeZoneId, ')
          ..write('rrule: $rrule')
          ..write(')'))
        .toString();
  }
}

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
  static const VerificationMeta _patternIdMeta = const VerificationMeta(
    'patternId',
  );
  @override
  late final GeneratedColumn<int> patternId = GeneratedColumn<int>(
    'pattern_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES drift_time_slot_patterns (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES drift_events (id) ON DELETE CASCADE',
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
    patternId,
    eventId,
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
    if (data.containsKey('pattern_id')) {
      context.handle(
        _patternIdMeta,
        patternId.isAcceptableOrUnknown(data['pattern_id']!, _patternIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patternIdMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
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
      patternId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}pattern_id'],
          )!,
      eventId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}event_id'],
          )!,
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
  final int patternId;
  final int eventId;
  final DateTime date;
  final DateTime? startTime;
  final DateTime? endTime;
  const DriftTimeSlot({
    required this.id,
    required this.patternId,
    required this.eventId,
    required this.date,
    this.startTime,
    this.endTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pattern_id'] = Variable<int>(patternId);
    map['event_id'] = Variable<int>(eventId);
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
      patternId: Value(patternId),
      eventId: Value(eventId),
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
      patternId: serializer.fromJson<int>(json['patternId']),
      eventId: serializer.fromJson<int>(json['eventId']),
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
      'patternId': serializer.toJson<int>(patternId),
      'eventId': serializer.toJson<int>(eventId),
      'date': serializer.toJson<DateTime>(date),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
    };
  }

  DriftTimeSlot copyWith({
    int? id,
    int? patternId,
    int? eventId,
    DateTime? date,
    Value<DateTime?> startTime = const Value.absent(),
    Value<DateTime?> endTime = const Value.absent(),
  }) => DriftTimeSlot(
    id: id ?? this.id,
    patternId: patternId ?? this.patternId,
    eventId: eventId ?? this.eventId,
    date: date ?? this.date,
    startTime: startTime.present ? startTime.value : this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
  );
  DriftTimeSlot copyWithCompanion(DriftTimeSlotsCompanion data) {
    return DriftTimeSlot(
      id: data.id.present ? data.id.value : this.id,
      patternId: data.patternId.present ? data.patternId.value : this.patternId,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      date: data.date.present ? data.date.value : this.date,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftTimeSlot(')
          ..write('id: $id, ')
          ..write('patternId: $patternId, ')
          ..write('eventId: $eventId, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, patternId, eventId, date, startTime, endTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftTimeSlot &&
          other.id == this.id &&
          other.patternId == this.patternId &&
          other.eventId == this.eventId &&
          other.date == this.date &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime);
}

class DriftTimeSlotsCompanion extends UpdateCompanion<DriftTimeSlot> {
  final Value<int> id;
  final Value<int> patternId;
  final Value<int> eventId;
  final Value<DateTime> date;
  final Value<DateTime?> startTime;
  final Value<DateTime?> endTime;
  const DriftTimeSlotsCompanion({
    this.id = const Value.absent(),
    this.patternId = const Value.absent(),
    this.eventId = const Value.absent(),
    this.date = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
  });
  DriftTimeSlotsCompanion.insert({
    this.id = const Value.absent(),
    required int patternId,
    required int eventId,
    required DateTime date,
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
  }) : patternId = Value(patternId),
       eventId = Value(eventId),
       date = Value(date);
  static Insertable<DriftTimeSlot> custom({
    Expression<int>? id,
    Expression<int>? patternId,
    Expression<int>? eventId,
    Expression<DateTime>? date,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patternId != null) 'pattern_id': patternId,
      if (eventId != null) 'event_id': eventId,
      if (date != null) 'date': date,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
    });
  }

  DriftTimeSlotsCompanion copyWith({
    Value<int>? id,
    Value<int>? patternId,
    Value<int>? eventId,
    Value<DateTime>? date,
    Value<DateTime?>? startTime,
    Value<DateTime?>? endTime,
  }) {
    return DriftTimeSlotsCompanion(
      id: id ?? this.id,
      patternId: patternId ?? this.patternId,
      eventId: eventId ?? this.eventId,
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
    if (patternId.present) {
      map['pattern_id'] = Variable<int>(patternId.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
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
          ..write('patternId: $patternId, ')
          ..write('eventId: $eventId, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }
}

class $DriftStaminasTable extends DriftStaminas
    with TableInfo<$DriftStaminasTable, DriftStamina> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftStaminasTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _gachaNameMeta = const VerificationMeta(
    'gachaName',
  );
  @override
  late final GeneratedColumn<String> gachaName = GeneratedColumn<String>(
    'gacha_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxStaminaMeta = const VerificationMeta(
    'maxStamina',
  );
  @override
  late final GeneratedColumn<int> maxStamina = GeneratedColumn<int>(
    'max_stamina',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rechargeTimeInSecondsMeta =
      const VerificationMeta('rechargeTimeInSeconds');
  @override
  late final GeneratedColumn<int> rechargeTimeInSeconds = GeneratedColumn<int>(
    'recharge_time_in_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _staminaOfLatestResetMeta =
      const VerificationMeta('staminaOfLatestReset');
  @override
  late final GeneratedColumn<int> staminaOfLatestReset = GeneratedColumn<int>(
    'stamina_of_latest_reset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeOfLastResetMeta = const VerificationMeta(
    'timeOfLastReset',
  );
  @override
  late final GeneratedColumn<DateTime> timeOfLastReset =
      GeneratedColumn<DateTime>(
        'time_of_last_reset',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _imageNameMeta = const VerificationMeta(
    'imageName',
  );
  @override
  late final GeneratedColumn<String> imageName = GeneratedColumn<String>(
    'image_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gachaName,
    maxStamina,
    rechargeTimeInSeconds,
    staminaOfLatestReset,
    timeOfLastReset,
    imageName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_staminas';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftStamina> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gacha_name')) {
      context.handle(
        _gachaNameMeta,
        gachaName.isAcceptableOrUnknown(data['gacha_name']!, _gachaNameMeta),
      );
    } else if (isInserting) {
      context.missing(_gachaNameMeta);
    }
    if (data.containsKey('max_stamina')) {
      context.handle(
        _maxStaminaMeta,
        maxStamina.isAcceptableOrUnknown(data['max_stamina']!, _maxStaminaMeta),
      );
    } else if (isInserting) {
      context.missing(_maxStaminaMeta);
    }
    if (data.containsKey('recharge_time_in_seconds')) {
      context.handle(
        _rechargeTimeInSecondsMeta,
        rechargeTimeInSeconds.isAcceptableOrUnknown(
          data['recharge_time_in_seconds']!,
          _rechargeTimeInSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rechargeTimeInSecondsMeta);
    }
    if (data.containsKey('stamina_of_latest_reset')) {
      context.handle(
        _staminaOfLatestResetMeta,
        staminaOfLatestReset.isAcceptableOrUnknown(
          data['stamina_of_latest_reset']!,
          _staminaOfLatestResetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_staminaOfLatestResetMeta);
    }
    if (data.containsKey('time_of_last_reset')) {
      context.handle(
        _timeOfLastResetMeta,
        timeOfLastReset.isAcceptableOrUnknown(
          data['time_of_last_reset']!,
          _timeOfLastResetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timeOfLastResetMeta);
    }
    if (data.containsKey('image_name')) {
      context.handle(
        _imageNameMeta,
        imageName.isAcceptableOrUnknown(data['image_name']!, _imageNameMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftStamina map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftStamina(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      gachaName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}gacha_name'],
          )!,
      maxStamina:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}max_stamina'],
          )!,
      rechargeTimeInSeconds:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}recharge_time_in_seconds'],
          )!,
      staminaOfLatestReset:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}stamina_of_latest_reset'],
          )!,
      timeOfLastReset:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}time_of_last_reset'],
          )!,
      imageName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_name'],
      ),
    );
  }

  @override
  $DriftStaminasTable createAlias(String alias) {
    return $DriftStaminasTable(attachedDatabase, alias);
  }
}

class DriftStamina extends DataClass implements Insertable<DriftStamina> {
  final int id;
  final String gachaName;
  final int maxStamina;
  final int rechargeTimeInSeconds;
  final int staminaOfLatestReset;
  final DateTime timeOfLastReset;
  final String? imageName;
  const DriftStamina({
    required this.id,
    required this.gachaName,
    required this.maxStamina,
    required this.rechargeTimeInSeconds,
    required this.staminaOfLatestReset,
    required this.timeOfLastReset,
    this.imageName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gacha_name'] = Variable<String>(gachaName);
    map['max_stamina'] = Variable<int>(maxStamina);
    map['recharge_time_in_seconds'] = Variable<int>(rechargeTimeInSeconds);
    map['stamina_of_latest_reset'] = Variable<int>(staminaOfLatestReset);
    map['time_of_last_reset'] = Variable<DateTime>(timeOfLastReset);
    if (!nullToAbsent || imageName != null) {
      map['image_name'] = Variable<String>(imageName);
    }
    return map;
  }

  DriftStaminasCompanion toCompanion(bool nullToAbsent) {
    return DriftStaminasCompanion(
      id: Value(id),
      gachaName: Value(gachaName),
      maxStamina: Value(maxStamina),
      rechargeTimeInSeconds: Value(rechargeTimeInSeconds),
      staminaOfLatestReset: Value(staminaOfLatestReset),
      timeOfLastReset: Value(timeOfLastReset),
      imageName:
          imageName == null && nullToAbsent
              ? const Value.absent()
              : Value(imageName),
    );
  }

  factory DriftStamina.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftStamina(
      id: serializer.fromJson<int>(json['id']),
      gachaName: serializer.fromJson<String>(json['gachaName']),
      maxStamina: serializer.fromJson<int>(json['maxStamina']),
      rechargeTimeInSeconds: serializer.fromJson<int>(
        json['rechargeTimeInSeconds'],
      ),
      staminaOfLatestReset: serializer.fromJson<int>(
        json['staminaOfLatestReset'],
      ),
      timeOfLastReset: serializer.fromJson<DateTime>(json['timeOfLastReset']),
      imageName: serializer.fromJson<String?>(json['imageName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gachaName': serializer.toJson<String>(gachaName),
      'maxStamina': serializer.toJson<int>(maxStamina),
      'rechargeTimeInSeconds': serializer.toJson<int>(rechargeTimeInSeconds),
      'staminaOfLatestReset': serializer.toJson<int>(staminaOfLatestReset),
      'timeOfLastReset': serializer.toJson<DateTime>(timeOfLastReset),
      'imageName': serializer.toJson<String?>(imageName),
    };
  }

  DriftStamina copyWith({
    int? id,
    String? gachaName,
    int? maxStamina,
    int? rechargeTimeInSeconds,
    int? staminaOfLatestReset,
    DateTime? timeOfLastReset,
    Value<String?> imageName = const Value.absent(),
  }) => DriftStamina(
    id: id ?? this.id,
    gachaName: gachaName ?? this.gachaName,
    maxStamina: maxStamina ?? this.maxStamina,
    rechargeTimeInSeconds: rechargeTimeInSeconds ?? this.rechargeTimeInSeconds,
    staminaOfLatestReset: staminaOfLatestReset ?? this.staminaOfLatestReset,
    timeOfLastReset: timeOfLastReset ?? this.timeOfLastReset,
    imageName: imageName.present ? imageName.value : this.imageName,
  );
  DriftStamina copyWithCompanion(DriftStaminasCompanion data) {
    return DriftStamina(
      id: data.id.present ? data.id.value : this.id,
      gachaName: data.gachaName.present ? data.gachaName.value : this.gachaName,
      maxStamina:
          data.maxStamina.present ? data.maxStamina.value : this.maxStamina,
      rechargeTimeInSeconds:
          data.rechargeTimeInSeconds.present
              ? data.rechargeTimeInSeconds.value
              : this.rechargeTimeInSeconds,
      staminaOfLatestReset:
          data.staminaOfLatestReset.present
              ? data.staminaOfLatestReset.value
              : this.staminaOfLatestReset,
      timeOfLastReset:
          data.timeOfLastReset.present
              ? data.timeOfLastReset.value
              : this.timeOfLastReset,
      imageName: data.imageName.present ? data.imageName.value : this.imageName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftStamina(')
          ..write('id: $id, ')
          ..write('gachaName: $gachaName, ')
          ..write('maxStamina: $maxStamina, ')
          ..write('rechargeTimeInSeconds: $rechargeTimeInSeconds, ')
          ..write('staminaOfLatestReset: $staminaOfLatestReset, ')
          ..write('timeOfLastReset: $timeOfLastReset, ')
          ..write('imageName: $imageName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gachaName,
    maxStamina,
    rechargeTimeInSeconds,
    staminaOfLatestReset,
    timeOfLastReset,
    imageName,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftStamina &&
          other.id == this.id &&
          other.gachaName == this.gachaName &&
          other.maxStamina == this.maxStamina &&
          other.rechargeTimeInSeconds == this.rechargeTimeInSeconds &&
          other.staminaOfLatestReset == this.staminaOfLatestReset &&
          other.timeOfLastReset == this.timeOfLastReset &&
          other.imageName == this.imageName);
}

class DriftStaminasCompanion extends UpdateCompanion<DriftStamina> {
  final Value<int> id;
  final Value<String> gachaName;
  final Value<int> maxStamina;
  final Value<int> rechargeTimeInSeconds;
  final Value<int> staminaOfLatestReset;
  final Value<DateTime> timeOfLastReset;
  final Value<String?> imageName;
  const DriftStaminasCompanion({
    this.id = const Value.absent(),
    this.gachaName = const Value.absent(),
    this.maxStamina = const Value.absent(),
    this.rechargeTimeInSeconds = const Value.absent(),
    this.staminaOfLatestReset = const Value.absent(),
    this.timeOfLastReset = const Value.absent(),
    this.imageName = const Value.absent(),
  });
  DriftStaminasCompanion.insert({
    this.id = const Value.absent(),
    required String gachaName,
    required int maxStamina,
    required int rechargeTimeInSeconds,
    required int staminaOfLatestReset,
    required DateTime timeOfLastReset,
    this.imageName = const Value.absent(),
  }) : gachaName = Value(gachaName),
       maxStamina = Value(maxStamina),
       rechargeTimeInSeconds = Value(rechargeTimeInSeconds),
       staminaOfLatestReset = Value(staminaOfLatestReset),
       timeOfLastReset = Value(timeOfLastReset);
  static Insertable<DriftStamina> custom({
    Expression<int>? id,
    Expression<String>? gachaName,
    Expression<int>? maxStamina,
    Expression<int>? rechargeTimeInSeconds,
    Expression<int>? staminaOfLatestReset,
    Expression<DateTime>? timeOfLastReset,
    Expression<String>? imageName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gachaName != null) 'gacha_name': gachaName,
      if (maxStamina != null) 'max_stamina': maxStamina,
      if (rechargeTimeInSeconds != null)
        'recharge_time_in_seconds': rechargeTimeInSeconds,
      if (staminaOfLatestReset != null)
        'stamina_of_latest_reset': staminaOfLatestReset,
      if (timeOfLastReset != null) 'time_of_last_reset': timeOfLastReset,
      if (imageName != null) 'image_name': imageName,
    });
  }

  DriftStaminasCompanion copyWith({
    Value<int>? id,
    Value<String>? gachaName,
    Value<int>? maxStamina,
    Value<int>? rechargeTimeInSeconds,
    Value<int>? staminaOfLatestReset,
    Value<DateTime>? timeOfLastReset,
    Value<String?>? imageName,
  }) {
    return DriftStaminasCompanion(
      id: id ?? this.id,
      gachaName: gachaName ?? this.gachaName,
      maxStamina: maxStamina ?? this.maxStamina,
      rechargeTimeInSeconds:
          rechargeTimeInSeconds ?? this.rechargeTimeInSeconds,
      staminaOfLatestReset: staminaOfLatestReset ?? this.staminaOfLatestReset,
      timeOfLastReset: timeOfLastReset ?? this.timeOfLastReset,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gachaName.present) {
      map['gacha_name'] = Variable<String>(gachaName.value);
    }
    if (maxStamina.present) {
      map['max_stamina'] = Variable<int>(maxStamina.value);
    }
    if (rechargeTimeInSeconds.present) {
      map['recharge_time_in_seconds'] = Variable<int>(
        rechargeTimeInSeconds.value,
      );
    }
    if (staminaOfLatestReset.present) {
      map['stamina_of_latest_reset'] = Variable<int>(
        staminaOfLatestReset.value,
      );
    }
    if (timeOfLastReset.present) {
      map['time_of_last_reset'] = Variable<DateTime>(timeOfLastReset.value);
    }
    if (imageName.present) {
      map['image_name'] = Variable<String>(imageName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftStaminasCompanion(')
          ..write('id: $id, ')
          ..write('gachaName: $gachaName, ')
          ..write('maxStamina: $maxStamina, ')
          ..write('rechargeTimeInSeconds: $rechargeTimeInSeconds, ')
          ..write('staminaOfLatestReset: $staminaOfLatestReset, ')
          ..write('timeOfLastReset: $timeOfLastReset, ')
          ..write('imageName: $imageName')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DriftEventsTable driftEvents = $DriftEventsTable(this);
  late final $DriftTimeSlotPatternsTable driftTimeSlotPatterns =
      $DriftTimeSlotPatternsTable(this);
  late final $DriftTimeSlotsTable driftTimeSlots = $DriftTimeSlotsTable(this);
  late final $DriftStaminasTable driftStaminas = $DriftStaminasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    driftEvents,
    driftTimeSlotPatterns,
    driftTimeSlots,
    driftStaminas,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'drift_events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('drift_time_slot_patterns', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'drift_time_slot_patterns',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('drift_time_slots', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'drift_events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('drift_time_slots', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$DriftEventsTableCreateCompanionBuilder =
    DriftEventsCompanion Function({
      Value<int> id,
      required String eventName,
      Value<String?> location,
    });
typedef $$DriftEventsTableUpdateCompanionBuilder =
    DriftEventsCompanion Function({
      Value<int> id,
      Value<String> eventName,
      Value<String?> location,
    });

final class $$DriftEventsTableReferences
    extends BaseReferences<_$AppDatabase, $DriftEventsTable, DriftEvent> {
  $$DriftEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $DriftTimeSlotPatternsTable,
    List<DriftTimeSlotPattern>
  >
  _driftTimeSlotPatternsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.driftTimeSlotPatterns,
        aliasName: $_aliasNameGenerator(
          db.driftEvents.id,
          db.driftTimeSlotPatterns.eventId,
        ),
      );

  $$DriftTimeSlotPatternsTableProcessedTableManager
  get driftTimeSlotPatternsRefs {
    final manager = $$DriftTimeSlotPatternsTableTableManager(
      $_db,
      $_db.driftTimeSlotPatterns,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _driftTimeSlotPatternsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DriftTimeSlotsTable, List<DriftTimeSlot>>
  _driftTimeSlotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.driftTimeSlots,
    aliasName: $_aliasNameGenerator(
      db.driftEvents.id,
      db.driftTimeSlots.eventId,
    ),
  );

  $$DriftTimeSlotsTableProcessedTableManager get driftTimeSlotsRefs {
    final manager = $$DriftTimeSlotsTableTableManager(
      $_db,
      $_db.driftTimeSlots,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_driftTimeSlotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
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

  Expression<bool> driftTimeSlotPatternsRefs(
    Expression<bool> Function($$DriftTimeSlotPatternsTableFilterComposer f) f,
  ) {
    final $$DriftTimeSlotPatternsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.driftTimeSlotPatterns,
          getReferencedColumn: (t) => t.eventId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DriftTimeSlotPatternsTableFilterComposer(
                $db: $db,
                $table: $db.driftTimeSlotPatterns,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> driftTimeSlotsRefs(
    Expression<bool> Function($$DriftTimeSlotsTableFilterComposer f) f,
  ) {
    final $$DriftTimeSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.eventId,
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
    return f(composer);
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

  Expression<T> driftTimeSlotPatternsRefs<T extends Object>(
    Expression<T> Function($$DriftTimeSlotPatternsTableAnnotationComposer a) f,
  ) {
    final $$DriftTimeSlotPatternsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.driftTimeSlotPatterns,
          getReferencedColumn: (t) => t.eventId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DriftTimeSlotPatternsTableAnnotationComposer(
                $db: $db,
                $table: $db.driftTimeSlotPatterns,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> driftTimeSlotsRefs<T extends Object>(
    Expression<T> Function($$DriftTimeSlotsTableAnnotationComposer a) f,
  ) {
    final $$DriftTimeSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.eventId,
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
    return f(composer);
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
          PrefetchHooks Function({
            bool driftTimeSlotPatternsRefs,
            bool driftTimeSlotsRefs,
          })
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
              }) => DriftEventsCompanion(
                id: id,
                eventName: eventName,
                location: location,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String eventName,
                Value<String?> location = const Value.absent(),
              }) => DriftEventsCompanion.insert(
                id: id,
                eventName: eventName,
                location: location,
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
          prefetchHooksCallback: ({
            driftTimeSlotPatternsRefs = false,
            driftTimeSlotsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (driftTimeSlotPatternsRefs) db.driftTimeSlotPatterns,
                if (driftTimeSlotsRefs) db.driftTimeSlots,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (driftTimeSlotPatternsRefs)
                    await $_getPrefetchedData<
                      DriftEvent,
                      $DriftEventsTable,
                      DriftTimeSlotPattern
                    >(
                      currentTable: table,
                      referencedTable: $$DriftEventsTableReferences
                          ._driftTimeSlotPatternsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$DriftEventsTableReferences(
                                db,
                                table,
                                p0,
                              ).driftTimeSlotPatternsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.eventId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (driftTimeSlotsRefs)
                    await $_getPrefetchedData<
                      DriftEvent,
                      $DriftEventsTable,
                      DriftTimeSlot
                    >(
                      currentTable: table,
                      referencedTable: $$DriftEventsTableReferences
                          ._driftTimeSlotsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$DriftEventsTableReferences(
                                db,
                                table,
                                p0,
                              ).driftTimeSlotsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.eventId == item.id,
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
      PrefetchHooks Function({
        bool driftTimeSlotPatternsRefs,
        bool driftTimeSlotsRefs,
      })
    >;
typedef $$DriftTimeSlotPatternsTableCreateCompanionBuilder =
    DriftTimeSlotPatternsCompanion Function({
      Value<int> id,
      required int eventId,
      Value<String?> anchorPoints,
      Value<int?> frequencyInSeconds,
      Value<DateTime?> endDate,
      Value<String?> timeZoneId,
      Value<String?> rrule,
    });
typedef $$DriftTimeSlotPatternsTableUpdateCompanionBuilder =
    DriftTimeSlotPatternsCompanion Function({
      Value<int> id,
      Value<int> eventId,
      Value<String?> anchorPoints,
      Value<int?> frequencyInSeconds,
      Value<DateTime?> endDate,
      Value<String?> timeZoneId,
      Value<String?> rrule,
    });

final class $$DriftTimeSlotPatternsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DriftTimeSlotPatternsTable,
          DriftTimeSlotPattern
        > {
  $$DriftTimeSlotPatternsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DriftEventsTable _eventIdTable(_$AppDatabase db) =>
      db.driftEvents.createAlias(
        $_aliasNameGenerator(
          db.driftTimeSlotPatterns.eventId,
          db.driftEvents.id,
        ),
      );

  $$DriftEventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$DriftEventsTableTableManager(
      $_db,
      $_db.driftEvents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DriftTimeSlotsTable, List<DriftTimeSlot>>
  _driftTimeSlotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.driftTimeSlots,
    aliasName: $_aliasNameGenerator(
      db.driftTimeSlotPatterns.id,
      db.driftTimeSlots.patternId,
    ),
  );

  $$DriftTimeSlotsTableProcessedTableManager get driftTimeSlotsRefs {
    final manager = $$DriftTimeSlotsTableTableManager(
      $_db,
      $_db.driftTimeSlots,
    ).filter((f) => f.patternId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_driftTimeSlotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DriftTimeSlotPatternsTableFilterComposer
    extends Composer<_$AppDatabase, $DriftTimeSlotPatternsTable> {
  $$DriftTimeSlotPatternsTableFilterComposer({
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

  ColumnFilters<String> get anchorPoints => $composableBuilder(
    column: $table.anchorPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get frequencyInSeconds => $composableBuilder(
    column: $table.frequencyInSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeZoneId => $composableBuilder(
    column: $table.timeZoneId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rrule => $composableBuilder(
    column: $table.rrule,
    builder: (column) => ColumnFilters(column),
  );

  $$DriftEventsTableFilterComposer get eventId {
    final $$DriftEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.driftEvents,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  Expression<bool> driftTimeSlotsRefs(
    Expression<bool> Function($$DriftTimeSlotsTableFilterComposer f) f,
  ) {
    final $$DriftTimeSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.patternId,
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
    return f(composer);
  }
}

class $$DriftTimeSlotPatternsTableOrderingComposer
    extends Composer<_$AppDatabase, $DriftTimeSlotPatternsTable> {
  $$DriftTimeSlotPatternsTableOrderingComposer({
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

  ColumnOrderings<String> get anchorPoints => $composableBuilder(
    column: $table.anchorPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get frequencyInSeconds => $composableBuilder(
    column: $table.frequencyInSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeZoneId => $composableBuilder(
    column: $table.timeZoneId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rrule => $composableBuilder(
    column: $table.rrule,
    builder: (column) => ColumnOrderings(column),
  );

  $$DriftEventsTableOrderingComposer get eventId {
    final $$DriftEventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.driftEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DriftEventsTableOrderingComposer(
            $db: $db,
            $table: $db.driftEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DriftTimeSlotPatternsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DriftTimeSlotPatternsTable> {
  $$DriftTimeSlotPatternsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get anchorPoints => $composableBuilder(
    column: $table.anchorPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get frequencyInSeconds => $composableBuilder(
    column: $table.frequencyInSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get timeZoneId => $composableBuilder(
    column: $table.timeZoneId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rrule =>
      $composableBuilder(column: $table.rrule, builder: (column) => column);

  $$DriftEventsTableAnnotationComposer get eventId {
    final $$DriftEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.driftEvents,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  Expression<T> driftTimeSlotsRefs<T extends Object>(
    Expression<T> Function($$DriftTimeSlotsTableAnnotationComposer a) f,
  ) {
    final $$DriftTimeSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.patternId,
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
    return f(composer);
  }
}

class $$DriftTimeSlotPatternsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DriftTimeSlotPatternsTable,
          DriftTimeSlotPattern,
          $$DriftTimeSlotPatternsTableFilterComposer,
          $$DriftTimeSlotPatternsTableOrderingComposer,
          $$DriftTimeSlotPatternsTableAnnotationComposer,
          $$DriftTimeSlotPatternsTableCreateCompanionBuilder,
          $$DriftTimeSlotPatternsTableUpdateCompanionBuilder,
          (DriftTimeSlotPattern, $$DriftTimeSlotPatternsTableReferences),
          DriftTimeSlotPattern,
          PrefetchHooks Function({bool eventId, bool driftTimeSlotsRefs})
        > {
  $$DriftTimeSlotPatternsTableTableManager(
    _$AppDatabase db,
    $DriftTimeSlotPatternsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DriftTimeSlotPatternsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$DriftTimeSlotPatternsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$DriftTimeSlotPatternsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eventId = const Value.absent(),
                Value<String?> anchorPoints = const Value.absent(),
                Value<int?> frequencyInSeconds = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> timeZoneId = const Value.absent(),
                Value<String?> rrule = const Value.absent(),
              }) => DriftTimeSlotPatternsCompanion(
                id: id,
                eventId: eventId,
                anchorPoints: anchorPoints,
                frequencyInSeconds: frequencyInSeconds,
                endDate: endDate,
                timeZoneId: timeZoneId,
                rrule: rrule,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eventId,
                Value<String?> anchorPoints = const Value.absent(),
                Value<int?> frequencyInSeconds = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> timeZoneId = const Value.absent(),
                Value<String?> rrule = const Value.absent(),
              }) => DriftTimeSlotPatternsCompanion.insert(
                id: id,
                eventId: eventId,
                anchorPoints: anchorPoints,
                frequencyInSeconds: frequencyInSeconds,
                endDate: endDate,
                timeZoneId: timeZoneId,
                rrule: rrule,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$DriftTimeSlotPatternsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            eventId = false,
            driftTimeSlotsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (driftTimeSlotsRefs) db.driftTimeSlots,
              ],
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
                if (eventId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.eventId,
                            referencedTable:
                                $$DriftTimeSlotPatternsTableReferences
                                    ._eventIdTable(db),
                            referencedColumn:
                                $$DriftTimeSlotPatternsTableReferences
                                    ._eventIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (driftTimeSlotsRefs)
                    await $_getPrefetchedData<
                      DriftTimeSlotPattern,
                      $DriftTimeSlotPatternsTable,
                      DriftTimeSlot
                    >(
                      currentTable: table,
                      referencedTable: $$DriftTimeSlotPatternsTableReferences
                          ._driftTimeSlotsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$DriftTimeSlotPatternsTableReferences(
                                db,
                                table,
                                p0,
                              ).driftTimeSlotsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.patternId == item.id,
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

typedef $$DriftTimeSlotPatternsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DriftTimeSlotPatternsTable,
      DriftTimeSlotPattern,
      $$DriftTimeSlotPatternsTableFilterComposer,
      $$DriftTimeSlotPatternsTableOrderingComposer,
      $$DriftTimeSlotPatternsTableAnnotationComposer,
      $$DriftTimeSlotPatternsTableCreateCompanionBuilder,
      $$DriftTimeSlotPatternsTableUpdateCompanionBuilder,
      (DriftTimeSlotPattern, $$DriftTimeSlotPatternsTableReferences),
      DriftTimeSlotPattern,
      PrefetchHooks Function({bool eventId, bool driftTimeSlotsRefs})
    >;
typedef $$DriftTimeSlotsTableCreateCompanionBuilder =
    DriftTimeSlotsCompanion Function({
      Value<int> id,
      required int patternId,
      required int eventId,
      required DateTime date,
      Value<DateTime?> startTime,
      Value<DateTime?> endTime,
    });
typedef $$DriftTimeSlotsTableUpdateCompanionBuilder =
    DriftTimeSlotsCompanion Function({
      Value<int> id,
      Value<int> patternId,
      Value<int> eventId,
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

  static $DriftTimeSlotPatternsTable _patternIdTable(_$AppDatabase db) =>
      db.driftTimeSlotPatterns.createAlias(
        $_aliasNameGenerator(
          db.driftTimeSlots.patternId,
          db.driftTimeSlotPatterns.id,
        ),
      );

  $$DriftTimeSlotPatternsTableProcessedTableManager get patternId {
    final $_column = $_itemColumn<int>('pattern_id')!;

    final manager = $$DriftTimeSlotPatternsTableTableManager(
      $_db,
      $_db.driftTimeSlotPatterns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patternIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DriftEventsTable _eventIdTable(_$AppDatabase db) =>
      db.driftEvents.createAlias(
        $_aliasNameGenerator(db.driftTimeSlots.eventId, db.driftEvents.id),
      );

  $$DriftEventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$DriftEventsTableTableManager(
      $_db,
      $_db.driftEvents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
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

  $$DriftTimeSlotPatternsTableFilterComposer get patternId {
    final $$DriftTimeSlotPatternsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.patternId,
          referencedTable: $db.driftTimeSlotPatterns,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DriftTimeSlotPatternsTableFilterComposer(
                $db: $db,
                $table: $db.driftTimeSlotPatterns,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$DriftEventsTableFilterComposer get eventId {
    final $$DriftEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.driftEvents,
      getReferencedColumn: (t) => t.id,
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
    return composer;
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

  $$DriftTimeSlotPatternsTableOrderingComposer get patternId {
    final $$DriftTimeSlotPatternsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.patternId,
          referencedTable: $db.driftTimeSlotPatterns,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DriftTimeSlotPatternsTableOrderingComposer(
                $db: $db,
                $table: $db.driftTimeSlotPatterns,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$DriftEventsTableOrderingComposer get eventId {
    final $$DriftEventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.driftEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DriftEventsTableOrderingComposer(
            $db: $db,
            $table: $db.driftEvents,
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

  $$DriftTimeSlotPatternsTableAnnotationComposer get patternId {
    final $$DriftTimeSlotPatternsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.patternId,
          referencedTable: $db.driftTimeSlotPatterns,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DriftTimeSlotPatternsTableAnnotationComposer(
                $db: $db,
                $table: $db.driftTimeSlotPatterns,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$DriftEventsTableAnnotationComposer get eventId {
    final $$DriftEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.driftEvents,
      getReferencedColumn: (t) => t.id,
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
    return composer;
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
          PrefetchHooks Function({bool patternId, bool eventId})
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
                Value<int> patternId = const Value.absent(),
                Value<int> eventId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
              }) => DriftTimeSlotsCompanion(
                id: id,
                patternId: patternId,
                eventId: eventId,
                date: date,
                startTime: startTime,
                endTime: endTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int patternId,
                required int eventId,
                required DateTime date,
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
              }) => DriftTimeSlotsCompanion.insert(
                id: id,
                patternId: patternId,
                eventId: eventId,
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
          prefetchHooksCallback: ({patternId = false, eventId = false}) {
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
                if (patternId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.patternId,
                            referencedTable: $$DriftTimeSlotsTableReferences
                                ._patternIdTable(db),
                            referencedColumn:
                                $$DriftTimeSlotsTableReferences
                                    ._patternIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (eventId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.eventId,
                            referencedTable: $$DriftTimeSlotsTableReferences
                                ._eventIdTable(db),
                            referencedColumn:
                                $$DriftTimeSlotsTableReferences
                                    ._eventIdTable(db)
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
      PrefetchHooks Function({bool patternId, bool eventId})
    >;
typedef $$DriftStaminasTableCreateCompanionBuilder =
    DriftStaminasCompanion Function({
      Value<int> id,
      required String gachaName,
      required int maxStamina,
      required int rechargeTimeInSeconds,
      required int staminaOfLatestReset,
      required DateTime timeOfLastReset,
      Value<String?> imageName,
    });
typedef $$DriftStaminasTableUpdateCompanionBuilder =
    DriftStaminasCompanion Function({
      Value<int> id,
      Value<String> gachaName,
      Value<int> maxStamina,
      Value<int> rechargeTimeInSeconds,
      Value<int> staminaOfLatestReset,
      Value<DateTime> timeOfLastReset,
      Value<String?> imageName,
    });

class $$DriftStaminasTableFilterComposer
    extends Composer<_$AppDatabase, $DriftStaminasTable> {
  $$DriftStaminasTableFilterComposer({
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

  ColumnFilters<String> get gachaName => $composableBuilder(
    column: $table.gachaName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxStamina => $composableBuilder(
    column: $table.maxStamina,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rechargeTimeInSeconds => $composableBuilder(
    column: $table.rechargeTimeInSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get staminaOfLatestReset => $composableBuilder(
    column: $table.staminaOfLatestReset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timeOfLastReset => $composableBuilder(
    column: $table.timeOfLastReset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageName => $composableBuilder(
    column: $table.imageName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DriftStaminasTableOrderingComposer
    extends Composer<_$AppDatabase, $DriftStaminasTable> {
  $$DriftStaminasTableOrderingComposer({
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

  ColumnOrderings<String> get gachaName => $composableBuilder(
    column: $table.gachaName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxStamina => $composableBuilder(
    column: $table.maxStamina,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rechargeTimeInSeconds => $composableBuilder(
    column: $table.rechargeTimeInSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get staminaOfLatestReset => $composableBuilder(
    column: $table.staminaOfLatestReset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timeOfLastReset => $composableBuilder(
    column: $table.timeOfLastReset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageName => $composableBuilder(
    column: $table.imageName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DriftStaminasTableAnnotationComposer
    extends Composer<_$AppDatabase, $DriftStaminasTable> {
  $$DriftStaminasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gachaName =>
      $composableBuilder(column: $table.gachaName, builder: (column) => column);

  GeneratedColumn<int> get maxStamina => $composableBuilder(
    column: $table.maxStamina,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rechargeTimeInSeconds => $composableBuilder(
    column: $table.rechargeTimeInSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get staminaOfLatestReset => $composableBuilder(
    column: $table.staminaOfLatestReset,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timeOfLastReset => $composableBuilder(
    column: $table.timeOfLastReset,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageName =>
      $composableBuilder(column: $table.imageName, builder: (column) => column);
}

class $$DriftStaminasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DriftStaminasTable,
          DriftStamina,
          $$DriftStaminasTableFilterComposer,
          $$DriftStaminasTableOrderingComposer,
          $$DriftStaminasTableAnnotationComposer,
          $$DriftStaminasTableCreateCompanionBuilder,
          $$DriftStaminasTableUpdateCompanionBuilder,
          (
            DriftStamina,
            BaseReferences<_$AppDatabase, $DriftStaminasTable, DriftStamina>,
          ),
          DriftStamina,
          PrefetchHooks Function()
        > {
  $$DriftStaminasTableTableManager(_$AppDatabase db, $DriftStaminasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DriftStaminasTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$DriftStaminasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$DriftStaminasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> gachaName = const Value.absent(),
                Value<int> maxStamina = const Value.absent(),
                Value<int> rechargeTimeInSeconds = const Value.absent(),
                Value<int> staminaOfLatestReset = const Value.absent(),
                Value<DateTime> timeOfLastReset = const Value.absent(),
                Value<String?> imageName = const Value.absent(),
              }) => DriftStaminasCompanion(
                id: id,
                gachaName: gachaName,
                maxStamina: maxStamina,
                rechargeTimeInSeconds: rechargeTimeInSeconds,
                staminaOfLatestReset: staminaOfLatestReset,
                timeOfLastReset: timeOfLastReset,
                imageName: imageName,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String gachaName,
                required int maxStamina,
                required int rechargeTimeInSeconds,
                required int staminaOfLatestReset,
                required DateTime timeOfLastReset,
                Value<String?> imageName = const Value.absent(),
              }) => DriftStaminasCompanion.insert(
                id: id,
                gachaName: gachaName,
                maxStamina: maxStamina,
                rechargeTimeInSeconds: rechargeTimeInSeconds,
                staminaOfLatestReset: staminaOfLatestReset,
                timeOfLastReset: timeOfLastReset,
                imageName: imageName,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DriftStaminasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DriftStaminasTable,
      DriftStamina,
      $$DriftStaminasTableFilterComposer,
      $$DriftStaminasTableOrderingComposer,
      $$DriftStaminasTableAnnotationComposer,
      $$DriftStaminasTableCreateCompanionBuilder,
      $$DriftStaminasTableUpdateCompanionBuilder,
      (
        DriftStamina,
        BaseReferences<_$AppDatabase, $DriftStaminasTable, DriftStamina>,
      ),
      DriftStamina,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DriftEventsTableTableManager get driftEvents =>
      $$DriftEventsTableTableManager(_db, _db.driftEvents);
  $$DriftTimeSlotPatternsTableTableManager get driftTimeSlotPatterns =>
      $$DriftTimeSlotPatternsTableTableManager(_db, _db.driftTimeSlotPatterns);
  $$DriftTimeSlotsTableTableManager get driftTimeSlots =>
      $$DriftTimeSlotsTableTableManager(_db, _db.driftTimeSlots);
  $$DriftStaminasTableTableManager get driftStaminas =>
      $$DriftStaminasTableTableManager(_db, _db.driftStaminas);
}

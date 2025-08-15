// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data/database/drift/drift_database.dart';

// ignore_for_file: type=lint
class $DriftTimeSlotsTable extends DriftTimeSlots with TableInfo<$DriftTimeSlotsTable, DriftTimeSlot> {
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
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _nextTimeSlotIdMeta = const VerificationMeta('nextTimeSlotId');
  @override
  late final GeneratedColumn<int> nextTimeSlotId = GeneratedColumn<int>(
    'next_time_slot_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES drift_time_slots (id) ON DELETE CASCADE'),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>('date', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta = const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nextTimeSlotId, date, startTime, endTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_time_slots';
  @override
  VerificationContext validateIntegrity(Insertable<DriftTimeSlot> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('next_time_slot_id')) {
      context.handle(_nextTimeSlotIdMeta, nextTimeSlotId.isAcceptableOrUnknown(data['next_time_slot_id']!, _nextTimeSlotIdMeta));
    }
    if (data.containsKey('date')) {
      context.handle(_dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta, startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta, endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftTimeSlot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftTimeSlot(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nextTimeSlotId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}next_time_slot_id']),
      date: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      startTime: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}start_time']),
      endTime: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
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
  const DriftTimeSlot({required this.id, this.nextTimeSlotId, required this.date, this.startTime, this.endTime});
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
      nextTimeSlotId: nextTimeSlotId == null && nullToAbsent ? const Value.absent() : Value(nextTimeSlotId),
      date: Value(date),
      startTime: startTime == null && nullToAbsent ? const Value.absent() : Value(startTime),
      endTime: endTime == null && nullToAbsent ? const Value.absent() : Value(endTime),
    );
  }

  factory DriftTimeSlot.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
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
    nextTimeSlotId: nextTimeSlotId.present ? nextTimeSlotId.value : this.nextTimeSlotId,
    date: date ?? this.date,
    startTime: startTime.present ? startTime.value : this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
  );
  DriftTimeSlot copyWithCompanion(DriftTimeSlotsCompanion data) {
    return DriftTimeSlot(
      id: data.id.present ? data.id.value : this.id,
      nextTimeSlotId: data.nextTimeSlotId.present ? data.nextTimeSlotId.value : this.nextTimeSlotId,
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

class $DriftEventsTable extends DriftEvents with TableInfo<$DriftEventsTable, DriftEvent> {
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
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _eventNameMeta = const VerificationMeta('eventName');
  @override
  late final GeneratedColumn<String> eventName = GeneratedColumn<String>(
    'event_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>('location', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeSlotIdMeta = const VerificationMeta('timeSlotId');
  @override
  late final GeneratedColumn<int> timeSlotId = GeneratedColumn<int>(
    'time_slot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES drift_time_slots (id) ON DELETE CASCADE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, eventName, location, timeSlotId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_events';
  @override
  VerificationContext validateIntegrity(Insertable<DriftEvent> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_name')) {
      context.handle(_eventNameMeta, eventName.isAcceptableOrUnknown(data['event_name']!, _eventNameMeta));
    } else if (isInserting) {
      context.missing(_eventNameMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta, location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    if (data.containsKey('time_slot_id')) {
      context.handle(_timeSlotIdMeta, timeSlotId.isAcceptableOrUnknown(data['time_slot_id']!, _timeSlotIdMeta));
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
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      eventName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}event_name'])!,
      location: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}location']),
      timeSlotId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}time_slot_id'])!,
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
  const DriftEvent({required this.id, required this.eventName, this.location, required this.timeSlotId});
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
      location: location == null && nullToAbsent ? const Value.absent() : Value(location),
      timeSlotId: Value(timeSlotId),
    );
  }

  factory DriftEvent.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
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

  DriftEvent copyWith({int? id, String? eventName, Value<String?> location = const Value.absent(), int? timeSlotId}) => DriftEvent(
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
      timeSlotId: data.timeSlotId.present ? data.timeSlotId.value : this.timeSlotId,
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
  DriftEventsCompanion.insert({this.id = const Value.absent(), required String eventName, this.location = const Value.absent(), required int timeSlotId})
    : eventName = Value(eventName),
      timeSlotId = Value(timeSlotId);
  static Insertable<DriftEvent> custom({Expression<int>? id, Expression<String>? eventName, Expression<String>? location, Expression<int>? timeSlotId}) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventName != null) 'event_name': eventName,
      if (location != null) 'location': location,
      if (timeSlotId != null) 'time_slot_id': timeSlotId,
    });
  }

  DriftEventsCompanion copyWith({Value<int>? id, Value<String>? eventName, Value<String?>? location, Value<int>? timeSlotId}) {
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

class $DriftStaminasTable extends DriftStaminas with TableInfo<$DriftStaminasTable, DriftStamina> {
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
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _gachaNameMeta = const VerificationMeta('gachaName');
  @override
  late final GeneratedColumn<String> gachaName = GeneratedColumn<String>(
    'gacha_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxStaminaMeta = const VerificationMeta('maxStamina');
  @override
  late final GeneratedColumn<int> maxStamina = GeneratedColumn<int>('max_stamina', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _rechargeTimeInSecondsMeta = const VerificationMeta('rechargeTimeInSeconds');
  @override
  late final GeneratedColumn<int> rechargeTimeInSeconds = GeneratedColumn<int>(
    'recharge_time_in_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _staminaOfLatestResetMeta = const VerificationMeta('staminaOfLatestReset');
  @override
  late final GeneratedColumn<int> staminaOfLatestReset = GeneratedColumn<int>(
    'stamina_of_latest_reset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeOfLastResetMeta = const VerificationMeta('timeOfLastReset');
  @override
  late final GeneratedColumn<DateTime> timeOfLastReset = GeneratedColumn<DateTime>(
    'time_of_last_reset',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageNameMeta = const VerificationMeta('imageName');
  @override
  late final GeneratedColumn<String> imageName = GeneratedColumn<String>(
    'image_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, gachaName, maxStamina, rechargeTimeInSeconds, staminaOfLatestReset, timeOfLastReset, imageName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_staminas';
  @override
  VerificationContext validateIntegrity(Insertable<DriftStamina> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gacha_name')) {
      context.handle(_gachaNameMeta, gachaName.isAcceptableOrUnknown(data['gacha_name']!, _gachaNameMeta));
    } else if (isInserting) {
      context.missing(_gachaNameMeta);
    }
    if (data.containsKey('max_stamina')) {
      context.handle(_maxStaminaMeta, maxStamina.isAcceptableOrUnknown(data['max_stamina']!, _maxStaminaMeta));
    } else if (isInserting) {
      context.missing(_maxStaminaMeta);
    }
    if (data.containsKey('recharge_time_in_seconds')) {
      context.handle(_rechargeTimeInSecondsMeta, rechargeTimeInSeconds.isAcceptableOrUnknown(data['recharge_time_in_seconds']!, _rechargeTimeInSecondsMeta));
    } else if (isInserting) {
      context.missing(_rechargeTimeInSecondsMeta);
    }
    if (data.containsKey('stamina_of_latest_reset')) {
      context.handle(_staminaOfLatestResetMeta, staminaOfLatestReset.isAcceptableOrUnknown(data['stamina_of_latest_reset']!, _staminaOfLatestResetMeta));
    } else if (isInserting) {
      context.missing(_staminaOfLatestResetMeta);
    }
    if (data.containsKey('time_of_last_reset')) {
      context.handle(_timeOfLastResetMeta, timeOfLastReset.isAcceptableOrUnknown(data['time_of_last_reset']!, _timeOfLastResetMeta));
    } else if (isInserting) {
      context.missing(_timeOfLastResetMeta);
    }
    if (data.containsKey('image_name')) {
      context.handle(_imageNameMeta, imageName.isAcceptableOrUnknown(data['image_name']!, _imageNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftStamina map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftStamina(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      gachaName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}gacha_name'])!,
      maxStamina: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}max_stamina'])!,
      rechargeTimeInSeconds: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}recharge_time_in_seconds'])!,
      staminaOfLatestReset: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}stamina_of_latest_reset'])!,
      timeOfLastReset: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}time_of_last_reset'])!,
      imageName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}image_name']),
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
      imageName: imageName == null && nullToAbsent ? const Value.absent() : Value(imageName),
    );
  }

  factory DriftStamina.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftStamina(
      id: serializer.fromJson<int>(json['id']),
      gachaName: serializer.fromJson<String>(json['gachaName']),
      maxStamina: serializer.fromJson<int>(json['maxStamina']),
      rechargeTimeInSeconds: serializer.fromJson<int>(json['rechargeTimeInSeconds']),
      staminaOfLatestReset: serializer.fromJson<int>(json['staminaOfLatestReset']),
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
      maxStamina: data.maxStamina.present ? data.maxStamina.value : this.maxStamina,
      rechargeTimeInSeconds: data.rechargeTimeInSeconds.present ? data.rechargeTimeInSeconds.value : this.rechargeTimeInSeconds,
      staminaOfLatestReset: data.staminaOfLatestReset.present ? data.staminaOfLatestReset.value : this.staminaOfLatestReset,
      timeOfLastReset: data.timeOfLastReset.present ? data.timeOfLastReset.value : this.timeOfLastReset,
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
  int get hashCode => Object.hash(id, gachaName, maxStamina, rechargeTimeInSeconds, staminaOfLatestReset, timeOfLastReset, imageName);
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
      if (rechargeTimeInSeconds != null) 'recharge_time_in_seconds': rechargeTimeInSeconds,
      if (staminaOfLatestReset != null) 'stamina_of_latest_reset': staminaOfLatestReset,
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
      rechargeTimeInSeconds: rechargeTimeInSeconds ?? this.rechargeTimeInSeconds,
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
      map['recharge_time_in_seconds'] = Variable<int>(rechargeTimeInSeconds.value);
    }
    if (staminaOfLatestReset.present) {
      map['stamina_of_latest_reset'] = Variable<int>(staminaOfLatestReset.value);
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
  late final $DriftTimeSlotsTable driftTimeSlots = $DriftTimeSlotsTable(this);
  late final $DriftEventsTable driftEvents = $DriftEventsTable(this);
  late final $DriftStaminasTable driftStaminas = $DriftStaminasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [driftTimeSlots, driftEvents, driftStaminas];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName('drift_time_slots', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('drift_time_slots', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('drift_time_slots', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('drift_events', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$DriftTimeSlotsTableCreateCompanionBuilder =
    DriftTimeSlotsCompanion Function({Value<int> id, Value<int?> nextTimeSlotId, required DateTime date, Value<DateTime?> startTime, Value<DateTime?> endTime});
typedef $$DriftTimeSlotsTableUpdateCompanionBuilder =
    DriftTimeSlotsCompanion Function({Value<int> id, Value<int?> nextTimeSlotId, Value<DateTime> date, Value<DateTime?> startTime, Value<DateTime?> endTime});

final class $$DriftTimeSlotsTableReferences extends BaseReferences<_$AppDatabase, $DriftTimeSlotsTable, DriftTimeSlot> {
  $$DriftTimeSlotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DriftTimeSlotsTable _nextTimeSlotIdTable(_$AppDatabase db) =>
      db.driftTimeSlots.createAlias($_aliasNameGenerator(db.driftTimeSlots.nextTimeSlotId, db.driftTimeSlots.id));

  $$DriftTimeSlotsTableProcessedTableManager? get nextTimeSlotId {
    final $_column = $_itemColumn<int>('next_time_slot_id');
    if ($_column == null) return null;
    final manager = $$DriftTimeSlotsTableTableManager($_db, $_db.driftTimeSlots).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_nextTimeSlotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$DriftEventsTable, List<DriftEvent>> _driftEventsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.driftEvents, aliasName: $_aliasNameGenerator(db.driftTimeSlots.id, db.driftEvents.timeSlotId));

  $$DriftEventsTableProcessedTableManager get driftEventsRefs {
    final manager = $$DriftEventsTableTableManager($_db, $_db.driftEvents).filter((f) => f.timeSlotId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_driftEventsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DriftTimeSlotsTableFilterComposer extends Composer<_$AppDatabase, $DriftTimeSlotsTable> {
  $$DriftTimeSlotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(column: $table.endTime, builder: (column) => ColumnFilters(column));

  $$DriftTimeSlotsTableFilterComposer get nextTimeSlotId {
    final $$DriftTimeSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nextTimeSlotId,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$DriftTimeSlotsTableFilterComposer(
            $db: $db,
            $table: $db.driftTimeSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> driftEventsRefs(Expression<bool> Function($$DriftEventsTableFilterComposer f) f) {
    final $$DriftEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.driftEvents,
      getReferencedColumn: (t) => t.timeSlotId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$DriftEventsTableFilterComposer(
            $db: $db,
            $table: $db.driftEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DriftTimeSlotsTableOrderingComposer extends Composer<_$AppDatabase, $DriftTimeSlotsTable> {
  $$DriftTimeSlotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(column: $table.endTime, builder: (column) => ColumnOrderings(column));

  $$DriftTimeSlotsTableOrderingComposer get nextTimeSlotId {
    final $$DriftTimeSlotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nextTimeSlotId,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$DriftTimeSlotsTableOrderingComposer(
            $db: $db,
            $table: $db.driftTimeSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DriftTimeSlotsTableAnnotationComposer extends Composer<_$AppDatabase, $DriftTimeSlotsTable> {
  $$DriftTimeSlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date => $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime => $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime => $composableBuilder(column: $table.endTime, builder: (column) => column);

  $$DriftTimeSlotsTableAnnotationComposer get nextTimeSlotId {
    final $$DriftTimeSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nextTimeSlotId,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$DriftTimeSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.driftTimeSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> driftEventsRefs<T extends Object>(Expression<T> Function($$DriftEventsTableAnnotationComposer a) f) {
    final $$DriftEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.driftEvents,
      getReferencedColumn: (t) => t.timeSlotId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$DriftEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.driftEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
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
  $$DriftTimeSlotsTableTableManager(_$AppDatabase db, $DriftTimeSlotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$DriftTimeSlotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$DriftTimeSlotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$DriftTimeSlotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> nextTimeSlotId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
              }) => DriftTimeSlotsCompanion(id: id, nextTimeSlotId: nextTimeSlotId, date: date, startTime: startTime, endTime: endTime),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> nextTimeSlotId = const Value.absent(),
                required DateTime date,
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
              }) => DriftTimeSlotsCompanion.insert(id: id, nextTimeSlotId: nextTimeSlotId, date: date, startTime: startTime, endTime: endTime),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), $$DriftTimeSlotsTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: ({nextTimeSlotId = false, driftEventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (driftEventsRefs) db.driftEvents],
              addJoins: <T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic>>(
                state,
              ) {
                if (nextTimeSlotId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.nextTimeSlotId,
                            referencedTable: $$DriftTimeSlotsTableReferences._nextTimeSlotIdTable(db),
                            referencedColumn: $$DriftTimeSlotsTableReferences._nextTimeSlotIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (driftEventsRefs)
                    await $_getPrefetchedData<DriftTimeSlot, $DriftTimeSlotsTable, DriftEvent>(
                      currentTable: table,
                      referencedTable: $$DriftTimeSlotsTableReferences._driftEventsRefsTable(db),
                      managerFromTypedResult: (p0) => $$DriftTimeSlotsTableReferences(db, table, p0).driftEventsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.timeSlotId == item.id),
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
    DriftEventsCompanion Function({Value<int> id, required String eventName, Value<String?> location, required int timeSlotId});
typedef $$DriftEventsTableUpdateCompanionBuilder =
    DriftEventsCompanion Function({Value<int> id, Value<String> eventName, Value<String?> location, Value<int> timeSlotId});

final class $$DriftEventsTableReferences extends BaseReferences<_$AppDatabase, $DriftEventsTable, DriftEvent> {
  $$DriftEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DriftTimeSlotsTable _timeSlotIdTable(_$AppDatabase db) =>
      db.driftTimeSlots.createAlias($_aliasNameGenerator(db.driftEvents.timeSlotId, db.driftTimeSlots.id));

  $$DriftTimeSlotsTableProcessedTableManager get timeSlotId {
    final $_column = $_itemColumn<int>('time_slot_id')!;

    final manager = $$DriftTimeSlotsTableTableManager($_db, $_db.driftTimeSlots).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_timeSlotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DriftEventsTableFilterComposer extends Composer<_$AppDatabase, $DriftEventsTable> {
  $$DriftEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventName => $composableBuilder(column: $table.eventName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(column: $table.location, builder: (column) => ColumnFilters(column));

  $$DriftTimeSlotsTableFilterComposer get timeSlotId {
    final $$DriftTimeSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeSlotId,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$DriftTimeSlotsTableFilterComposer(
            $db: $db,
            $table: $db.driftTimeSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DriftEventsTableOrderingComposer extends Composer<_$AppDatabase, $DriftEventsTable> {
  $$DriftEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventName => $composableBuilder(column: $table.eventName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(column: $table.location, builder: (column) => ColumnOrderings(column));

  $$DriftTimeSlotsTableOrderingComposer get timeSlotId {
    final $$DriftTimeSlotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeSlotId,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$DriftTimeSlotsTableOrderingComposer(
            $db: $db,
            $table: $db.driftTimeSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DriftEventsTableAnnotationComposer extends Composer<_$AppDatabase, $DriftEventsTable> {
  $$DriftEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventName => $composableBuilder(column: $table.eventName, builder: (column) => column);

  GeneratedColumn<String> get location => $composableBuilder(column: $table.location, builder: (column) => column);

  $$DriftTimeSlotsTableAnnotationComposer get timeSlotId {
    final $$DriftTimeSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeSlotId,
      referencedTable: $db.driftTimeSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$DriftTimeSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.driftTimeSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
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
          createFilteringComposer: () => $$DriftEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$DriftEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$DriftEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> eventName = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<int> timeSlotId = const Value.absent(),
              }) => DriftEventsCompanion(id: id, eventName: eventName, location: location, timeSlotId: timeSlotId),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String eventName, Value<String?> location = const Value.absent(), required int timeSlotId}) =>
                  DriftEventsCompanion.insert(id: id, eventName: eventName, location: location, timeSlotId: timeSlotId),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), $$DriftEventsTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: ({timeSlotId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic>>(
                state,
              ) {
                if (timeSlotId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.timeSlotId,
                            referencedTable: $$DriftEventsTableReferences._timeSlotIdTable(db),
                            referencedColumn: $$DriftEventsTableReferences._timeSlotIdTable(db).id,
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

class $$DriftStaminasTableFilterComposer extends Composer<_$AppDatabase, $DriftStaminasTable> {
  $$DriftStaminasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gachaName => $composableBuilder(column: $table.gachaName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxStamina => $composableBuilder(column: $table.maxStamina, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rechargeTimeInSeconds => $composableBuilder(column: $table.rechargeTimeInSeconds, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get staminaOfLatestReset => $composableBuilder(column: $table.staminaOfLatestReset, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeOfLastReset => $composableBuilder(column: $table.timeOfLastReset, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageName => $composableBuilder(column: $table.imageName, builder: (column) => ColumnFilters(column));
}

class $$DriftStaminasTableOrderingComposer extends Composer<_$AppDatabase, $DriftStaminasTable> {
  $$DriftStaminasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gachaName => $composableBuilder(column: $table.gachaName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxStamina => $composableBuilder(column: $table.maxStamina, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rechargeTimeInSeconds => $composableBuilder(column: $table.rechargeTimeInSeconds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get staminaOfLatestReset => $composableBuilder(column: $table.staminaOfLatestReset, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeOfLastReset => $composableBuilder(column: $table.timeOfLastReset, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageName => $composableBuilder(column: $table.imageName, builder: (column) => ColumnOrderings(column));
}

class $$DriftStaminasTableAnnotationComposer extends Composer<_$AppDatabase, $DriftStaminasTable> {
  $$DriftStaminasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gachaName => $composableBuilder(column: $table.gachaName, builder: (column) => column);

  GeneratedColumn<int> get maxStamina => $composableBuilder(column: $table.maxStamina, builder: (column) => column);

  GeneratedColumn<int> get rechargeTimeInSeconds => $composableBuilder(column: $table.rechargeTimeInSeconds, builder: (column) => column);

  GeneratedColumn<int> get staminaOfLatestReset => $composableBuilder(column: $table.staminaOfLatestReset, builder: (column) => column);

  GeneratedColumn<DateTime> get timeOfLastReset => $composableBuilder(column: $table.timeOfLastReset, builder: (column) => column);

  GeneratedColumn<String> get imageName => $composableBuilder(column: $table.imageName, builder: (column) => column);
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
          (DriftStamina, BaseReferences<_$AppDatabase, $DriftStaminasTable, DriftStamina>),
          DriftStamina,
          PrefetchHooks Function()
        > {
  $$DriftStaminasTableTableManager(_$AppDatabase db, $DriftStaminasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$DriftStaminasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$DriftStaminasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$DriftStaminasTableAnnotationComposer($db: db, $table: table),
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
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
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
      (DriftStamina, BaseReferences<_$AppDatabase, $DriftStaminasTable, DriftStamina>),
      DriftStamina,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DriftTimeSlotsTableTableManager get driftTimeSlots => $$DriftTimeSlotsTableTableManager(_db, _db.driftTimeSlots);
  $$DriftEventsTableTableManager get driftEvents => $$DriftEventsTableTableManager(_db, _db.driftEvents);
  $$DriftStaminasTableTableManager get driftStaminas => $$DriftStaminasTableTableManager(_db, _db.driftStaminas);
}

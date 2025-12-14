// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calendarIdMeta = const VerificationMeta(
    'calendarId',
  );
  @override
  late final GeneratedColumn<String> calendarId = GeneratedColumn<String>(
    'calendar_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _dtStartMeta = const VerificationMeta(
    'dtStart',
  );
  @override
  late final GeneratedColumn<int> dtStart = GeneratedColumn<int>(
    'dt_start',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dtEndMeta = const VerificationMeta('dtEnd');
  @override
  late final GeneratedColumn<int> dtEnd = GeneratedColumn<int>(
    'dt_end',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('CONFIRMED'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<EventType, String> eventType =
      GeneratedColumn<String>(
        'event_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<EventType>($EventsTable.$convertereventType);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastModifiedMeta = const VerificationMeta(
    'lastModified',
  );
  @override
  late final GeneratedColumn<int> lastModified = GeneratedColumn<int>(
    'last_modified',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uid,
    calendarId,
    title,
    description,
    location,
    dtStart,
    dtEnd,
    duration,
    timezone,
    rrule,
    status,
    eventType,
    createdAt,
    lastModified,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<Event> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('calendar_id')) {
      context.handle(
        _calendarIdMeta,
        calendarId.isAcceptableOrUnknown(data['calendar_id']!, _calendarIdMeta),
      );
    } else if (isInserting) {
      context.missing(_calendarIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
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
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('dt_start')) {
      context.handle(
        _dtStartMeta,
        dtStart.isAcceptableOrUnknown(data['dt_start']!, _dtStartMeta),
      );
    } else if (isInserting) {
      context.missing(_dtStartMeta);
    }
    if (data.containsKey('dt_end')) {
      context.handle(
        _dtEndMeta,
        dtEnd.isAcceptableOrUnknown(data['dt_end']!, _dtEndMeta),
      );
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    }
    if (data.containsKey('rrule')) {
      context.handle(
        _rruleMeta,
        rrule.isAcceptableOrUnknown(data['rrule']!, _rruleMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_modified')) {
      context.handle(
        _lastModifiedMeta,
        lastModified.isAcceptableOrUnknown(
          data['last_modified']!,
          _lastModifiedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      calendarId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calendar_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      dtStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dt_start'],
      )!,
      dtEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dt_end'],
      ),
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      ),
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      ),
      rrule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rrule'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      eventType: $EventsTable.$convertereventType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}event_type'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      lastModified: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_modified'],
      )!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }

  static TypeConverter<EventType, String> $convertereventType =
      const EventTypeConverter();
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final String uid;
  final String calendarId;
  final String title;
  final String? description;
  final String? location;
  final int dtStart;
  final int? dtEnd;
  final int? duration;
  final String? timezone;
  final String? rrule;
  final String status;
  final EventType eventType;
  final int createdAt;
  final int lastModified;
  const Event({
    required this.id,
    required this.uid,
    required this.calendarId,
    required this.title,
    this.description,
    this.location,
    required this.dtStart,
    this.dtEnd,
    this.duration,
    this.timezone,
    this.rrule,
    required this.status,
    required this.eventType,
    required this.createdAt,
    required this.lastModified,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uid'] = Variable<String>(uid);
    map['calendar_id'] = Variable<String>(calendarId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['dt_start'] = Variable<int>(dtStart);
    if (!nullToAbsent || dtEnd != null) {
      map['dt_end'] = Variable<int>(dtEnd);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || timezone != null) {
      map['timezone'] = Variable<String>(timezone);
    }
    if (!nullToAbsent || rrule != null) {
      map['rrule'] = Variable<String>(rrule);
    }
    map['status'] = Variable<String>(status);
    {
      map['event_type'] = Variable<String>(
        $EventsTable.$convertereventType.toSql(eventType),
      );
    }
    map['created_at'] = Variable<int>(createdAt);
    map['last_modified'] = Variable<int>(lastModified);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      uid: Value(uid),
      calendarId: Value(calendarId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      dtStart: Value(dtStart),
      dtEnd: dtEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(dtEnd),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      timezone: timezone == null && nullToAbsent
          ? const Value.absent()
          : Value(timezone),
      rrule: rrule == null && nullToAbsent
          ? const Value.absent()
          : Value(rrule),
      status: Value(status),
      eventType: Value(eventType),
      createdAt: Value(createdAt),
      lastModified: Value(lastModified),
    );
  }

  factory Event.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      calendarId: serializer.fromJson<String>(json['calendarId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      location: serializer.fromJson<String?>(json['location']),
      dtStart: serializer.fromJson<int>(json['dtStart']),
      dtEnd: serializer.fromJson<int?>(json['dtEnd']),
      duration: serializer.fromJson<int?>(json['duration']),
      timezone: serializer.fromJson<String?>(json['timezone']),
      rrule: serializer.fromJson<String?>(json['rrule']),
      status: serializer.fromJson<String>(json['status']),
      eventType: serializer.fromJson<EventType>(json['eventType']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      lastModified: serializer.fromJson<int>(json['lastModified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uid': serializer.toJson<String>(uid),
      'calendarId': serializer.toJson<String>(calendarId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'location': serializer.toJson<String?>(location),
      'dtStart': serializer.toJson<int>(dtStart),
      'dtEnd': serializer.toJson<int?>(dtEnd),
      'duration': serializer.toJson<int?>(duration),
      'timezone': serializer.toJson<String?>(timezone),
      'rrule': serializer.toJson<String?>(rrule),
      'status': serializer.toJson<String>(status),
      'eventType': serializer.toJson<EventType>(eventType),
      'createdAt': serializer.toJson<int>(createdAt),
      'lastModified': serializer.toJson<int>(lastModified),
    };
  }

  Event copyWith({
    int? id,
    String? uid,
    String? calendarId,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<String?> location = const Value.absent(),
    int? dtStart,
    Value<int?> dtEnd = const Value.absent(),
    Value<int?> duration = const Value.absent(),
    Value<String?> timezone = const Value.absent(),
    Value<String?> rrule = const Value.absent(),
    String? status,
    EventType? eventType,
    int? createdAt,
    int? lastModified,
  }) => Event(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    calendarId: calendarId ?? this.calendarId,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    location: location.present ? location.value : this.location,
    dtStart: dtStart ?? this.dtStart,
    dtEnd: dtEnd.present ? dtEnd.value : this.dtEnd,
    duration: duration.present ? duration.value : this.duration,
    timezone: timezone.present ? timezone.value : this.timezone,
    rrule: rrule.present ? rrule.value : this.rrule,
    status: status ?? this.status,
    eventType: eventType ?? this.eventType,
    createdAt: createdAt ?? this.createdAt,
    lastModified: lastModified ?? this.lastModified,
  );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      calendarId: data.calendarId.present
          ? data.calendarId.value
          : this.calendarId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      location: data.location.present ? data.location.value : this.location,
      dtStart: data.dtStart.present ? data.dtStart.value : this.dtStart,
      dtEnd: data.dtEnd.present ? data.dtEnd.value : this.dtEnd,
      duration: data.duration.present ? data.duration.value : this.duration,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      rrule: data.rrule.present ? data.rrule.value : this.rrule,
      status: data.status.present ? data.status.value : this.status,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('calendarId: $calendarId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('location: $location, ')
          ..write('dtStart: $dtStart, ')
          ..write('dtEnd: $dtEnd, ')
          ..write('duration: $duration, ')
          ..write('timezone: $timezone, ')
          ..write('rrule: $rrule, ')
          ..write('status: $status, ')
          ..write('eventType: $eventType, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uid,
    calendarId,
    title,
    description,
    location,
    dtStart,
    dtEnd,
    duration,
    timezone,
    rrule,
    status,
    eventType,
    createdAt,
    lastModified,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.calendarId == this.calendarId &&
          other.title == this.title &&
          other.description == this.description &&
          other.location == this.location &&
          other.dtStart == this.dtStart &&
          other.dtEnd == this.dtEnd &&
          other.duration == this.duration &&
          other.timezone == this.timezone &&
          other.rrule == this.rrule &&
          other.status == this.status &&
          other.eventType == this.eventType &&
          other.createdAt == this.createdAt &&
          other.lastModified == this.lastModified);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> uid;
  final Value<String> calendarId;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> location;
  final Value<int> dtStart;
  final Value<int?> dtEnd;
  final Value<int?> duration;
  final Value<String?> timezone;
  final Value<String?> rrule;
  final Value<String> status;
  final Value<EventType> eventType;
  final Value<int> createdAt;
  final Value<int> lastModified;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.calendarId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.location = const Value.absent(),
    this.dtStart = const Value.absent(),
    this.dtEnd = const Value.absent(),
    this.duration = const Value.absent(),
    this.timezone = const Value.absent(),
    this.rrule = const Value.absent(),
    this.status = const Value.absent(),
    this.eventType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastModified = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String uid,
    required String calendarId,
    required String title,
    this.description = const Value.absent(),
    this.location = const Value.absent(),
    required int dtStart,
    this.dtEnd = const Value.absent(),
    this.duration = const Value.absent(),
    this.timezone = const Value.absent(),
    this.rrule = const Value.absent(),
    this.status = const Value.absent(),
    required EventType eventType,
    required int createdAt,
    required int lastModified,
  }) : uid = Value(uid),
       calendarId = Value(calendarId),
       title = Value(title),
       dtStart = Value(dtStart),
       eventType = Value(eventType),
       createdAt = Value(createdAt),
       lastModified = Value(lastModified);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<String>? uid,
    Expression<String>? calendarId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? location,
    Expression<int>? dtStart,
    Expression<int>? dtEnd,
    Expression<int>? duration,
    Expression<String>? timezone,
    Expression<String>? rrule,
    Expression<String>? status,
    Expression<String>? eventType,
    Expression<int>? createdAt,
    Expression<int>? lastModified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (calendarId != null) 'calendar_id': calendarId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      if (dtStart != null) 'dt_start': dtStart,
      if (dtEnd != null) 'dt_end': dtEnd,
      if (duration != null) 'duration': duration,
      if (timezone != null) 'timezone': timezone,
      if (rrule != null) 'rrule': rrule,
      if (status != null) 'status': status,
      if (eventType != null) 'event_type': eventType,
      if (createdAt != null) 'created_at': createdAt,
      if (lastModified != null) 'last_modified': lastModified,
    });
  }

  EventsCompanion copyWith({
    Value<int>? id,
    Value<String>? uid,
    Value<String>? calendarId,
    Value<String>? title,
    Value<String?>? description,
    Value<String?>? location,
    Value<int>? dtStart,
    Value<int?>? dtEnd,
    Value<int?>? duration,
    Value<String?>? timezone,
    Value<String?>? rrule,
    Value<String>? status,
    Value<EventType>? eventType,
    Value<int>? createdAt,
    Value<int>? lastModified,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      calendarId: calendarId ?? this.calendarId,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      dtStart: dtStart ?? this.dtStart,
      dtEnd: dtEnd ?? this.dtEnd,
      duration: duration ?? this.duration,
      timezone: timezone ?? this.timezone,
      rrule: rrule ?? this.rrule,
      status: status ?? this.status,
      eventType: eventType ?? this.eventType,
      createdAt: createdAt ?? this.createdAt,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (calendarId.present) {
      map['calendar_id'] = Variable<String>(calendarId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (dtStart.present) {
      map['dt_start'] = Variable<int>(dtStart.value);
    }
    if (dtEnd.present) {
      map['dt_end'] = Variable<int>(dtEnd.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (rrule.present) {
      map['rrule'] = Variable<String>(rrule.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(
        $EventsTable.$convertereventType.toSql(eventType.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<int>(lastModified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('calendarId: $calendarId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('location: $location, ')
          ..write('dtStart: $dtStart, ')
          ..write('dtEnd: $dtEnd, ')
          ..write('duration: $duration, ')
          ..write('timezone: $timezone, ')
          ..write('rrule: $rrule, ')
          ..write('status: $status, ')
          ..write('eventType: $eventType, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }
}

class $CalendarsTable extends Calendars
    with TableInfo<$CalendarsTable, Calendar> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalendarsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, color, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calendars';
  @override
  VerificationContext validateIntegrity(
    Insertable<Calendar> instance, {
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
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Calendar map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Calendar(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CalendarsTable createAlias(String alias) {
    return $CalendarsTable(attachedDatabase, alias);
  }
}

class Calendar extends DataClass implements Insertable<Calendar> {
  final int id;
  final String name;
  final String? color;
  final int createdAt;
  const Calendar({
    required this.id,
    required this.name,
    this.color,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CalendarsCompanion toCompanion(bool nullToAbsent) {
    return CalendarsCompanion(
      id: Value(id),
      name: Value(name),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      createdAt: Value(createdAt),
    );
  }

  factory Calendar.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Calendar(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String?>(json['color']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String?>(color),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Calendar copyWith({
    int? id,
    String? name,
    Value<String?> color = const Value.absent(),
    int? createdAt,
  }) => Calendar(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color.present ? color.value : this.color,
    createdAt: createdAt ?? this.createdAt,
  );
  Calendar copyWithCompanion(CalendarsCompanion data) {
    return Calendar(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Calendar(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Calendar &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.createdAt == this.createdAt);
}

class CalendarsCompanion extends UpdateCompanion<Calendar> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> color;
  final Value<int> createdAt;
  const CalendarsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CalendarsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.color = const Value.absent(),
    required int createdAt,
  }) : name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Calendar> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CalendarsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? color,
    Value<int>? createdAt,
  }) {
    return CalendarsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
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
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalendarsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StaminasTable extends Staminas with TableInfo<$StaminasTable, Stamina> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StaminasTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _rechargeTimeMeta = const VerificationMeta(
    'rechargeTime',
  );
  @override
  late final GeneratedColumn<int> rechargeTime = GeneratedColumn<int>(
    'recharge_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _staminaOfLastResetMeta =
      const VerificationMeta('staminaOfLastReset');
  @override
  late final GeneratedColumn<int> staminaOfLastReset = GeneratedColumn<int>(
    'stamina_of_last_reset',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    imageName,
    rechargeTime,
    maxStamina,
    staminaOfLastReset,
    timeOfLastReset,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'staminas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Stamina> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('image_name')) {
      context.handle(
        _imageNameMeta,
        imageName.isAcceptableOrUnknown(data['image_name']!, _imageNameMeta),
      );
    }
    if (data.containsKey('recharge_time')) {
      context.handle(
        _rechargeTimeMeta,
        rechargeTime.isAcceptableOrUnknown(
          data['recharge_time']!,
          _rechargeTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rechargeTimeMeta);
    }
    if (data.containsKey('max_stamina')) {
      context.handle(
        _maxStaminaMeta,
        maxStamina.isAcceptableOrUnknown(data['max_stamina']!, _maxStaminaMeta),
      );
    } else if (isInserting) {
      context.missing(_maxStaminaMeta);
    }
    if (data.containsKey('stamina_of_last_reset')) {
      context.handle(
        _staminaOfLastResetMeta,
        staminaOfLastReset.isAcceptableOrUnknown(
          data['stamina_of_last_reset']!,
          _staminaOfLastResetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_staminaOfLastResetMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Stamina map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Stamina(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      imageName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_name'],
      ),
      rechargeTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recharge_time'],
      )!,
      maxStamina: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_stamina'],
      )!,
      staminaOfLastReset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stamina_of_last_reset'],
      )!,
      timeOfLastReset: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time_of_last_reset'],
      )!,
    );
  }

  @override
  $StaminasTable createAlias(String alias) {
    return $StaminasTable(attachedDatabase, alias);
  }
}

class Stamina extends DataClass implements Insertable<Stamina> {
  final int id;
  final String title;
  final String? imageName;
  final int rechargeTime;
  final int maxStamina;
  final int staminaOfLastReset;
  final DateTime timeOfLastReset;
  const Stamina({
    required this.id,
    required this.title,
    this.imageName,
    required this.rechargeTime,
    required this.maxStamina,
    required this.staminaOfLastReset,
    required this.timeOfLastReset,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || imageName != null) {
      map['image_name'] = Variable<String>(imageName);
    }
    map['recharge_time'] = Variable<int>(rechargeTime);
    map['max_stamina'] = Variable<int>(maxStamina);
    map['stamina_of_last_reset'] = Variable<int>(staminaOfLastReset);
    map['time_of_last_reset'] = Variable<DateTime>(timeOfLastReset);
    return map;
  }

  StaminasCompanion toCompanion(bool nullToAbsent) {
    return StaminasCompanion(
      id: Value(id),
      title: Value(title),
      imageName: imageName == null && nullToAbsent
          ? const Value.absent()
          : Value(imageName),
      rechargeTime: Value(rechargeTime),
      maxStamina: Value(maxStamina),
      staminaOfLastReset: Value(staminaOfLastReset),
      timeOfLastReset: Value(timeOfLastReset),
    );
  }

  factory Stamina.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Stamina(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      imageName: serializer.fromJson<String?>(json['imageName']),
      rechargeTime: serializer.fromJson<int>(json['rechargeTime']),
      maxStamina: serializer.fromJson<int>(json['maxStamina']),
      staminaOfLastReset: serializer.fromJson<int>(json['staminaOfLastReset']),
      timeOfLastReset: serializer.fromJson<DateTime>(json['timeOfLastReset']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'imageName': serializer.toJson<String?>(imageName),
      'rechargeTime': serializer.toJson<int>(rechargeTime),
      'maxStamina': serializer.toJson<int>(maxStamina),
      'staminaOfLastReset': serializer.toJson<int>(staminaOfLastReset),
      'timeOfLastReset': serializer.toJson<DateTime>(timeOfLastReset),
    };
  }

  Stamina copyWith({
    int? id,
    String? title,
    Value<String?> imageName = const Value.absent(),
    int? rechargeTime,
    int? maxStamina,
    int? staminaOfLastReset,
    DateTime? timeOfLastReset,
  }) => Stamina(
    id: id ?? this.id,
    title: title ?? this.title,
    imageName: imageName.present ? imageName.value : this.imageName,
    rechargeTime: rechargeTime ?? this.rechargeTime,
    maxStamina: maxStamina ?? this.maxStamina,
    staminaOfLastReset: staminaOfLastReset ?? this.staminaOfLastReset,
    timeOfLastReset: timeOfLastReset ?? this.timeOfLastReset,
  );
  Stamina copyWithCompanion(StaminasCompanion data) {
    return Stamina(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      imageName: data.imageName.present ? data.imageName.value : this.imageName,
      rechargeTime: data.rechargeTime.present
          ? data.rechargeTime.value
          : this.rechargeTime,
      maxStamina: data.maxStamina.present
          ? data.maxStamina.value
          : this.maxStamina,
      staminaOfLastReset: data.staminaOfLastReset.present
          ? data.staminaOfLastReset.value
          : this.staminaOfLastReset,
      timeOfLastReset: data.timeOfLastReset.present
          ? data.timeOfLastReset.value
          : this.timeOfLastReset,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Stamina(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('imageName: $imageName, ')
          ..write('rechargeTime: $rechargeTime, ')
          ..write('maxStamina: $maxStamina, ')
          ..write('staminaOfLastReset: $staminaOfLastReset, ')
          ..write('timeOfLastReset: $timeOfLastReset')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    imageName,
    rechargeTime,
    maxStamina,
    staminaOfLastReset,
    timeOfLastReset,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Stamina &&
          other.id == this.id &&
          other.title == this.title &&
          other.imageName == this.imageName &&
          other.rechargeTime == this.rechargeTime &&
          other.maxStamina == this.maxStamina &&
          other.staminaOfLastReset == this.staminaOfLastReset &&
          other.timeOfLastReset == this.timeOfLastReset);
}

class StaminasCompanion extends UpdateCompanion<Stamina> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> imageName;
  final Value<int> rechargeTime;
  final Value<int> maxStamina;
  final Value<int> staminaOfLastReset;
  final Value<DateTime> timeOfLastReset;
  const StaminasCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.imageName = const Value.absent(),
    this.rechargeTime = const Value.absent(),
    this.maxStamina = const Value.absent(),
    this.staminaOfLastReset = const Value.absent(),
    this.timeOfLastReset = const Value.absent(),
  });
  StaminasCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.imageName = const Value.absent(),
    required int rechargeTime,
    required int maxStamina,
    required int staminaOfLastReset,
    required DateTime timeOfLastReset,
  }) : title = Value(title),
       rechargeTime = Value(rechargeTime),
       maxStamina = Value(maxStamina),
       staminaOfLastReset = Value(staminaOfLastReset),
       timeOfLastReset = Value(timeOfLastReset);
  static Insertable<Stamina> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? imageName,
    Expression<int>? rechargeTime,
    Expression<int>? maxStamina,
    Expression<int>? staminaOfLastReset,
    Expression<DateTime>? timeOfLastReset,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (imageName != null) 'image_name': imageName,
      if (rechargeTime != null) 'recharge_time': rechargeTime,
      if (maxStamina != null) 'max_stamina': maxStamina,
      if (staminaOfLastReset != null)
        'stamina_of_last_reset': staminaOfLastReset,
      if (timeOfLastReset != null) 'time_of_last_reset': timeOfLastReset,
    });
  }

  StaminasCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? imageName,
    Value<int>? rechargeTime,
    Value<int>? maxStamina,
    Value<int>? staminaOfLastReset,
    Value<DateTime>? timeOfLastReset,
  }) {
    return StaminasCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      imageName: imageName ?? this.imageName,
      rechargeTime: rechargeTime ?? this.rechargeTime,
      maxStamina: maxStamina ?? this.maxStamina,
      staminaOfLastReset: staminaOfLastReset ?? this.staminaOfLastReset,
      timeOfLastReset: timeOfLastReset ?? this.timeOfLastReset,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (imageName.present) {
      map['image_name'] = Variable<String>(imageName.value);
    }
    if (rechargeTime.present) {
      map['recharge_time'] = Variable<int>(rechargeTime.value);
    }
    if (maxStamina.present) {
      map['max_stamina'] = Variable<int>(maxStamina.value);
    }
    if (staminaOfLastReset.present) {
      map['stamina_of_last_reset'] = Variable<int>(staminaOfLastReset.value);
    }
    if (timeOfLastReset.present) {
      map['time_of_last_reset'] = Variable<DateTime>(timeOfLastReset.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StaminasCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('imageName: $imageName, ')
          ..write('rechargeTime: $rechargeTime, ')
          ..write('maxStamina: $maxStamina, ')
          ..write('staminaOfLastReset: $staminaOfLastReset, ')
          ..write('timeOfLastReset: $timeOfLastReset')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $EventsTable events = $EventsTable(this);
  late final $CalendarsTable calendars = $CalendarsTable(this);
  late final $StaminasTable staminas = $StaminasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    events,
    calendars,
    staminas,
  ];
}

typedef $$EventsTableCreateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      required String uid,
      required String calendarId,
      required String title,
      Value<String?> description,
      Value<String?> location,
      required int dtStart,
      Value<int?> dtEnd,
      Value<int?> duration,
      Value<String?> timezone,
      Value<String?> rrule,
      Value<String> status,
      required EventType eventType,
      required int createdAt,
      required int lastModified,
    });
typedef $$EventsTableUpdateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      Value<String> uid,
      Value<String> calendarId,
      Value<String> title,
      Value<String?> description,
      Value<String?> location,
      Value<int> dtStart,
      Value<int?> dtEnd,
      Value<int?> duration,
      Value<String?> timezone,
      Value<String?> rrule,
      Value<String> status,
      Value<EventType> eventType,
      Value<int> createdAt,
      Value<int> lastModified,
    });

class $$EventsTableFilterComposer extends Composer<_$Database, $EventsTable> {
  $$EventsTableFilterComposer({
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

  ColumnFilters<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calendarId => $composableBuilder(
    column: $table.calendarId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dtStart => $composableBuilder(
    column: $table.dtStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dtEnd => $composableBuilder(
    column: $table.dtEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rrule => $composableBuilder(
    column: $table.rrule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<EventType, EventType, String> get eventType =>
      $composableBuilder(
        column: $table.eventType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventsTableOrderingComposer extends Composer<_$Database, $EventsTable> {
  $$EventsTableOrderingComposer({
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

  ColumnOrderings<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calendarId => $composableBuilder(
    column: $table.calendarId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dtStart => $composableBuilder(
    column: $table.dtStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dtEnd => $composableBuilder(
    column: $table.dtEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rrule => $composableBuilder(
    column: $table.rrule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventsTableAnnotationComposer
    extends Composer<_$Database, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get calendarId => $composableBuilder(
    column: $table.calendarId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<int> get dtStart =>
      $composableBuilder(column: $table.dtStart, builder: (column) => column);

  GeneratedColumn<int> get dtEnd =>
      $composableBuilder(column: $table.dtEnd, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get rrule =>
      $composableBuilder(column: $table.rrule, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EventType, String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $EventsTable,
          Event,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (Event, BaseReferences<_$Database, $EventsTable, Event>),
          Event,
          PrefetchHooks Function()
        > {
  $$EventsTableTableManager(_$Database db, $EventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uid = const Value.absent(),
                Value<String> calendarId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<int> dtStart = const Value.absent(),
                Value<int?> dtEnd = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<String?> rrule = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<EventType> eventType = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> lastModified = const Value.absent(),
              }) => EventsCompanion(
                id: id,
                uid: uid,
                calendarId: calendarId,
                title: title,
                description: description,
                location: location,
                dtStart: dtStart,
                dtEnd: dtEnd,
                duration: duration,
                timezone: timezone,
                rrule: rrule,
                status: status,
                eventType: eventType,
                createdAt: createdAt,
                lastModified: lastModified,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uid,
                required String calendarId,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String?> location = const Value.absent(),
                required int dtStart,
                Value<int?> dtEnd = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<String?> rrule = const Value.absent(),
                Value<String> status = const Value.absent(),
                required EventType eventType,
                required int createdAt,
                required int lastModified,
              }) => EventsCompanion.insert(
                id: id,
                uid: uid,
                calendarId: calendarId,
                title: title,
                description: description,
                location: location,
                dtStart: dtStart,
                dtEnd: dtEnd,
                duration: duration,
                timezone: timezone,
                rrule: rrule,
                status: status,
                eventType: eventType,
                createdAt: createdAt,
                lastModified: lastModified,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $EventsTable,
      Event,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (Event, BaseReferences<_$Database, $EventsTable, Event>),
      Event,
      PrefetchHooks Function()
    >;
typedef $$CalendarsTableCreateCompanionBuilder =
    CalendarsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> color,
      required int createdAt,
    });
typedef $$CalendarsTableUpdateCompanionBuilder =
    CalendarsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> color,
      Value<int> createdAt,
    });

class $$CalendarsTableFilterComposer
    extends Composer<_$Database, $CalendarsTable> {
  $$CalendarsTableFilterComposer({
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

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CalendarsTableOrderingComposer
    extends Composer<_$Database, $CalendarsTable> {
  $$CalendarsTableOrderingComposer({
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

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CalendarsTableAnnotationComposer
    extends Composer<_$Database, $CalendarsTable> {
  $$CalendarsTableAnnotationComposer({
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

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CalendarsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $CalendarsTable,
          Calendar,
          $$CalendarsTableFilterComposer,
          $$CalendarsTableOrderingComposer,
          $$CalendarsTableAnnotationComposer,
          $$CalendarsTableCreateCompanionBuilder,
          $$CalendarsTableUpdateCompanionBuilder,
          (Calendar, BaseReferences<_$Database, $CalendarsTable, Calendar>),
          Calendar,
          PrefetchHooks Function()
        > {
  $$CalendarsTableTableManager(_$Database db, $CalendarsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalendarsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalendarsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalendarsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => CalendarsCompanion(
                id: id,
                name: name,
                color: color,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> color = const Value.absent(),
                required int createdAt,
              }) => CalendarsCompanion.insert(
                id: id,
                name: name,
                color: color,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CalendarsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $CalendarsTable,
      Calendar,
      $$CalendarsTableFilterComposer,
      $$CalendarsTableOrderingComposer,
      $$CalendarsTableAnnotationComposer,
      $$CalendarsTableCreateCompanionBuilder,
      $$CalendarsTableUpdateCompanionBuilder,
      (Calendar, BaseReferences<_$Database, $CalendarsTable, Calendar>),
      Calendar,
      PrefetchHooks Function()
    >;
typedef $$StaminasTableCreateCompanionBuilder =
    StaminasCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> imageName,
      required int rechargeTime,
      required int maxStamina,
      required int staminaOfLastReset,
      required DateTime timeOfLastReset,
    });
typedef $$StaminasTableUpdateCompanionBuilder =
    StaminasCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> imageName,
      Value<int> rechargeTime,
      Value<int> maxStamina,
      Value<int> staminaOfLastReset,
      Value<DateTime> timeOfLastReset,
    });

class $$StaminasTableFilterComposer
    extends Composer<_$Database, $StaminasTable> {
  $$StaminasTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageName => $composableBuilder(
    column: $table.imageName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rechargeTime => $composableBuilder(
    column: $table.rechargeTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxStamina => $composableBuilder(
    column: $table.maxStamina,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get staminaOfLastReset => $composableBuilder(
    column: $table.staminaOfLastReset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timeOfLastReset => $composableBuilder(
    column: $table.timeOfLastReset,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StaminasTableOrderingComposer
    extends Composer<_$Database, $StaminasTable> {
  $$StaminasTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageName => $composableBuilder(
    column: $table.imageName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rechargeTime => $composableBuilder(
    column: $table.rechargeTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxStamina => $composableBuilder(
    column: $table.maxStamina,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get staminaOfLastReset => $composableBuilder(
    column: $table.staminaOfLastReset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timeOfLastReset => $composableBuilder(
    column: $table.timeOfLastReset,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StaminasTableAnnotationComposer
    extends Composer<_$Database, $StaminasTable> {
  $$StaminasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get imageName =>
      $composableBuilder(column: $table.imageName, builder: (column) => column);

  GeneratedColumn<int> get rechargeTime => $composableBuilder(
    column: $table.rechargeTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxStamina => $composableBuilder(
    column: $table.maxStamina,
    builder: (column) => column,
  );

  GeneratedColumn<int> get staminaOfLastReset => $composableBuilder(
    column: $table.staminaOfLastReset,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timeOfLastReset => $composableBuilder(
    column: $table.timeOfLastReset,
    builder: (column) => column,
  );
}

class $$StaminasTableTableManager
    extends
        RootTableManager<
          _$Database,
          $StaminasTable,
          Stamina,
          $$StaminasTableFilterComposer,
          $$StaminasTableOrderingComposer,
          $$StaminasTableAnnotationComposer,
          $$StaminasTableCreateCompanionBuilder,
          $$StaminasTableUpdateCompanionBuilder,
          (Stamina, BaseReferences<_$Database, $StaminasTable, Stamina>),
          Stamina,
          PrefetchHooks Function()
        > {
  $$StaminasTableTableManager(_$Database db, $StaminasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StaminasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StaminasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StaminasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> imageName = const Value.absent(),
                Value<int> rechargeTime = const Value.absent(),
                Value<int> maxStamina = const Value.absent(),
                Value<int> staminaOfLastReset = const Value.absent(),
                Value<DateTime> timeOfLastReset = const Value.absent(),
              }) => StaminasCompanion(
                id: id,
                title: title,
                imageName: imageName,
                rechargeTime: rechargeTime,
                maxStamina: maxStamina,
                staminaOfLastReset: staminaOfLastReset,
                timeOfLastReset: timeOfLastReset,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> imageName = const Value.absent(),
                required int rechargeTime,
                required int maxStamina,
                required int staminaOfLastReset,
                required DateTime timeOfLastReset,
              }) => StaminasCompanion.insert(
                id: id,
                title: title,
                imageName: imageName,
                rechargeTime: rechargeTime,
                maxStamina: maxStamina,
                staminaOfLastReset: staminaOfLastReset,
                timeOfLastReset: timeOfLastReset,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StaminasTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $StaminasTable,
      Stamina,
      $$StaminasTableFilterComposer,
      $$StaminasTableOrderingComposer,
      $$StaminasTableAnnotationComposer,
      $$StaminasTableCreateCompanionBuilder,
      $$StaminasTableUpdateCompanionBuilder,
      (Stamina, BaseReferences<_$Database, $StaminasTable, Stamina>),
      Stamina,
      PrefetchHooks Function()
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$CalendarsTableTableManager get calendars =>
      $$CalendarsTableTableManager(_db, _db.calendars);
  $$StaminasTableTableManager get staminas =>
      $$StaminasTableTableManager(_db, _db.staminas);
}

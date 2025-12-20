// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $EventInfosTable extends EventInfos
    with TableInfo<$EventInfosTable, EventInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventInfosTable(this.attachedDatabase, [this._alias]);
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
  @override
  late final GeneratedColumnWithTypeConverter<EventType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<EventType>($EventInfosTable.$convertertype);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dtStartMeta = const VerificationMeta(
    'dtStart',
  );
  @override
  late final GeneratedColumn<int> dtStart = GeneratedColumn<int>(
    'dt_start',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _untilMeta = const VerificationMeta('until');
  @override
  late final GeneratedColumn<int> until = GeneratedColumn<int>(
    'until',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
    calendarId,
    title,
    description,
    location,
    type,
    date,
    dtStart,
    dtEnd,
    timezone,
    rrule,
    until,
    createdAt,
    lastModified,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_infos';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventInfo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('dt_start')) {
      context.handle(
        _dtStartMeta,
        dtStart.isAcceptableOrUnknown(data['dt_start']!, _dtStartMeta),
      );
    }
    if (data.containsKey('dt_end')) {
      context.handle(
        _dtEndMeta,
        dtEnd.isAcceptableOrUnknown(data['dt_end']!, _dtEndMeta),
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
    if (data.containsKey('until')) {
      context.handle(
        _untilMeta,
        until.isAcceptableOrUnknown(data['until']!, _untilMeta),
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
  EventInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventInfo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
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
      type: $EventInfosTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date'],
      )!,
      dtStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dt_start'],
      ),
      dtEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dt_end'],
      ),
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      ),
      rrule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rrule'],
      ),
      until: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}until'],
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
  $EventInfosTable createAlias(String alias) {
    return $EventInfosTable(attachedDatabase, alias);
  }

  static TypeConverter<EventType, String> $convertertype =
      const EventTypeConverter();
}

class EventInfo extends DataClass implements Insertable<EventInfo> {
  final int id;
  final String calendarId;
  final String title;
  final String? description;
  final String? location;
  final EventType type;
  final int date;
  final int? dtStart;
  final int? dtEnd;
  final String? timezone;
  final String? rrule;
  final int? until;
  final int createdAt;
  final int lastModified;
  const EventInfo({
    required this.id,
    required this.calendarId,
    required this.title,
    this.description,
    this.location,
    required this.type,
    required this.date,
    this.dtStart,
    this.dtEnd,
    this.timezone,
    this.rrule,
    this.until,
    required this.createdAt,
    required this.lastModified,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['calendar_id'] = Variable<String>(calendarId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    {
      map['type'] = Variable<String>(
        $EventInfosTable.$convertertype.toSql(type),
      );
    }
    map['date'] = Variable<int>(date);
    if (!nullToAbsent || dtStart != null) {
      map['dt_start'] = Variable<int>(dtStart);
    }
    if (!nullToAbsent || dtEnd != null) {
      map['dt_end'] = Variable<int>(dtEnd);
    }
    if (!nullToAbsent || timezone != null) {
      map['timezone'] = Variable<String>(timezone);
    }
    if (!nullToAbsent || rrule != null) {
      map['rrule'] = Variable<String>(rrule);
    }
    if (!nullToAbsent || until != null) {
      map['until'] = Variable<int>(until);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['last_modified'] = Variable<int>(lastModified);
    return map;
  }

  EventInfosCompanion toCompanion(bool nullToAbsent) {
    return EventInfosCompanion(
      id: Value(id),
      calendarId: Value(calendarId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      type: Value(type),
      date: Value(date),
      dtStart: dtStart == null && nullToAbsent
          ? const Value.absent()
          : Value(dtStart),
      dtEnd: dtEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(dtEnd),
      timezone: timezone == null && nullToAbsent
          ? const Value.absent()
          : Value(timezone),
      rrule: rrule == null && nullToAbsent
          ? const Value.absent()
          : Value(rrule),
      until: until == null && nullToAbsent
          ? const Value.absent()
          : Value(until),
      createdAt: Value(createdAt),
      lastModified: Value(lastModified),
    );
  }

  factory EventInfo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventInfo(
      id: serializer.fromJson<int>(json['id']),
      calendarId: serializer.fromJson<String>(json['calendarId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      location: serializer.fromJson<String?>(json['location']),
      type: serializer.fromJson<EventType>(json['type']),
      date: serializer.fromJson<int>(json['date']),
      dtStart: serializer.fromJson<int?>(json['dtStart']),
      dtEnd: serializer.fromJson<int?>(json['dtEnd']),
      timezone: serializer.fromJson<String?>(json['timezone']),
      rrule: serializer.fromJson<String?>(json['rrule']),
      until: serializer.fromJson<int?>(json['until']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      lastModified: serializer.fromJson<int>(json['lastModified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'calendarId': serializer.toJson<String>(calendarId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'location': serializer.toJson<String?>(location),
      'type': serializer.toJson<EventType>(type),
      'date': serializer.toJson<int>(date),
      'dtStart': serializer.toJson<int?>(dtStart),
      'dtEnd': serializer.toJson<int?>(dtEnd),
      'timezone': serializer.toJson<String?>(timezone),
      'rrule': serializer.toJson<String?>(rrule),
      'until': serializer.toJson<int?>(until),
      'createdAt': serializer.toJson<int>(createdAt),
      'lastModified': serializer.toJson<int>(lastModified),
    };
  }

  EventInfo copyWith({
    int? id,
    String? calendarId,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<String?> location = const Value.absent(),
    EventType? type,
    int? date,
    Value<int?> dtStart = const Value.absent(),
    Value<int?> dtEnd = const Value.absent(),
    Value<String?> timezone = const Value.absent(),
    Value<String?> rrule = const Value.absent(),
    Value<int?> until = const Value.absent(),
    int? createdAt,
    int? lastModified,
  }) => EventInfo(
    id: id ?? this.id,
    calendarId: calendarId ?? this.calendarId,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    location: location.present ? location.value : this.location,
    type: type ?? this.type,
    date: date ?? this.date,
    dtStart: dtStart.present ? dtStart.value : this.dtStart,
    dtEnd: dtEnd.present ? dtEnd.value : this.dtEnd,
    timezone: timezone.present ? timezone.value : this.timezone,
    rrule: rrule.present ? rrule.value : this.rrule,
    until: until.present ? until.value : this.until,
    createdAt: createdAt ?? this.createdAt,
    lastModified: lastModified ?? this.lastModified,
  );
  EventInfo copyWithCompanion(EventInfosCompanion data) {
    return EventInfo(
      id: data.id.present ? data.id.value : this.id,
      calendarId: data.calendarId.present
          ? data.calendarId.value
          : this.calendarId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      location: data.location.present ? data.location.value : this.location,
      type: data.type.present ? data.type.value : this.type,
      date: data.date.present ? data.date.value : this.date,
      dtStart: data.dtStart.present ? data.dtStart.value : this.dtStart,
      dtEnd: data.dtEnd.present ? data.dtEnd.value : this.dtEnd,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      rrule: data.rrule.present ? data.rrule.value : this.rrule,
      until: data.until.present ? data.until.value : this.until,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventInfo(')
          ..write('id: $id, ')
          ..write('calendarId: $calendarId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('location: $location, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('dtStart: $dtStart, ')
          ..write('dtEnd: $dtEnd, ')
          ..write('timezone: $timezone, ')
          ..write('rrule: $rrule, ')
          ..write('until: $until, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    calendarId,
    title,
    description,
    location,
    type,
    date,
    dtStart,
    dtEnd,
    timezone,
    rrule,
    until,
    createdAt,
    lastModified,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventInfo &&
          other.id == this.id &&
          other.calendarId == this.calendarId &&
          other.title == this.title &&
          other.description == this.description &&
          other.location == this.location &&
          other.type == this.type &&
          other.date == this.date &&
          other.dtStart == this.dtStart &&
          other.dtEnd == this.dtEnd &&
          other.timezone == this.timezone &&
          other.rrule == this.rrule &&
          other.until == this.until &&
          other.createdAt == this.createdAt &&
          other.lastModified == this.lastModified);
}

class EventInfosCompanion extends UpdateCompanion<EventInfo> {
  final Value<int> id;
  final Value<String> calendarId;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> location;
  final Value<EventType> type;
  final Value<int> date;
  final Value<int?> dtStart;
  final Value<int?> dtEnd;
  final Value<String?> timezone;
  final Value<String?> rrule;
  final Value<int?> until;
  final Value<int> createdAt;
  final Value<int> lastModified;
  const EventInfosCompanion({
    this.id = const Value.absent(),
    this.calendarId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.location = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.dtStart = const Value.absent(),
    this.dtEnd = const Value.absent(),
    this.timezone = const Value.absent(),
    this.rrule = const Value.absent(),
    this.until = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastModified = const Value.absent(),
  });
  EventInfosCompanion.insert({
    this.id = const Value.absent(),
    required String calendarId,
    required String title,
    this.description = const Value.absent(),
    this.location = const Value.absent(),
    required EventType type,
    required int date,
    this.dtStart = const Value.absent(),
    this.dtEnd = const Value.absent(),
    this.timezone = const Value.absent(),
    this.rrule = const Value.absent(),
    this.until = const Value.absent(),
    required int createdAt,
    required int lastModified,
  }) : calendarId = Value(calendarId),
       title = Value(title),
       type = Value(type),
       date = Value(date),
       createdAt = Value(createdAt),
       lastModified = Value(lastModified);
  static Insertable<EventInfo> custom({
    Expression<int>? id,
    Expression<String>? calendarId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? location,
    Expression<String>? type,
    Expression<int>? date,
    Expression<int>? dtStart,
    Expression<int>? dtEnd,
    Expression<String>? timezone,
    Expression<String>? rrule,
    Expression<int>? until,
    Expression<int>? createdAt,
    Expression<int>? lastModified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (calendarId != null) 'calendar_id': calendarId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (dtStart != null) 'dt_start': dtStart,
      if (dtEnd != null) 'dt_end': dtEnd,
      if (timezone != null) 'timezone': timezone,
      if (rrule != null) 'rrule': rrule,
      if (until != null) 'until': until,
      if (createdAt != null) 'created_at': createdAt,
      if (lastModified != null) 'last_modified': lastModified,
    });
  }

  EventInfosCompanion copyWith({
    Value<int>? id,
    Value<String>? calendarId,
    Value<String>? title,
    Value<String?>? description,
    Value<String?>? location,
    Value<EventType>? type,
    Value<int>? date,
    Value<int?>? dtStart,
    Value<int?>? dtEnd,
    Value<String?>? timezone,
    Value<String?>? rrule,
    Value<int?>? until,
    Value<int>? createdAt,
    Value<int>? lastModified,
  }) {
    return EventInfosCompanion(
      id: id ?? this.id,
      calendarId: calendarId ?? this.calendarId,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      type: type ?? this.type,
      date: date ?? this.date,
      dtStart: dtStart ?? this.dtStart,
      dtEnd: dtEnd ?? this.dtEnd,
      timezone: timezone ?? this.timezone,
      rrule: rrule ?? this.rrule,
      until: until ?? this.until,
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
    if (type.present) {
      map['type'] = Variable<String>(
        $EventInfosTable.$convertertype.toSql(type.value),
      );
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (dtStart.present) {
      map['dt_start'] = Variable<int>(dtStart.value);
    }
    if (dtEnd.present) {
      map['dt_end'] = Variable<int>(dtEnd.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (rrule.present) {
      map['rrule'] = Variable<String>(rrule.value);
    }
    if (until.present) {
      map['until'] = Variable<int>(until.value);
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
    return (StringBuffer('EventInfosCompanion(')
          ..write('id: $id, ')
          ..write('calendarId: $calendarId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('location: $location, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('dtStart: $dtStart, ')
          ..write('dtEnd: $dtEnd, ')
          ..write('timezone: $timezone, ')
          ..write('rrule: $rrule, ')
          ..write('until: $until, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }
}

class $EventCacheInstancesTable extends EventCacheInstances
    with TableInfo<$EventCacheInstancesTable, EventCacheInstance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventCacheInstancesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _eventInfoIdMeta = const VerificationMeta(
    'eventInfoId',
  );
  @override
  late final GeneratedColumn<int> eventInfoId = GeneratedColumn<int>(
    'event_info_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES event_infos (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<int> start = GeneratedColumn<int>(
    'start',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<int> end = GeneratedColumn<int>(
    'end',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, eventInfoId, date, start, end];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_cache_instances';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventCacheInstance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_info_id')) {
      context.handle(
        _eventInfoIdMeta,
        eventInfoId.isAcceptableOrUnknown(
          data['event_info_id']!,
          _eventInfoIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_eventInfoIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start')) {
      context.handle(
        _startMeta,
        start.isAcceptableOrUnknown(data['start']!, _startMeta),
      );
    }
    if (data.containsKey('end')) {
      context.handle(
        _endMeta,
        end.isAcceptableOrUnknown(data['end']!, _endMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventCacheInstance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventCacheInstance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eventInfoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_info_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date'],
      )!,
      start: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start'],
      ),
      end: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end'],
      ),
    );
  }

  @override
  $EventCacheInstancesTable createAlias(String alias) {
    return $EventCacheInstancesTable(attachedDatabase, alias);
  }
}

class EventCacheInstance extends DataClass
    implements Insertable<EventCacheInstance> {
  final int id;
  final int eventInfoId;
  final int date;
  final int? start;
  final int? end;
  const EventCacheInstance({
    required this.id,
    required this.eventInfoId,
    required this.date,
    this.start,
    this.end,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_info_id'] = Variable<int>(eventInfoId);
    map['date'] = Variable<int>(date);
    if (!nullToAbsent || start != null) {
      map['start'] = Variable<int>(start);
    }
    if (!nullToAbsent || end != null) {
      map['end'] = Variable<int>(end);
    }
    return map;
  }

  EventCacheInstancesCompanion toCompanion(bool nullToAbsent) {
    return EventCacheInstancesCompanion(
      id: Value(id),
      eventInfoId: Value(eventInfoId),
      date: Value(date),
      start: start == null && nullToAbsent
          ? const Value.absent()
          : Value(start),
      end: end == null && nullToAbsent ? const Value.absent() : Value(end),
    );
  }

  factory EventCacheInstance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventCacheInstance(
      id: serializer.fromJson<int>(json['id']),
      eventInfoId: serializer.fromJson<int>(json['eventInfoId']),
      date: serializer.fromJson<int>(json['date']),
      start: serializer.fromJson<int?>(json['start']),
      end: serializer.fromJson<int?>(json['end']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventInfoId': serializer.toJson<int>(eventInfoId),
      'date': serializer.toJson<int>(date),
      'start': serializer.toJson<int?>(start),
      'end': serializer.toJson<int?>(end),
    };
  }

  EventCacheInstance copyWith({
    int? id,
    int? eventInfoId,
    int? date,
    Value<int?> start = const Value.absent(),
    Value<int?> end = const Value.absent(),
  }) => EventCacheInstance(
    id: id ?? this.id,
    eventInfoId: eventInfoId ?? this.eventInfoId,
    date: date ?? this.date,
    start: start.present ? start.value : this.start,
    end: end.present ? end.value : this.end,
  );
  EventCacheInstance copyWithCompanion(EventCacheInstancesCompanion data) {
    return EventCacheInstance(
      id: data.id.present ? data.id.value : this.id,
      eventInfoId: data.eventInfoId.present
          ? data.eventInfoId.value
          : this.eventInfoId,
      date: data.date.present ? data.date.value : this.date,
      start: data.start.present ? data.start.value : this.start,
      end: data.end.present ? data.end.value : this.end,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventCacheInstance(')
          ..write('id: $id, ')
          ..write('eventInfoId: $eventInfoId, ')
          ..write('date: $date, ')
          ..write('start: $start, ')
          ..write('end: $end')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventInfoId, date, start, end);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventCacheInstance &&
          other.id == this.id &&
          other.eventInfoId == this.eventInfoId &&
          other.date == this.date &&
          other.start == this.start &&
          other.end == this.end);
}

class EventCacheInstancesCompanion extends UpdateCompanion<EventCacheInstance> {
  final Value<int> id;
  final Value<int> eventInfoId;
  final Value<int> date;
  final Value<int?> start;
  final Value<int?> end;
  const EventCacheInstancesCompanion({
    this.id = const Value.absent(),
    this.eventInfoId = const Value.absent(),
    this.date = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
  });
  EventCacheInstancesCompanion.insert({
    this.id = const Value.absent(),
    required int eventInfoId,
    required int date,
    this.start = const Value.absent(),
    this.end = const Value.absent(),
  }) : eventInfoId = Value(eventInfoId),
       date = Value(date);
  static Insertable<EventCacheInstance> custom({
    Expression<int>? id,
    Expression<int>? eventInfoId,
    Expression<int>? date,
    Expression<int>? start,
    Expression<int>? end,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventInfoId != null) 'event_info_id': eventInfoId,
      if (date != null) 'date': date,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
    });
  }

  EventCacheInstancesCompanion copyWith({
    Value<int>? id,
    Value<int>? eventInfoId,
    Value<int>? date,
    Value<int?>? start,
    Value<int?>? end,
  }) {
    return EventCacheInstancesCompanion(
      id: id ?? this.id,
      eventInfoId: eventInfoId ?? this.eventInfoId,
      date: date ?? this.date,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventInfoId.present) {
      map['event_info_id'] = Variable<int>(eventInfoId.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (start.present) {
      map['start'] = Variable<int>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<int>(end.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventCacheInstancesCompanion(')
          ..write('id: $id, ')
          ..write('eventInfoId: $eventInfoId, ')
          ..write('date: $date, ')
          ..write('start: $start, ')
          ..write('end: $end')
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
  late final $EventInfosTable eventInfos = $EventInfosTable(this);
  late final $EventCacheInstancesTable eventCacheInstances =
      $EventCacheInstancesTable(this);
  late final $CalendarsTable calendars = $CalendarsTable(this);
  late final $StaminasTable staminas = $StaminasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    eventInfos,
    eventCacheInstances,
    calendars,
    staminas,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'event_infos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_cache_instances', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$EventInfosTableCreateCompanionBuilder =
    EventInfosCompanion Function({
      Value<int> id,
      required String calendarId,
      required String title,
      Value<String?> description,
      Value<String?> location,
      required EventType type,
      required int date,
      Value<int?> dtStart,
      Value<int?> dtEnd,
      Value<String?> timezone,
      Value<String?> rrule,
      Value<int?> until,
      required int createdAt,
      required int lastModified,
    });
typedef $$EventInfosTableUpdateCompanionBuilder =
    EventInfosCompanion Function({
      Value<int> id,
      Value<String> calendarId,
      Value<String> title,
      Value<String?> description,
      Value<String?> location,
      Value<EventType> type,
      Value<int> date,
      Value<int?> dtStart,
      Value<int?> dtEnd,
      Value<String?> timezone,
      Value<String?> rrule,
      Value<int?> until,
      Value<int> createdAt,
      Value<int> lastModified,
    });

final class $$EventInfosTableReferences
    extends BaseReferences<_$Database, $EventInfosTable, EventInfo> {
  $$EventInfosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $EventCacheInstancesTable,
    List<EventCacheInstance>
  >
  _eventCacheInstancesRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.eventCacheInstances,
    aliasName: $_aliasNameGenerator(
      db.eventInfos.id,
      db.eventCacheInstances.eventInfoId,
    ),
  );

  $$EventCacheInstancesTableProcessedTableManager get eventCacheInstancesRefs {
    final manager = $$EventCacheInstancesTableTableManager(
      $_db,
      $_db.eventCacheInstances,
    ).filter((f) => f.eventInfoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventCacheInstancesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EventInfosTableFilterComposer
    extends Composer<_$Database, $EventInfosTable> {
  $$EventInfosTableFilterComposer({
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

  ColumnWithTypeConverterFilters<EventType, EventType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get date => $composableBuilder(
    column: $table.date,
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

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rrule => $composableBuilder(
    column: $table.rrule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get until => $composableBuilder(
    column: $table.until,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> eventCacheInstancesRefs(
    Expression<bool> Function($$EventCacheInstancesTableFilterComposer f) f,
  ) {
    final $$EventCacheInstancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventCacheInstances,
      getReferencedColumn: (t) => t.eventInfoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventCacheInstancesTableFilterComposer(
            $db: $db,
            $table: $db.eventCacheInstances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventInfosTableOrderingComposer
    extends Composer<_$Database, $EventInfosTable> {
  $$EventInfosTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get date => $composableBuilder(
    column: $table.date,
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

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rrule => $composableBuilder(
    column: $table.rrule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get until => $composableBuilder(
    column: $table.until,
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

class $$EventInfosTableAnnotationComposer
    extends Composer<_$Database, $EventInfosTable> {
  $$EventInfosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

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

  GeneratedColumnWithTypeConverter<EventType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get dtStart =>
      $composableBuilder(column: $table.dtStart, builder: (column) => column);

  GeneratedColumn<int> get dtEnd =>
      $composableBuilder(column: $table.dtEnd, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get rrule =>
      $composableBuilder(column: $table.rrule, builder: (column) => column);

  GeneratedColumn<int> get until =>
      $composableBuilder(column: $table.until, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );

  Expression<T> eventCacheInstancesRefs<T extends Object>(
    Expression<T> Function($$EventCacheInstancesTableAnnotationComposer a) f,
  ) {
    final $$EventCacheInstancesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventCacheInstances,
          getReferencedColumn: (t) => t.eventInfoId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EventCacheInstancesTableAnnotationComposer(
                $db: $db,
                $table: $db.eventCacheInstances,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EventInfosTableTableManager
    extends
        RootTableManager<
          _$Database,
          $EventInfosTable,
          EventInfo,
          $$EventInfosTableFilterComposer,
          $$EventInfosTableOrderingComposer,
          $$EventInfosTableAnnotationComposer,
          $$EventInfosTableCreateCompanionBuilder,
          $$EventInfosTableUpdateCompanionBuilder,
          (EventInfo, $$EventInfosTableReferences),
          EventInfo,
          PrefetchHooks Function({bool eventCacheInstancesRefs})
        > {
  $$EventInfosTableTableManager(_$Database db, $EventInfosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventInfosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventInfosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventInfosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> calendarId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<EventType> type = const Value.absent(),
                Value<int> date = const Value.absent(),
                Value<int?> dtStart = const Value.absent(),
                Value<int?> dtEnd = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<String?> rrule = const Value.absent(),
                Value<int?> until = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> lastModified = const Value.absent(),
              }) => EventInfosCompanion(
                id: id,
                calendarId: calendarId,
                title: title,
                description: description,
                location: location,
                type: type,
                date: date,
                dtStart: dtStart,
                dtEnd: dtEnd,
                timezone: timezone,
                rrule: rrule,
                until: until,
                createdAt: createdAt,
                lastModified: lastModified,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String calendarId,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String?> location = const Value.absent(),
                required EventType type,
                required int date,
                Value<int?> dtStart = const Value.absent(),
                Value<int?> dtEnd = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<String?> rrule = const Value.absent(),
                Value<int?> until = const Value.absent(),
                required int createdAt,
                required int lastModified,
              }) => EventInfosCompanion.insert(
                id: id,
                calendarId: calendarId,
                title: title,
                description: description,
                location: location,
                type: type,
                date: date,
                dtStart: dtStart,
                dtEnd: dtEnd,
                timezone: timezone,
                rrule: rrule,
                until: until,
                createdAt: createdAt,
                lastModified: lastModified,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventInfosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventCacheInstancesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (eventCacheInstancesRefs) db.eventCacheInstances,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (eventCacheInstancesRefs)
                    await $_getPrefetchedData<
                      EventInfo,
                      $EventInfosTable,
                      EventCacheInstance
                    >(
                      currentTable: table,
                      referencedTable: $$EventInfosTableReferences
                          ._eventCacheInstancesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EventInfosTableReferences(
                            db,
                            table,
                            p0,
                          ).eventCacheInstancesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.eventInfoId == item.id,
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

typedef $$EventInfosTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $EventInfosTable,
      EventInfo,
      $$EventInfosTableFilterComposer,
      $$EventInfosTableOrderingComposer,
      $$EventInfosTableAnnotationComposer,
      $$EventInfosTableCreateCompanionBuilder,
      $$EventInfosTableUpdateCompanionBuilder,
      (EventInfo, $$EventInfosTableReferences),
      EventInfo,
      PrefetchHooks Function({bool eventCacheInstancesRefs})
    >;
typedef $$EventCacheInstancesTableCreateCompanionBuilder =
    EventCacheInstancesCompanion Function({
      Value<int> id,
      required int eventInfoId,
      required int date,
      Value<int?> start,
      Value<int?> end,
    });
typedef $$EventCacheInstancesTableUpdateCompanionBuilder =
    EventCacheInstancesCompanion Function({
      Value<int> id,
      Value<int> eventInfoId,
      Value<int> date,
      Value<int?> start,
      Value<int?> end,
    });

final class $$EventCacheInstancesTableReferences
    extends
        BaseReferences<
          _$Database,
          $EventCacheInstancesTable,
          EventCacheInstance
        > {
  $$EventCacheInstancesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventInfosTable _eventInfoIdTable(_$Database db) =>
      db.eventInfos.createAlias(
        $_aliasNameGenerator(
          db.eventCacheInstances.eventInfoId,
          db.eventInfos.id,
        ),
      );

  $$EventInfosTableProcessedTableManager get eventInfoId {
    final $_column = $_itemColumn<int>('event_info_id')!;

    final manager = $$EventInfosTableTableManager(
      $_db,
      $_db.eventInfos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventInfoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventCacheInstancesTableFilterComposer
    extends Composer<_$Database, $EventCacheInstancesTable> {
  $$EventCacheInstancesTableFilterComposer({
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

  ColumnFilters<int> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnFilters(column),
  );

  $$EventInfosTableFilterComposer get eventInfoId {
    final $$EventInfosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventInfoId,
      referencedTable: $db.eventInfos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventInfosTableFilterComposer(
            $db: $db,
            $table: $db.eventInfos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventCacheInstancesTableOrderingComposer
    extends Composer<_$Database, $EventCacheInstancesTable> {
  $$EventCacheInstancesTableOrderingComposer({
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

  ColumnOrderings<int> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventInfosTableOrderingComposer get eventInfoId {
    final $$EventInfosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventInfoId,
      referencedTable: $db.eventInfos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventInfosTableOrderingComposer(
            $db: $db,
            $table: $db.eventInfos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventCacheInstancesTableAnnotationComposer
    extends Composer<_$Database, $EventCacheInstancesTable> {
  $$EventCacheInstancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get start =>
      $composableBuilder(column: $table.start, builder: (column) => column);

  GeneratedColumn<int> get end =>
      $composableBuilder(column: $table.end, builder: (column) => column);

  $$EventInfosTableAnnotationComposer get eventInfoId {
    final $$EventInfosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventInfoId,
      referencedTable: $db.eventInfos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventInfosTableAnnotationComposer(
            $db: $db,
            $table: $db.eventInfos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventCacheInstancesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $EventCacheInstancesTable,
          EventCacheInstance,
          $$EventCacheInstancesTableFilterComposer,
          $$EventCacheInstancesTableOrderingComposer,
          $$EventCacheInstancesTableAnnotationComposer,
          $$EventCacheInstancesTableCreateCompanionBuilder,
          $$EventCacheInstancesTableUpdateCompanionBuilder,
          (EventCacheInstance, $$EventCacheInstancesTableReferences),
          EventCacheInstance,
          PrefetchHooks Function({bool eventInfoId})
        > {
  $$EventCacheInstancesTableTableManager(
    _$Database db,
    $EventCacheInstancesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventCacheInstancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventCacheInstancesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EventCacheInstancesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eventInfoId = const Value.absent(),
                Value<int> date = const Value.absent(),
                Value<int?> start = const Value.absent(),
                Value<int?> end = const Value.absent(),
              }) => EventCacheInstancesCompanion(
                id: id,
                eventInfoId: eventInfoId,
                date: date,
                start: start,
                end: end,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eventInfoId,
                required int date,
                Value<int?> start = const Value.absent(),
                Value<int?> end = const Value.absent(),
              }) => EventCacheInstancesCompanion.insert(
                id: id,
                eventInfoId: eventInfoId,
                date: date,
                start: start,
                end: end,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventCacheInstancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventInfoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                    if (eventInfoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventInfoId,
                                referencedTable:
                                    $$EventCacheInstancesTableReferences
                                        ._eventInfoIdTable(db),
                                referencedColumn:
                                    $$EventCacheInstancesTableReferences
                                        ._eventInfoIdTable(db)
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

typedef $$EventCacheInstancesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $EventCacheInstancesTable,
      EventCacheInstance,
      $$EventCacheInstancesTableFilterComposer,
      $$EventCacheInstancesTableOrderingComposer,
      $$EventCacheInstancesTableAnnotationComposer,
      $$EventCacheInstancesTableCreateCompanionBuilder,
      $$EventCacheInstancesTableUpdateCompanionBuilder,
      (EventCacheInstance, $$EventCacheInstancesTableReferences),
      EventCacheInstance,
      PrefetchHooks Function({bool eventInfoId})
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
  $$EventInfosTableTableManager get eventInfos =>
      $$EventInfosTableTableManager(_db, _db.eventInfos);
  $$EventCacheInstancesTableTableManager get eventCacheInstances =>
      $$EventCacheInstancesTableTableManager(_db, _db.eventCacheInstances);
  $$CalendarsTableTableManager get calendars =>
      $$CalendarsTableTableManager(_db, _db.calendars);
  $$StaminasTableTableManager get staminas =>
      $$StaminasTableTableManager(_db, _db.staminas);
}

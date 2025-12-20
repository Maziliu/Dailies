import 'package:dailies_v2/database/database.dart';
import 'package:dailies_v2/enums/event_type.dart';
import 'package:drift/drift.dart';

class EventInfoModel {
  int? id;
  final String uid;
  final String calendarId;

  final String title;
  final String? description;
  final String? location;

  final DateTime date;
  final DateTime? start;
  final DateTime? end;

  final String? timezone;
  final String? rrule;

  final EventType type;

  final DateTime createdAt;
  final DateTime lastModified;

  EventInfoModel({
    this.id,
    required this.uid,
    required this.calendarId,

    required this.title,
    this.description,
    this.location,

    required this.date,
    this.start,
    this.end,

    this.timezone,
    this.rrule,

    required this.type,

    required this.createdAt,
    required this.lastModified,
  });
}

class EventCacheInstanceModel implements Comparable<EventCacheInstanceModel> {
  int? id;
  final int eventInfoId;

  final DateTime date;
  final DateTime? start;
  final DateTime? end;

  EventCacheInstanceModel({
    this.id,
    required this.eventInfoId,
    required this.date,
    this.start,
    this.end,
  });

  @override
  int compareTo(EventCacheInstanceModel other) {
    final DateTime d1 = DateTime(date.year, date.month, date.day);
    final DateTime d2 = DateTime(
      other.date.year,
      other.date.month,
      other.date.day,
    );

    if (d1.compareTo(d2) != 0) {
      return d1.compareTo(d2);
    }

    if (start == null && other.start != null) {
      return 1;
    }

    if (start != null && other.start == null) {
      return -1;
    }

    if (start != null && other.start != null) {
      return start!.compareTo(other.start!);
    }

    return eventInfoId.compareTo(other.eventInfoId);
  }
}

class EventUIModel {
  final DateTime date;
  final DateTime? start, end;
  final String title;
  final String? location;

  EventUIModel({
    this.start,
    this.end,
    required this.date,
    required this.title,
    required this.location,
  });

  factory EventUIModel.fromInfoAndInstance({
    required EventCacheInstanceModel instance,
    EventInfoModel? info,
  }) => EventUIModel(
    date: instance.date,
    start: instance.start,
    end: instance.end,
    title: info?.title ?? 'NULL TITLE',
    location: info?.location,
  );
}

extension EventInfoRowMapper on EventInfo {
  EventInfoModel toModel() {
    return EventInfoModel(
      id: id,
      uid: '$calendarId:$id',
      calendarId: calendarId,

      title: title,
      description: description,
      location: location,

      date: DateTime.fromMillisecondsSinceEpoch(date),
      start: dtStart != null
          ? DateTime.fromMillisecondsSinceEpoch(dtStart!)
          : null,
      end: dtEnd != null ? DateTime.fromMillisecondsSinceEpoch(dtEnd!) : null,

      timezone: timezone,
      rrule: rrule,

      type: type,

      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      lastModified: DateTime.fromMillisecondsSinceEpoch(lastModified),
    );
  }
}

extension EventCacheInstanceRowMapper on EventCacheInstance {
  EventCacheInstanceModel toModel() {
    return EventCacheInstanceModel(
      id: id,
      eventInfoId: eventInfoId,
      date: DateTime.fromMillisecondsSinceEpoch(date),
      start: instanceStart != null
          ? DateTime.fromMillisecondsSinceEpoch(instanceStart!)
          : null,
      end: instanceEnd != null
          ? DateTime.fromMillisecondsSinceEpoch(instanceEnd!)
          : null,
    );
  }
}

extension EventInfoModelToCompanion on EventInfoModel {
  EventInfosCompanion toCompanion() {
    return EventInfosCompanion(
      id: Value.absentIfNull(id),
      calendarId: Value(calendarId),

      title: Value(title),
      description: Value.absentIfNull(description),
      location: Value.absentIfNull(location),

      type: Value(type),

      date: Value(date.toUtc().millisecondsSinceEpoch),
      dtStart: Value.absentIfNull(start?.toUtc().millisecondsSinceEpoch),
      dtEnd: Value.absentIfNull(end?.toUtc().millisecondsSinceEpoch),

      timezone: Value.absentIfNull(timezone),
      rrule: Value.absentIfNull(rrule),

      createdAt: Value(createdAt.toUtc().millisecondsSinceEpoch),
      lastModified: Value(lastModified.toUtc().millisecondsSinceEpoch),
    );
  }
}

extension EventCacheInstanceModelToCompanion on EventCacheInstanceModel {
  EventCacheInstancesCompanion toCompanion() {
    return EventCacheInstancesCompanion(
      id: Value.absentIfNull(id),
      date: Value(date.toUtc().millisecondsSinceEpoch),
      eventInfoId: Value(eventInfoId),
      instanceStart: Value.absentIfNull(start?.toUtc().millisecondsSinceEpoch),
      instanceEnd: Value.absentIfNull(end?.toUtc().millisecondsSinceEpoch),
    );
  }
}

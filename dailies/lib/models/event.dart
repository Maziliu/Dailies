import 'package:dailies_v2/database/database.dart';
import 'package:dailies_v2/enums/event_type.dart';
import 'package:drift/drift.dart';

class EventModel implements Comparable<EventModel> {
  int? id;
  final String uid;
  final String calendarId;

  final String title;
  final String? description;
  final String? location;

  final DateTime start;
  final DateTime? end;
  final Duration? duration;

  final String? timezone;
  final String? rrule;

  final String status;
  final EventType type;

  final DateTime createdAt;
  final DateTime lastModified;

  EventModel({
    this.id,
    required this.uid,
    required this.calendarId,

    required this.title,
    this.description,
    this.location,

    required this.start,
    this.end,
    this.duration,

    this.timezone,
    this.rrule,

    required this.status,
    required this.type,

    required this.createdAt,
    required this.lastModified,
  });

  DateTime? get resolvedEnd {
    if (end != null) return end;
    if (duration != null) return start.add(duration!);
    return null;
  }

  Duration? get resolvedDuration {
    if (duration != null) return duration;
    if (end != null) return end!.difference(start);
    return null;
  }

  @override
  int compareTo(EventModel other) {
    final byStart = other.start.compareTo(start);
    if (byStart != 0) return byStart;
    return uid.compareTo(other.uid);
  }
}

extension EventRowMapper on Event {
  EventModel toModel() {
    return EventModel(
      id: id,
      uid: uid,
      calendarId: calendarId,

      title: title,
      description: description,
      location: location,

      start: DateTime.fromMillisecondsSinceEpoch(dtStart),
      end: dtEnd != null ? DateTime.fromMillisecondsSinceEpoch(dtEnd!) : null,
      duration: duration != null ? Duration(seconds: duration!) : null,

      timezone: timezone,
      rrule: rrule,

      status: status,
      type: eventType,

      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      lastModified: DateTime.fromMillisecondsSinceEpoch(lastModified),
    );
  }
}

extension EventModelToCompanion on EventModel {
  EventsCompanion toCompanion() {
    return EventsCompanion(
      id: Value.absentIfNull(id),
      uid: Value(uid),
      calendarId: Value(calendarId),

      title: Value(title),
      description: Value.absentIfNull(description),
      location: Value.absentIfNull(location),

      dtStart: Value(start.toUtc().millisecondsSinceEpoch),
      dtEnd: Value.absentIfNull(end?.toUtc().millisecondsSinceEpoch),
      duration: Value.absentIfNull(duration?.inSeconds),

      timezone: Value.absentIfNull(timezone),
      rrule: Value.absentIfNull(rrule),

      status: Value(status),
      eventType: Value(type),

      createdAt: Value(createdAt.toUtc().millisecondsSinceEpoch),
      lastModified: Value(lastModified.toUtc().millisecondsSinceEpoch),
    );
  }
}

import 'package:dailies_v2/database/database.dart';

class EventModel {
  final int id;
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

  final DateTime createdAt;
  final DateTime lastModified;

  const EventModel({
    required this.id,
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

      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      lastModified: DateTime.fromMillisecondsSinceEpoch(lastModified),
    );
  }
}

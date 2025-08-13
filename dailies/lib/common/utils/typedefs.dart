import 'package:dailies/common/utils/pair.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:flutter/material.dart';

typedef EventTimeSlotPair = Pair<Event, TimeSlot>;
typedef ScheduleListBuilder = Widget Function(Pair<Event, TimeSlot>);

import 'package:dailies/common/enums/database_type.dart';
import 'package:dailies/data/database/drift/concretes/daos/drift_event_dao.dart';
import 'package:dailies/data/database/drift/concretes/daos/drift_time_slot_dao.dart';
import 'package:dailies/data/database/drift/concretes/mappers/drift_event_mapper.dart';
import 'package:dailies/data/database/drift/concretes/mappers/drift_time_slot_mapper.dart';
import 'package:dailies/data/database/drift/drift_database.dart';
import 'package:dailies/data/dao/event_dao.dart';
import 'package:dailies/data/dao/time_slot_dao.dart';
import 'package:dailies/data/mapper/event_mapper.dart';
import 'package:dailies/data/mapper/time_slot_mapper.dart';
import 'package:dailies/data/repositories/event_repository.dart';
import 'package:dailies/data/repositories/time_slot_repository.dart';
import 'package:get_it/get_it.dart';

Future<void> setUpDataLayer(GetIt injector) async {
  //Database
  injector.registerSingleton<AppDatabase>(AppDatabase());

  //DAOs
  injector.registerLazySingleton<TimeSlotDao<DriftTimeSlot, DriftTimeSlotsCompanion>>(
    () => DriftTimeSlotDao(injector<AppDatabase>()),
    instanceName: DatabaseType.Local.name,
  );

  injector.registerLazySingleton<EventDao<DriftEvent, DriftEventsCompanion>>(
    () => DriftEventDao(injector<AppDatabase>()),
    instanceName: DatabaseType.Local.name,
  );

  //Mappers
  injector.registerLazySingleton<TimeSlotMapper<DriftTimeSlot, DriftTimeSlotsCompanion>>(() => DriftTimeSlotMapper(), instanceName: DatabaseType.Local.name);
  injector.registerLazySingleton<EventMapper<DriftEvent, DriftEventsCompanion>>(() => DriftEventMapper(), instanceName: DatabaseType.Local.name);

  //Repositories
  injector.registerLazySingleton(
    () => TimeSlotRepository(
      dao: injector<TimeSlotDao<DriftTimeSlot, DriftTimeSlotsCompanion>>(instanceName: DatabaseType.Local.name),
      mapper: injector<TimeSlotMapper<DriftTimeSlot, DriftTimeSlotsCompanion>>(instanceName: DatabaseType.Local.name),
    ),
  );
  injector.registerLazySingleton(
    () => EventRepository(
      dao: injector<EventDao<DriftEvent, DriftEventsCompanion>>(instanceName: DatabaseType.Local.name),
      mapper: injector<EventMapper<DriftEvent, DriftEventsCompanion>>(instanceName: DatabaseType.Local.name),
    ),
  );
}

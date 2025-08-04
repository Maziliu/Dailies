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
  injector.registerLazySingleton<TimeSlotDao>(() => DriftTimeSlotDao(injector<AppDatabase>()), instanceName: DatabaseType.Local.name);

  injector.registerLazySingleton<EventDao>(() => DriftEventDao(injector<AppDatabase>()), instanceName: DatabaseType.Local.name);

  //Mappers
  injector.registerLazySingleton<TimeSlotMapper>(() => DriftTimeSlotMapper(), instanceName: DatabaseType.Local.name);
  injector.registerLazySingleton<EventMapper>(() => DriftEventMapper(), instanceName: DatabaseType.Local.name);

  //Repositories
  injector.registerLazySingleton(
    () => TimeSlotRepository(
      dao: injector<TimeSlotDao>(instanceName: DatabaseType.Local.name),
      mapper: injector<TimeSlotMapper>(instanceName: DatabaseType.Local.name),
    ),
  );
  injector.registerLazySingleton(
    () => EventRepository(dao: injector<EventDao>(instanceName: DatabaseType.Local.name), mapper: injector<EventMapper>(instanceName: DatabaseType.Local.name)),
  );
}

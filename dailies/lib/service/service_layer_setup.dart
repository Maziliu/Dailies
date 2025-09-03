import 'package:dailies/data/database/drift/drift_database.dart';
import 'package:dailies/data/repositories/event_repository.dart';
import 'package:dailies/data/repositories/stamina_repository.dart';
import 'package:dailies/data/repositories/time_slot_pattern_repository.dart';
import 'package:dailies/data/repositories/time_slot_repository.dart';
import 'package:dailies/service/global_error_service.dart';
import 'package:dailies/service/notification/notification_service.dart';
import 'package:dailies/service/repository/event_repository_service.dart';
import 'package:dailies/service/repository/stamina_repository_service.dart';
import 'package:dailies/service/repository/time_slot_pattern_repository_service.dart';
import 'package:dailies/service/repository/time_slot_repository_service.dart';
import 'package:get_it/get_it.dart';

Future<void> setUpServiceLayer(GetIt injector) async {
  //Notificaiton Service
  injector.registerLazySingleton(() => NotificationService()..initialize());

  //Error Stream
  injector.registerLazySingleton(GlobalErrorService.new);

  //Repo Services
  injector.registerLazySingleton(() => TimeSlotRepositoryService(timeSlotRepository: injector<TimeSlotRepository<DriftTimeSlot, DriftTimeSlotsCompanion>>()));

  injector.registerLazySingleton(
    () => EventRepositoryService(
      timeSlotService: injector<TimeSlotRepositoryService>(),
      eventRepository: injector<EventRepository<DriftEvent, DriftEventsCompanion>>(),
      patternService: injector<TimeSlotPatternRepositoryService>(),
    ),
  );

  injector.registerLazySingleton(
    () => StaminaRepositoryService(
      repository: injector<StaminaRepository<DriftStamina, DriftStaminasCompanion>>(),
      notificationService: injector<NotificationService>(),
    ),
  );

  injector.registerLazySingleton(() => TimeSlotPatternRepositoryService(patternRepository: injector<TimeSlotPatternRepository>()));
}

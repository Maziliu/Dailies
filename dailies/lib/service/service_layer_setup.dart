import 'package:dailies/data/repositories/event_repository.dart';
import 'package:dailies/data/repositories/time_slot_repository.dart';
import 'package:dailies/service/repository/event_repository_service.dart';
import 'package:dailies/service/repository/time_slot_repository_service.dart';
import 'package:get_it/get_it.dart';

void setUpServiceLayer(GetIt injector) {
  //Repo Services
  injector.registerLazySingleton(() => TimeSlotRepositoryService(timeSlotRepository: injector<TimeSlotRepository>()));

  injector.registerLazySingleton(
    () => EventRepositoryService(timeSlotService: injector<TimeSlotRepositoryService>(), eventRepository: injector<EventRepository>()),
  );
}

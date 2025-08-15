import 'package:dailies/service/repository/event_repository_service.dart';
import 'package:dailies/service/repository/stamina_repository_service.dart';
import 'package:dailies/ui/views/calendar/calendar_page_view_model.dart';
import 'package:dailies/ui/views/dashboard/dashboard_view_model.dart';
import 'package:dailies/ui/views/shared/calendar_view_model.dart';
import 'package:dailies/ui/views/overview/overview_page_view_model.dart';
import 'package:dailies/ui/views/overview/gacha%20section/gacha_view_model.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/file_upload_view_model.dart';
import 'package:dailies/ui/views/upload/upload_view_model.dart';
import 'package:get_it/get_it.dart';

Future<void> setUpPresentationLayer(GetIt injector) async {
  //Service View Models
  injector.registerLazySingleton<EventsViewModel>(() => EventsViewModel(eventRepositoryService: injector<EventRepositoryService>()));
  injector.registerLazySingleton<CalendarViewModel>(() => CalendarViewModel());
  injector.registerLazySingleton<GachaViewModel>(() => GachaViewModel(staminaRepositoryService: injector<StaminaRepositoryService>()));
  injector.registerLazySingleton<FileUploadViewModel>(() => FileUploadViewModel());

  //Page View Models
  injector.registerLazySingleton<DashboardViewModel>(() => DashboardViewModel());
  injector.registerLazySingleton<OverviewPageViewModel>(
    () => OverviewPageViewModel(staminaViewModel: injector<GachaViewModel>(), eventsViewModel: injector<EventsViewModel>()),
  );
  injector.registerLazySingleton<CalendarPageViewModel>(
    () => CalendarPageViewModel(calendarViewModel: injector<CalendarViewModel>(), eventsViewModel: injector<EventsViewModel>()),
  );
  injector.registerLazySingleton<UploadViewModel>(() => UploadViewModel(fileUploadViewModel: injector<FileUploadViewModel>()));
}

import 'package:dailies/service/repository/event_repository_service.dart';
import 'package:dailies/ui/views/dashboard/dashboard_view_model.dart';
import 'package:dailies/ui/views/calendar/calendar_view_model.dart';
import 'package:dailies/ui/views/overview/overview_view_model.dart';
import 'package:dailies/ui/views/upload/upload_view_model.dart';
import 'package:get_it/get_it.dart';

void setUpPresentationLayer(GetIt injector) {
  injector.registerLazySingleton<DashboardViewModel>(() => DashboardViewModel());
  injector.registerLazySingleton<OverviewViewModel>(() => OverviewViewModel());
  injector.registerLazySingleton<CalendarViewModel>(() => CalendarViewModel(eventRepositoryService: injector<EventRepositoryService>()));
  injector.registerLazySingleton<UploadViewModel>(() => UploadViewModel());
}

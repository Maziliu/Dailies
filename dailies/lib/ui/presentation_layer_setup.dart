import 'package:dailies/ui/views/dashboard/dashboard_view_model.dart';
import 'package:dailies/ui/views/calendar/calendar_view_model.dart';
import 'package:dailies/ui/views/overview/overview_view_model.dart';
import 'package:dailies/ui/views/upload/upload_view_model.dart';
import 'package:get_it/get_it.dart';

void setUpPresentationLayer(GetIt injector) {
  injector.registerFactory<DashboardViewModel>(() => DashboardViewModel());
  injector.registerFactory<OverviewViewModel>(() => OverviewViewModel());
  injector.registerFactory<CalendarViewModel>(() => CalendarViewModel());
  injector.registerFactory<UploadViewModel>(() => UploadViewModel());
}

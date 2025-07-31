import 'package:dailies/ui/views/dashboard/dashboard_view_model.dart';
import 'package:dailies/ui/views/events/events_view_model.dart';
import 'package:dailies/ui/views/overview/overview_view_model.dart';
import 'package:dailies/ui/views/upload/upload_view_model.dart';
import 'package:get_it/get_it.dart';

void setUpPresentationLayer(GetIt injector) {
  injector.registerFactory<DashboardViewModel>(() => DashboardViewModel());
  injector.registerFactory<OverviewViewModel>(() => OverviewViewModel());
  injector.registerFactory<EventsViewModel>(() => EventsViewModel());
  injector.registerFactory<UploadViewModel>(() => UploadViewModel());
}

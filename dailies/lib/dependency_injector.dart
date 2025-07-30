import 'package:dailies/presentation/views/dashboard/dashboard_view_model.dart';
import 'package:dailies/presentation/views/events/events_view_model.dart';
import 'package:dailies/presentation/views/overview/overview_view_model.dart';
import 'package:dailies/presentation/views/upload/upload_view_model.dart';
import 'package:get_it/get_it.dart';

final GetIt injector = GetIt.instance;

void setUpDependencies() {
  injector.registerFactory(() => DashboardViewModel());
  injector.registerFactory(() => OverviewViewModel());
  injector.registerFactory(() => EventsViewModel());
  injector.registerFactory(() => UploadViewModel());
}

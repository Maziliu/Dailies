import 'package:dailies/data/data_layer_setup.dart';
import 'package:dailies/ui/presentation_layer_setup.dart';
import 'package:dailies/service/service_layer_setup.dart';
import 'package:get_it/get_it.dart';

final GetIt injector = GetIt.instance;

Future<void> setUpDependencies() async {
  await setUpDataLayer(injector);
  await setUpServiceLayer(injector);
  await setUpPresentationLayer(injector);
}

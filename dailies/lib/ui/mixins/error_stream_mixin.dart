import 'package:dailies/dependency_setup.dart';
import 'package:dailies/service/global_error_service.dart';

mixin ErrorStreamMixin {
  GlobalErrorService get _errorService => injector<GlobalErrorService>();

  void emitError(Exception exception) => _errorService.emitError(exception);
}

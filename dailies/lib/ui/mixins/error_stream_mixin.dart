import 'package:dailies/common/exceptions/app_exception.dart';
import 'package:dailies/dependency_setup.dart';
import 'package:dailies/service/global_error_service.dart';

mixin ErrorStreamMixin {
  GloablErrorService get _errorService => injector<GloablErrorService>();

  void emitError(Exception exception) => _errorService.emitError(exception);
}

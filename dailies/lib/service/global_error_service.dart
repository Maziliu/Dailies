import 'dart:async';

import 'package:dailies/common/exceptions/app_exception.dart';

class GloablErrorService {
  final StreamController<Exception> _errorStream = StreamController<Exception>.broadcast();

  Stream<Exception> get errorStream => _errorStream.stream;

  void emitError(Exception exception) {
    if (!_errorStream.isClosed) {
      _errorStream.add(exception);
    }
  }

  void dispose() {
    _errorStream.close();
  }
}

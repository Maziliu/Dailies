import 'package:dailies/common/exceptions/util_exceptions.dart';
import 'package:dailies/common/utils/result.dart';

Future<Result<T>> guardedAsyncExcecute<T>(Future<T> Function() operation, [Exception? exceptionToThrow]) async {
  try {
    return Result.ok(await operation());
  } on Exception catch (caughtException) {
    return Result.error(exceptionToThrow ?? caughtException);
  }
}

Result<T> performOperationOnResultIfNotError<T, K>(Result<K> result, T Function(K subject) operation) {
  try {
    switch (result) {
      case Ok<K>(value: K value):
        return Result.ok(operation(value));
      case Error<K>(error: Exception exception):
        return Result.error(exception);
    }
  } on Exception {
    return Result.error(FailedUtilityOperationOnResult());
  }
}

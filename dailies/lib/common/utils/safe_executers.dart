import 'package:dailies/common/utils/result.dart';

Future<Result<T>> guardedAsyncExcecute<T>(
  Future<T> Function() operation, [
  Exception? exceptionToThrow,
]) async {
  try {
    return Result.ok(await operation());
  } on Exception catch (caughtException) {
    return Result.error(exceptionToThrow ?? caughtException);
  }
}

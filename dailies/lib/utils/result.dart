sealed class Result<T> {
  const Result();

  factory Result.ok(T value) => Ok<T>(value);
  factory Result.error(Failure failure) => Error<T>(failure);
}

final class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);
}

final class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);
}

sealed class Failure {
  String message;
  Failure(this.message);
}

class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}

class GenerationFailure extends Failure {
  GenerationFailure(super.message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

class ConversionFailure extends Failure {
  ConversionFailure(super.message);
}

class FileExtractionFailure extends Failure {
  FileExtractionFailure(super.message);
}

class ICSParseFailure extends Failure {
  ICSParseFailure(super.message);
}

class GenericFailure extends Failure {
  GenericFailure(super.message);
}

class EnvironmentVariableFailure extends Failure {
  EnvironmentVariableFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(super.message);
}

class NoBackendAPIKeysFailure extends Failure {
  NoBackendAPIKeysFailure(super.message);
}

Future<Result<T>> guardedAsyncExecute<T>(
  Future<T> Function() action,
  Failure error,
) async {
  try {
    return Result.ok(await action());
  } catch (e) {
    error.message = '${error.message} $e';
    return Result.error(error);
  }
}

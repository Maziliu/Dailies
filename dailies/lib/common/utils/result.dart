sealed class Result<K> {
  const Result();

  factory Result.ok(K value) => Ok(value);

  factory Result.error(Exception exception) => Error(exception);
}

final class Ok<K> extends Result<K> {
  final K _value;

  const Ok(K value) : _value = value;

  K get value => _value;
}

final class Error<K> extends Result<K> {
  final Exception _error;

  const Error(Exception error) : _error = error;

  Exception get error => _error;
}

import 'package:dailies_v2/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';

T expectOk<T>(Result<T> result) {
  switch (result) {
    case Ok<T>(value: final v):
      return v;
    case Error<T>(failure: final f):
      fail('Expected Ok, got Error: ${f.message}');
  }
}

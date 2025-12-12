import 'package:dailies/common/exceptions/app_exception.dart';

class UnableToParseException extends AppException {
  UnableToParseException({String? specificFile})
    : super(
        customErrorMessage:
            specificFile == null
                ? 'Unable to parse'
                : '$specificFile was unable to be parsed',
      );
}

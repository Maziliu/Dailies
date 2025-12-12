import 'package:dailies/common/exceptions/app_exception.dart';

class NoAPIKeyException extends AppException {
  NoAPIKeyException() : super(customErrorMessage: 'No API Key');
}

class InsufficientCreditsException extends AppException {
  //402
  InsufficientCreditsException()
    : super(customErrorMessage: 'API Key insufficient credits');
}

class ModeratedContentException extends AppException {
  //403
  ModeratedContentException(String contentModerated)
    : super(
        customErrorMessage:
            'Input was flagged and moderated: $contentModerated',
      );
}

class RateLimitedException extends AppException {
  //429
  RateLimitedException() : super(customErrorMessage: 'API Key out of requests');
}

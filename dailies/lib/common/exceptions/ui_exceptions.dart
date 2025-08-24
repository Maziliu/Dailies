import 'package:dailies/common/exceptions/app_exception.dart';

class IncompleteFormException extends AppException {
  IncompleteFormException({String? specificForm}) : super(customErrorMessage: specificForm == null ? 'Form is incomplete' : '$specificForm form is incomplete');
}

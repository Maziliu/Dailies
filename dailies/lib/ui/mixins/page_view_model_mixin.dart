import 'package:flutter/material.dart';

mixin PageViewModelMixin {
  final ValueNotifier<List<String>> errorMessages = ValueNotifier([]);

  void updateErrorMessages(List<Exception> exceptions) {
    errorMessages.value = [...errorMessages.value, ...exceptions.map((exception) => exception.toString())];
  }

  //Mutate the list directly as to not trigger the observers
  void resolveErrorMessages(String resolvedErrorMessage) {
    errorMessages.value.remove(resolvedErrorMessage);
  }
}

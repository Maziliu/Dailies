import 'package:flutter/material.dart';

mixin ServiceViewModelMixin {
  final ValueNotifier<List<Exception>> viewModelErrors = ValueNotifier([]);

  void updateViewModelErrors(Exception exception) {
    viewModelErrors.value = [...viewModelErrors.value, exception];
  }
}

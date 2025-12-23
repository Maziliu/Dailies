import 'package:dailies_v2/main.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:flutter/material.dart';

void showSuccessSnackbar(String successMessage) {
  if (GLOBAL_SCAFFOLD_MESSENGER_KEY.currentState != null &&
      GLOBAL_SCAFFOLD_MESSENGER_KEY.currentContext != null) {
    final ThemeData theme = Theme.of(
      GLOBAL_SCAFFOLD_MESSENGER_KEY.currentContext!,
    );

    GLOBAL_SCAFFOLD_MESSENGER_KEY.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          successMessage,
          style: TextStyle(color: theme.colorScheme.surface),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}

void showErrorSnackbar({required Failure failure, String? customMessage}) {
  if (GLOBAL_SCAFFOLD_MESSENGER_KEY.currentState != null &&
      GLOBAL_SCAFFOLD_MESSENGER_KEY.currentContext != null) {
    final ThemeData theme = Theme.of(
      GLOBAL_SCAFFOLD_MESSENGER_KEY.currentContext!,
    );

    GLOBAL_SCAFFOLD_MESSENGER_KEY.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          customMessage ?? failure.message,
          style: TextStyle(color: theme.colorScheme.surface),
        ),
        backgroundColor: theme.colorScheme.error,
      ),
    );
  }
}

import 'package:dailies/main.dart';
import 'package:flutter/material.dart';

void showErrorSnackbar({Exception? exception, String? message}) {
  GLOBAL_SCAFFOLD_MESSENGER_KEY.currentState!.showSnackBar(
    SnackBar(content: Text('${exception?.toString() ?? ''} ${message ?? ''}'), backgroundColor: Colors.red),
  );
}

import 'package:dailies/main.dart';
import 'package:flutter/material.dart';

void showErrorSnackbar({Exception? exception, String? message}) {
  GLOBAL_SCAFFOLD_MESSENGER_KEY.currentState!.showSnackBar(
    SnackBar(
      content: Text('${exception?.toString() ?? ''} ${message ?? ''}'),
      backgroundColor: Colors.red,
    ),
  );
}

String formatTitle(String input) {
  if (input.isEmpty) return input;

  return input
      .split(' ')
      .map((word) {
        if (word.isEmpty) return word;
        final first = word[0].toUpperCase();
        final rest = word.length > 1 ? word.substring(1).toLowerCase() : '';
        return '$first$rest';
      })
      .join(' ');
}

String formatAssetName(String filename) {
  final nameWithoutExtension = filename.split('.').first;

  final noUnderscoresOrNonAlphaNumeric = nameWithoutExtension.replaceAll(
    RegExp(r'[^a-zA-Z0-9]+'),
    ' ',
  );

  final words = noUnderscoresOrNonAlphaNumeric
      .split(' ')
      .where((word) => word.isNotEmpty);

  final capitalizedWords = words.map(
    (word) => word[0].toUpperCase() + word.substring(1).toLowerCase(),
  );

  return capitalizedWords.join(' ');
}

String formatFileSize(int bytes) {
  if (bytes < 1000) return '$bytes B';
  if (bytes < 1000 * 1000) return '${(bytes / 1000).toStringAsFixed(1)} kB';
  if (bytes < 1000 * 1000 * 1000)
    return '${(bytes / (1000 * 1000)).toStringAsFixed(1)} MB';
  return '${(bytes / (1000 * 1000 * 1000)).toStringAsFixed(1)} GB';
}

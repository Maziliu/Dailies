bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }

  return a.year == b.year && a.month == b.month && a.day == b.day;
}

String formatFileSize(int bytes) {
  if (bytes < 1000) return '$bytes B';
  if (bytes < 1000 * 1000) return '${(bytes / 1000).toStringAsFixed(1)} kB';
  if (bytes < 1000 * 1000 * 1000) {
    return '${(bytes / (1000 * 1000)).toStringAsFixed(1)} MB';
  }
  return '${(bytes / (1000 * 1000 * 1000)).toStringAsFixed(1)} GB';
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

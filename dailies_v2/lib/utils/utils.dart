bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }

  return a.year == b.year && a.month == b.month && a.day == b.day;
}

String formatFileSize(int bytes) {
  if (bytes < 1000) return '$bytes B';
  if (bytes < 1000 * 1000) return '${(bytes / 1000).toStringAsFixed(1)} kB';
  if (bytes < 1000 * 1000 * 1000)
    return '${(bytes / (1000 * 1000)).toStringAsFixed(1)} MB';
  return '${(bytes / (1000 * 1000 * 1000)).toStringAsFixed(1)} GB';
}

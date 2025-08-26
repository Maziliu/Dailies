List<DateTime> parseExclusionDates(List<String> exDateLines) {
  final excludeDates = <DateTime>[];

  for (String line in exDateLines) {
    if (line.toUpperCase().startsWith('EXDATE')) {
      final colonIndex = line.indexOf(':');
      if (colonIndex != -1) {
        final dateString = line.substring(colonIndex + 1);
        try {
          excludeDates.add(parseDateString(dateString));
        } catch (e) {
          print('Warning: Could not parse EXDATE: $line');
        }
      }
    }
  }

  return excludeDates;
}

DateTime parseDateString(String icsDateString) {
  final year = int.parse(icsDateString.substring(0, 4));
  final month = int.parse(icsDateString.substring(4, 6));
  final day = int.parse(icsDateString.substring(6, 8));

  if (icsDateString.length == 8) {
    //YYYYMMDD format
    return DateTime(year, month, day);
  } else if (icsDateString.length == 15 || icsDateString.length == 16) {
    //YYYYMMDDTHHMMSS or YYYYMMDDTHHMMSSZ format
    final hour = int.parse(icsDateString.substring(9, 11));
    final minute = int.parse(icsDateString.substring(11, 13));
    final second = int.parse(icsDateString.substring(13, 15));

    if (icsDateString.endsWith('Z')) {
      return DateTime.utc(year, month, day, hour, minute, second);
    } else {
      return DateTime(year, month, day, hour, minute, second);
    }
  }

  throw ArgumentError('Invalid UNTIL date format: $icsDateString');
}

DateTime normalizeDateTime(DateTime date) => DateTime(date.year, date.month, date.day);

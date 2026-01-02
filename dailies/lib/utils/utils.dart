import 'package:async/async.dart' hide Result;
import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/utils/result.dart';

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

String formatDateToICS(DateTime date) {
  final utc = DateTime.utc(date.year, date.month, date.day, 23, 59, 59);

  return '${utc.year.toString().padLeft(4, '0')}'
      '${utc.month.toString().padLeft(2, '0')}'
      '${utc.day.toString().padLeft(2, '0')}'
      'T'
      '${utc.hour.toString().padLeft(2, '0')}'
      '${utc.minute.toString().padLeft(2, '0')}'
      '${utc.second.toString().padLeft(2, '0')}Z';
}

Result<DateTime> predictGachaNotificationTime({
  required StaminaModel stamina,
  double threshold = 0.9,
}) {
  if (threshold <= 0 || threshold > 1) {
    return Result.error(
      InvalidNotificationThreshold(
        'Threshold: $threshold must be in range (0, 1]',
      ),
    );
  }

  final now = DateTime.now();

  final int thresholdEnergy = (stamina.maxStamina * threshold).ceil();

  if (stamina.staminaOfLastestReset >= thresholdEnergy) {
    return Result.ok(now);
  }

  final int rechargeSeconds = stamina.rechargeTime.inSeconds;

  final int elapsed = now.difference(stamina.timeOfLastReset).inSeconds;
  final int safeElapsed = elapsed < 0 ? 0 : elapsed;

  final int gained = safeElapsed ~/ rechargeSeconds;
  final int currentEnergy = (stamina.staminaOfLastestReset + gained).clamp(
    0,
    stamina.maxStamina,
  );

  if (currentEnergy >= thresholdEnergy) {
    return Result.ok(now);
  }

  final int energyUntilThreshold = thresholdEnergy - currentEnergy;

  final int remainder = safeElapsed % rechargeSeconds;
  final int secondsUntilNextTick = remainder == 0
      ? 0
      : (rechargeSeconds - remainder);

  final int totalSeconds = energyUntilThreshold == 0
      ? 0
      : (secondsUntilNextTick + (energyUntilThreshold - 1) * rechargeSeconds);

  return Result.ok(now.add(Duration(seconds: totalSeconds)));
}

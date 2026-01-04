import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:dailies_v2/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart';

void main() {
  setUpAll(initializeTimeZones);

  test('Time prediction with default threshold', () {
    final now = DateTime.now();

    final StaminaModel testStamina = StaminaModel(
      id: 100,
      gachaTitle: 'Test',
      rechargeTime: const Duration(seconds: 360),
      maxStamina: 240,
      staminaOfLastestReset: 0,
      imageName: '/test',
      timeOfLastReset: now,
    );

    final result = predictGachaNotificationTime(stamina: testStamina);

    expect(result is Ok<DateTime>, true);

    final predicted = (result as Ok<DateTime>).value;

    final expected = now.add(const Duration(seconds: 216 * 360));

    expect(
      predicted.difference(expected).inSeconds.abs(),
      lessThanOrEqualTo(2),
    );
  });

  test('Time prediction with custom threshold', () {
    final now = DateTime.now();

    final StaminaModel testStamina = StaminaModel(
      id: 100,
      gachaTitle: 'Test',
      rechargeTime: const Duration(seconds: 360),
      maxStamina: 240,
      staminaOfLastestReset: 0,
      imageName: '/test',
      timeOfLastReset: now,
    );

    final result = predictGachaNotificationTime(
      stamina: testStamina,
      threshold: 0.98,
    );

    expect(result is Ok<DateTime>, true);

    final predicted = (result as Ok<DateTime>).value;

    final expected = now.add(const Duration(seconds: 236 * 360));

    expect(
      predicted.difference(expected).inSeconds.abs(),
      lessThanOrEqualTo(2),
    );
  });
}

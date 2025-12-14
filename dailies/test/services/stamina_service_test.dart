import 'package:dailies_v2/database/daos/stamina_dao.dart';
import 'package:dailies_v2/database/database.dart';
import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/services/gacha/stamina_service.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import '../helpers/test_database.dart';

void main() {
  late Database db;
  late StaminaDao dao;
  late StaminaService service;
  late StaminaModel stamina;

  setUp(() async {
    db = createTestDatabase();
    dao = StaminaDao(db);
    service = StaminaService(dao: dao);

    stamina = StaminaModel(
      staminaOfLastestReset: 10,
      maxStamina: 20,
      gachaTitle: 'Test',
      timeOfLastReset: DateTime(2024),
      imageName: '',
      rechargeTime: const Duration(days: 1),
    );
  });

  tearDown(() async {
    await db.close();
  });

  // -------------------------
  // insertStamina
  // -------------------------

  test('insertStamina inserts stamina and returns id', () async {
    final result = await service.insertStamina(stamina);

    expect(result, isA<Ok<int>>());

    final all = await dao.getAll();
    expect(all.length, 1);
    expect(all.first.staminaOfLastReset, 10);
  });

  // -------------------------
  // setStamina
  // -------------------------

  test('spendStamina reduces stamina', () async {
    final id = await dao.insert(stamina.toCompanion());

    final result = await service.setStamina(id, 3);

    expect(result, isA<Ok<StaminaModel>>());

    final updated = (result as Ok).value;
    expect(updated.staminaOfLastestReset, 3);
  });

  test('setStamina never goes below zero', () async {
    final id = await dao.insert(stamina.toCompanion());

    final result = await service.setStamina(id, 20);

    expect(result, isA<Ok<StaminaModel>>());
    expect((result as Ok).value.staminaOfLastestReset, 20);
  });

  // -------------------------
  // validation
  // -------------------------

  test('spendStamina fails for invalid amount', () async {
    final result = await service.setStamina(1, 0);

    expect(result, isA<Error>());
    expect((result as Error).failure, isA<ValidationFailure>());
  });

  // -------------------------
  // deleteStamina
  // -------------------------

  test('deleteStamina removes stamina', () async {
    final id = await dao.insert(stamina.toCompanion());

    final result = await service.deleteStamina(id);

    expect(result, isA<Ok<void>>());

    final all = await dao.getAll();
    expect(all, isEmpty);
  });

  // -------------------------
  // getAllStaminas
  // -------------------------

  test('getAllStaminas returns all rows', () async {
    await dao.insert(stamina.toCompanion());
    await dao.insert(
      StaminaModel(
        staminaOfLastestReset: 5,
        maxStamina: 20,
        gachaTitle: 'Test B',
        timeOfLastReset: DateTime(2024),
        imageName: '',
        rechargeTime: const Duration(seconds: 20),
      ).toCompanion(),
    );

    final result = await service.getAllStaminas();

    expect(result, isA<Ok<List<StaminaModel>>>());
    expect((result as Ok).value.length, 2);
  });
}

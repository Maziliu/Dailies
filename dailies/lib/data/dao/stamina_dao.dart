import 'package:dailies/data/dao/generic_dao.dart';

abstract class StaminaDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> extends GenericDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> {
  Future<List<TIncomingDatabaseModel>> getAllStaminaEntries();
}

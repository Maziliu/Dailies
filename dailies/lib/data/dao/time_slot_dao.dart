import 'package:dailies/data/dao/generic_dao.dart';

abstract class TimeSlotDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> extends GenericDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> {
  Future<List<TIncomingDatabaseModel>> getTimeSlotsInDateTimeRange(DateTime lowerBound, DateTime upperBound);
}

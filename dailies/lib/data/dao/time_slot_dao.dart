import 'package:dailies/data/dao/generic_dao.dart';

abstract class TimeSlotDao<TGetType, TInsertType> extends GenericDao<TGetType, TInsertType> {
  Future<List<TGetType>> getTimeSlotsInDateTimeRange(DateTime lowerBound, DateTime upperBound);
}

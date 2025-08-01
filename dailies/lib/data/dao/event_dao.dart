import 'package:dailies/data/dao/generic_dao.dart';

abstract class EventDao<TGetType, TInsertType> extends GenericDao<TGetType, TInsertType> {
  Future<List<TGetType>> getEventsWithTimeSlotIds(List<int> timeSlotIds);
}

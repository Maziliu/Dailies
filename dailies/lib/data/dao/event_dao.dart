import 'package:dailies/data/dao/generic_dao.dart';

abstract class EventDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> extends GenericDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> {
  Future<List<TIncomingDatabaseModel>> getEventsWithTimeSlotIds(List<int> timeSlotIds);
}

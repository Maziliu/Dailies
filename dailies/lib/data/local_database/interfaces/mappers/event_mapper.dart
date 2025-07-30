import 'package:dailies/data/local_database/interfaces/mappers/mixins/generic_to_data_model.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';

abstract class EventMapper<TDataModelType>
    with GenericToDataModelMixin<TDataModelType, Event> {
  Event toDomainModel(TDataModelType dataModel, List<TimeSlot> timeSlots);
}

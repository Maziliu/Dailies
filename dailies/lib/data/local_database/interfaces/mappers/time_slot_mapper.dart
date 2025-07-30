import 'package:dailies/data/local_database/interfaces/mappers/mixins/generic_to_data_model.dart';
import 'package:dailies/data/local_database/interfaces/mappers/mixins/generic_to_domain_model.dart';
import 'package:dailies/data/models/time_slot.dart';

abstract class TimeSlotMapper<TDataModelType>
    with
        GenericToDataModelMixin<TDataModelType, TimeSlot>,
        GenericToDomainModel<TimeSlot, TDataModelType> {}
